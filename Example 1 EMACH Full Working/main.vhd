


-- This is an 8 bit main actually will work 0 - 255 will have a trigger 

library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;
use work.functions.all;





      entity main is
          port ( 
	                 clk                       :in   flag;
 	                 reset                     :in   flag
                );
      end main;

  architecture arc_main of main is
  ------------------------- COMPONENTS DECLARATION ---------------------------
  
  component counter_imem 
          port ( 
	                 clk,reset,jmp             :in   flag;
	                 counter_imem_in           :in   counter_imem_address;
	                 counter_imem_out          :out  counter_imem_address :=universal_high_std(imem_address_size-1 downto 0)
	                                                                               

                );
  end component;
  ------------------------------------------------------------------------------
  
        component counter 
          port ( 
	                 clk,clkk                  :in  flag;
	                 done                      :out flag;
	                 start_val,end_val         :in  counter_address;
	                 jump                      :in  counter_address :="0000000000001";
 	                 out_counter               :out counter_address;
                   done_on_last_val          :out flag ;
                   reset :in flag
                    
                   	                 

                );
      end component;
  
 ------------------------------------------------------------------------------
  component imem
 port ( 
	         
	         pcin                                                     :in  imem_address;
	         imem_opcode                                              :out imem_opcode;
	         imem_matrix_loc_a,imem_matrix_loc_b,imem_matrix_loc_c    :out imem_matrix_address;
	         imem_jump_addrsss                                        :out counter_imem_address;
	         forced_mem_address_w                                     :out memory_address;
	         forced_mem_address_r_b                                   :out memory_address;	         
	         forced_mem_address_r_c                                   :out memory_address;	         	         
	         forced_mem_value                                         :out mem_cell;	         
 	         forced_mem_value_fp                                      :out mem_cell;
 	         
 	         
 	         
           imem_mem_manager_write_loc                               :out mem_manager_address;
           imem_mem_manager_write_TR                                :out mem_manager_total_rows;           
           imem_mem_manager_write_TC                                :out mem_manager_total_cols;
           
           imem_mat_name                                            :out mem_manager_address; 
           imem_row_out                                             :out counter_address;
           imem_col_out                                             :out counter_address

);

  end component;
 ------------------------------------------------------------------------------  
  component mem_manager 
      port ( 
             clk,reset                       :in flag;
             mem_manager_rw                  :in sel_3bit;
             mem_manager_address_a           :in mem_manager_address;  
             mem_manager_address_b           :in mem_manager_address;
             mem_manager_address_c           :in mem_manager_address;  
                        
             mem_manager_total_rows_a        :inout mem_manager_total_rows;
             mem_manager_total_cols_a        :inout mem_manager_total_cols;
             mem_manager_base_address_a      :inout mem_manager_base_address;
             
                        
             mem_manager_total_rows_b        :out mem_manager_total_rows;
             mem_manager_total_cols_b        :out mem_manager_total_cols;
             mem_manager_base_address_b      :out mem_manager_base_address;     
  
                        
             mem_manager_total_rows_c        :out mem_manager_total_rows;
             mem_manager_total_cols_c        :out mem_manager_total_cols;
             mem_manager_base_address_c      :out mem_manager_base_address;
             
             
             --- For Mem Inst
             
             mem_manager_write_loc           :in mem_manager_address;
             mem_manager_write_TR            :in mem_manager_total_rows;           
             mem_manager_write_TC            :in mem_manager_total_cols;
             conj_flag_b                     :out flag;
             conj_flag_c                     :out flag
                           
                                  
              
                                              
              
            );
  end component;
  ------------------------------------------------------------------------------
  component memory 
      port ( 
             clk,memory_write_enable                                  :in flag;
             memory_address_a,memory_address_b,memory_write_address   :in memory_address;             
             memory_data_out_a,memory_data_out_b                      :out mem_cell;
             memory_data_in                                           :in mem_cell

              
            );
  end component;
  ------------------------------------------------------------------------------  
  component alu 
      port ( 
                	conj_a,conj_b             :in flag;
                	alu_in_av,alu_in_bv       :in mem_cell;
                	alu_command               :in command_alu;
                	alu_out_a,alu_out_b       :out mem_cell;
                	alu_flag                  :out flag :='0'
            );
  end component;
  ------------------------------------------------------------------------------ 
   component mux_data 
        port (
              mux_data_in_a,mux_data_in_b,mux_data_in_c,mux_data_in_d   :in mem_cell;
              mux_data_in_e,mux_data_in_f                               :in mem_cell;
              mux_data_sel                                              :in sel_3bit;
              mux_data_out                                              :out mem_cell
            );
  end component;
 
  ------------------------------------------------------------------------------  
  component reg 
                   port ( 
	                 clk,reset                 :in   flag;
	                 reg_in                    :in   mem_cell;
	                 reg_out                   :out  mem_cell
	                                                                               

                );
      end component; 
      
      
    
    ------------------------------------------------------------------------------    
   component sub2ind is
          port ( 
	                 clk                       :in   flag;
	                 r,c                       :in   counter_address;
	                 tc                        :in   mem_manager_total_cols;
	                 index                     :out  memory_address
	                                                                               

                );
      end component;  
  
    ------------------------------------------------------------------------------  
    component mux_imem 
      port (
              mux_imem_in_a,mux_imem_in_b  :in  counter_imem_address;
              mux_imem_sel                 :in  std_logic;
              mux_imem_out                 :out counter_imem_address
            );
  end component;  
  ------------------------------------------------------------------------------  
  component mux_mem_mgr 
      port (
              mux_mem_mgr_in_a,mux_mem_mgr_in_b,mux_mem_mgr_in_c           :in mem_manager_total_rows;
              mux_mem_mgr_in_d,mux_mem_mgr_in_e,mux_mem_mgr_in_f           :in mem_manager_total_rows;
              mux_mem_mgr_sel                                              :in sel_3bit;
              mux_mem_mgr_out                                              :out counter_address
            );
  end component;  

  ------------------------------------------------------------------------------
  component mux_counter 
      port (
              mux_counter_in_a,mux_counter_in_b,mux_counter_in_c,mux_counter_in_d,mux_counter_in_e      :in counter_address;
              mux_counter_sel                                                                           :in sel_3bit;
              mux_counter_out                                                                           :out counter_address
            );


  end component;
  
  ------------------------------------------------------------------------------
  component mux_mem_address 
      port (
              mux_mem_address_in_a,mux_mem_address_in_b,mux_mem_address_in_c,mux_mem_address_in_d        :in memory_address;
              mux_mem_address_sel                                                                        :in sel_2bit;
              mux_mem_address_out                                                                        :out memory_address
            );
  end component;
  
  ------------------------------------------------------------------------------ 
  component mux_done 
      port (
              mux_done_in_a,mux_done_in_b,mux_done_in_c,mux_done_in_d   :in  flag;
              mux_done_in_e,mux_done_in_f,mux_done_in_g,mux_done_in_h   :in  flag;
              mux_done_sel                                              :in  sel_3bit;
              mux_done_out                                              :out flag
            );
  end component; 
  ------------------------------------------------------------------------------ 
  component reg_hold_mem_address 
          port ( 
	                 clk                                        :in   flag;
	                 reg_hold_mem_address_in                    :in   memory_address;
	                 reg_hold_mem_address_out                   :out  memory_address
	                                                                               

                );
      end component; 
  ------------------------------------------------------------------------------  
  component reg_hold_data 
                    port ( 
	                 clk                                 :in   flag;
	                 reg_hold_data_in                    :in   data;
	                 reg_hold_data_out                   :out  data 
	                                                                               

                );
      end component;
  ------------------------------------------------------------------------------
  component mux_base_address
      port (
              mux_base_address_in_a,mux_base_address_in_b,mux_base_address_in_c      :in memory_address;
              mux_base_address_sel                                                   :in sel_2bit;
              mux_base_address_out                                                   :out memory_address
            );
  end component;
  ------------------------------------------------------------------------------  
  component mux_tc 
      port (
              mux_tc_in_a,mux_tc_in_b,mux_tc_in_c      :in mem_manager_total_cols;
              mux_tc_sel                               :in sel_2bit;
              mux_tc_out                               :out mem_manager_total_cols
            );
  end component;


  ------------------------------------------------------------------------------ 
   component reg_mux_imem
          port ( 
	                 clk                                :in   flag;
	                 reg_mux_imem_in                    :in   flag;
	                 reg_mux_imem_out                   :out  flag 
	                                                                               

                );
      end component;
  ------------------------------------------------------------------------------
  component reg_hold_jump_address
          port ( 
	                 clk                                         :in   flag;
	                 reg_hold_jump_address_in                    :in   counter_imem_address;
	                 reg_hold_jump_address_out                   :out  counter_imem_address 
	                                                                               

                );
      end component;
  ------------------------------------------------------------------------------
        component reg_lsr 
          port ( 
	                 clk                           :in   flag;
	                 reg_lsr_in                    :in   mem_cell;
	                 reg_lsr_out                   :out  mem_cell
	                                                                               

                );
      end component;
  ------------------------------------------------------------------------------
  ------------------------------------------------------------------------------         
      component control 
         port ( 
	                 clk                       :in flag;
	                 control_opcode_in         :in  imem_opcode;
                   mem_manager_rw            :out sel_3bit; 
	                 main_mem_we               :out flag;
	                 to_alu_opcode             :out command_alu;
	                 
	                 mux_done_counter_a        :out sel_3bit;         
	                 mux_done_counter_b        :out sel_3bit;	                                                                               
	                 mux_done_counter_c        :out sel_3bit;
	                 mux_done_counter_d        :out sel_3bit;
	                 mux_done_counter_e        :out sel_3bit;	                 
	                 mux_done_counter_f        :out sel_3bit;		                 
	                 
	                 mux_mem_mgr_a             :out sel_3bit;
	                 mux_mem_mgr_b             :out sel_3bit;
	                 mux_mem_mgr_c             :out sel_3bit;	                 
	                 
	                 
	                 mux_counter_a             :out sel_3bit;	                 
	                 mux_counter_b             :out sel_3bit;		                 
	                 mux_counter_c             :out sel_3bit;
	                 
	                 mux_counter_aa             :out sel_3bit;	                 
	                 mux_counter_bb             :out sel_3bit;		                 
	                 mux_counter_cc             :out sel_3bit;

	                 mux_mem_addr_a            :out sel_2bit;	  	                 		                 
	                 mux_mem_addr_b            :out sel_2bit;
	                 mux_mem_addr_c            :out sel_2bit;	                 


	                 mux_data_a                :out sel_3bit;
	                 mux_data_b                :out sel_3bit;	                 
	                 mux_data_c                :out sel_3bit;
	                 
	                 
                   mux_base_address_sel      :out sel_2bit; 
                   mux_base_address_sel_b    :out sel_2bit;                     	                 	                 	                 	  	                 		                 
                   mux_tc_sel   	            :out sel_2bit;                   
                   mux_tc_sel_b              :out sel_2bit  	                 
	                 
	                 
	                 
	                 
	                 
	                 
                );
      end component;
  
  ----------------------------------- SIGNALS -----------------------------------
  ---Hold WFSR
  
  	signal  reg_hold_data_out_a,reg_hold_data_out_b :data;
  
  
  ------ Imem Counter ----
  signal imem_counter_out    :imem_address;


  -- MUX IMEM Counter--
  signal mux_imem_out :counter_imem_address;
  
  ---- IMEM ---
  
  signal imem_matrix_loc_a,imem_matrix_loc_b,imem_matrix_loc_c   :imem_matrix_address;
	signal imem_jump_addrsss          :imem_address;
  signal imem_opcode                :imem_opcode;
  signal forced_mem_address_w       :memory_address;
  signal forced_mem_address_r_b     :memory_address;  
  signal forced_mem_address_r_c     :memory_address;
	signal forced_mem_value,forced_mem_value_fp     :mem_cell;	
  signal imem_mem_manager_write_loc       : mem_manager_address;
  signal imem_mem_manager_write_TR        : mem_manager_total_rows;           
  signal imem_mem_manager_write_TC        : mem_manager_total_cols;
                                           
         

	
	
	
	
	
	--- Control Unit --
  signal	       main_mem_we               :flag;
  signal        to_alu_opcode             :command_alu;
  signal        mem_manager_rw            : sel_3bit; 
  signal        mux_done_counter_a        : sel_3bit;         
	signal        mux_done_counter_b        : sel_3bit;	                                                                               
	signal        mux_done_counter_c        : sel_3bit;
	signal        mux_done_counter_d        : sel_3bit;
	signal        mux_done_counter_e        : sel_3bit;	                 
	signal        mux_done_counter_f        : sel_3bit;	                 
	                 
	signal        mux_mem_mgr_a             : sel_3bit;
	signal        mux_mem_mgr_b             : sel_3bit;
	signal        mux_mem_mgr_c             : sel_3bit;	                 
	                 
	                 
	signal        mux_counter_a             : sel_3bit;	                 
	signal        mux_counter_b             : sel_3bit;		                 
	signal        mux_counter_c             : sel_3bit;
	signal        mux_counter_aa            : sel_3bit;	                 
	signal        mux_counter_bb            : sel_3bit;		                 
	signal        mux_counter_cc            : sel_3bit;


  signal	       mux_mem_addr_a            : sel_2bit;	  	                 		                 
  signal	       mux_mem_addr_b            : sel_2bit;
  signal	       mux_mem_addr_c            : sel_2bit;


  signal	       mux_data_a                : sel_3bit;
  signal	       mux_data_b                : sel_3bit;	                 
  signal	       mux_data_c                : sel_3bit;
  
  signal         mux_base_address_sel 	   : sel_2bit;      
  signal         mux_tc_sel,mux_tc_sel_b  : sel_2bit;   
  signal         mux_base_address_sel_b	  : sel_2bit; 
       

  ----  ALU ----
  
  
  ---- mem manager---

                       
    signal             mem_manager_total_rows_a        :mem_manager_total_rows;
    signal             mem_manager_total_cols_a        :mem_manager_total_cols;
    signal             mem_manager_base_address_a      :mem_manager_base_address;
             
                        
    signal             mem_manager_total_rows_b        :mem_manager_total_rows;
    signal             mem_manager_total_cols_b        :mem_manager_total_cols;
    signal             mem_manager_base_address_b      :mem_manager_base_address;     
  
                        
    signal             mem_manager_total_rows_c        :mem_manager_total_rows;
    signal             mem_manager_total_cols_c        :mem_manager_total_cols;
    signal             mem_manager_base_address_c      :mem_manager_base_address;
    signal             conj_flag_b                     : flag;
    signal             conj_flag_c                     : flag;
               
    
    
    ------ Counter ----
    

	  signal         done_a                      :flag;
 	  signal         out_counter_a               :counter_address;
	  signal         done_b                      :flag;
 	  signal         out_counter_b               :counter_address; 	  
	  signal         done_c                      :flag;
 	  signal         out_counter_c               :counter_address;
    signal         done_on_last_val_a          :flag; 	  
    signal         done_on_last_val_b          :flag;
    signal         done_on_last_val_c          :flag;     	       
     ---- Mux_mem manger
     
      
     signal  mux_mem_mgr_out_a        : counter_address;
     signal  mux_mem_mgr_out_b        : counter_address;     
     signal  mux_mem_mgr_out_c        : counter_address; 
     
     
     ----- mux_counter
     
   
   signal  mux_counter_out_a          :counter_address   ;
   signal  mux_counter_out_b          :counter_address   ;
   signal  mux_counter_out_c          :counter_address   ;   
   signal  mux_counter_out_aa         :counter_address   ;
   signal  mux_counter_out_bb         :counter_address   ;
   signal  mux_counter_out_cc         :counter_address   ;
    ----- Sub2 index
     
	  signal  index_a                   :  memory_address;
 	  signal  index_b                   :  memory_address;
 	  signal  index_c                   :  memory_address;
	                                                                               
 ----Adders at main mem for index
   signal out_adder_a :memory_address;
   signal out_adder_b :memory_address;   
   signal out_adder_c :memory_address; 
   
   
   
   --Mux mem address
   
   
   
   signal      mux_mem_address_out_a       : memory_address;	
   signal      mux_mem_address_out_b       : memory_address;	
   signal      mux_mem_address_out_c       : memory_address;
   
   ------- Main memory
   

     
    signal memory_data_out_a   :mem_cell;
    signal memory_data_out_b   :mem_cell;     
    signal mem_we :flag;
    ------ Mux_data
    
   signal mux_data_out_a        :mem_cell;
   signal mux_data_out_b        :mem_cell;   
   signal mux_data_out_c        :mem_cell;

---- Signal of alu


   signal             alu_out_a,alu_out_b  :mem_cell;
   signal            	alu_flag             :flag;
   
   
   ----ALU Reg
   

    signal  reg_out :mem_cell;
	  
	  ------Mux_done
	  signal mux_done_out_a  :flag;                                                                            
 	  signal mux_done_out_b  :flag; 
	  signal mux_done_out_c  :flag;  	  
	  signal mux_done_out_d  :flag; 
	  signal mux_done_out_e  :flag :='0';            
 	  signal mux_done_out_f  :flag; 
 	  
 	  -- Mux base address
 	  

    signal  mux_base_address_out       :memory_address;
    signal  mux_base_address_out_b       :memory_address;

    -- mux tc
    signal    mux_tc_out               : mem_manager_total_cols;
    signal    mux_tc_out_b               : mem_manager_total_cols;    
 	  
 	  ---- Reg _hold _memory address
  
   signal  reg_hold_mem_address_out   :  memory_address;

     ---- Reg _hold _data

   signal  reg_hold_data_out   :  mem_cell;
   
   --- Mux_imem_reg

	 signal reg_mux_imem_out                   : flag; 
	 
	 -----reg_hold_jump_address
  signal  reg_hold_jump_address_out                   :counter_imem_address  ;
  
  
  -------LSR Signals
  
  signal reg_lsr_out            :mem_cell;

	-----------------------------------------------------------------------------------
	--*******************************************************************************--
  -----------------------------------------------------------------------------------
  
  signal  start_val :counter_address :="0000000000001";
  signal  jump :counter_address :="0000000000001";

  signal reg_alu_adder_out  :mem_cell;
  signal pc_clk,mux_imem_sel ,lsr_clk:flag;
    
	begin
    
  --- Reg imem mux
    reg_mux_imem_i:reg_mux_imem port map( 
	                 clk ,
	                 alu_flag,
	                 reg_mux_imem_out
	                                                                               

                );
  


  ------ Imem Counter ----    
pc_clk<=(mux_done_out_d and mux_done_out_a and mux_done_out_b and clk);
 imem_counter_i:counter_imem  port map( 
	                 pc_clk,reset,reg_mux_imem_out,
	                 mux_imem_out,    -- +1 is done in counter       
	                 imem_counter_out
	                                                                               

                );
---- Reg _hold_jump address


reg_hold_jump_address_i: reg_hold_jump_address  port map( 


	                 clk,
	                 imem_jump_addrsss,
	                 reg_hold_jump_address_out
	                                                                               

                );

      
            
  ---- MUX IMEM Counter ----          
  mux_imem_sel<=clk and alu_flag;
  
  
  mux_imem_i:mux_imem  port map(
              imem_counter_out,reg_hold_jump_address_out,
              reg_mux_imem_out,
              mux_imem_out
            );                
  ---- IMEM ----
  imem_i:imem port map ( 
	            mux_imem_out,
	            imem_opcode,
	            imem_matrix_loc_a,imem_matrix_loc_b,imem_matrix_loc_c,
	            imem_jump_addrsss,
	            forced_mem_address_w,
	            forced_mem_address_r_b,
	            forced_mem_address_r_c,
	            forced_mem_value,
	            forced_mem_value_fp,
              imem_mem_manager_write_loc,
              imem_mem_manager_write_TR,
              imem_mem_manager_write_TC
                                           

	             

              ); 
  
   ---- mem manager---
mem_mgr_i:mem_manager  port map ( 
             clk,reset,mem_manager_rw,
             imem_matrix_loc_a,
             imem_matrix_loc_b,
             imem_matrix_loc_c,
                        
             mem_manager_total_rows_a,
             mem_manager_total_cols_a,
             mem_manager_base_address_a,
             
                        
             mem_manager_total_rows_b,
             mem_manager_total_cols_b,
             mem_manager_base_address_b,
  
                        
             mem_manager_total_rows_c,
             mem_manager_total_cols_c,
             mem_manager_base_address_c,
             imem_mem_manager_write_loc,
             imem_mem_manager_write_TR,
             imem_mem_manager_write_TC,
             
             conj_flag_b,
             conj_flag_c 
                           
              
            );
    

  --- Mux_ MEM Manager ---
 mux_mem_mgr_a_i:  mux_mem_mgr port map(
                   mem_manager_total_rows_a,
                   mem_manager_total_cols_a,
                   mem_manager_total_rows_b,
                   mem_manager_total_cols_b,
                   mem_manager_total_rows_c,
                   mem_manager_total_cols_c,
                   mux_mem_mgr_a,
                   mux_mem_mgr_out_a
            );
            
            
mux_mem_mgr_b_i:mux_mem_mgr port map(
                   mem_manager_total_rows_a,
                   mem_manager_total_cols_a,
                   mem_manager_total_rows_b,
                   mem_manager_total_cols_b,
                   mem_manager_total_rows_c,
                   mem_manager_total_cols_c,
                   mux_mem_mgr_b,
                   mux_mem_mgr_out_b
            );            


mux_mem_mgr_c_i:mux_mem_mgr port map(
                   mem_manager_total_rows_a,
                   mem_manager_total_cols_a,
                   mem_manager_total_rows_b,
                   mem_manager_total_cols_b,
                   mem_manager_total_rows_c,
                   mem_manager_total_cols_c,
                   mux_mem_mgr_c,
                   mux_mem_mgr_out_c
            );


  --- mux_counter  section ---  
  mux_counter_a_i:mux_counter  port map (
              out_counter_a,
              out_counter_b,
              out_counter_c,
              memory_data_out_a.r(12 downto 0),
              out_counter_c,
              mux_counter_a,
              mux_counter_out_a
              
            );

  mux_counter_b_i:mux_counter  port map (
              out_counter_a,
              out_counter_b,
              out_counter_c,
              "0000000000001",--dummy              
              out_counter_c,
              mux_counter_b,
              mux_counter_out_b
            );

  mux_counter_c_i:mux_counter  port map (
              out_counter_a,
              out_counter_b,
              out_counter_c,
              reg_hold_data_out_a(12 downto 0), 
              out_counter_c,           
              mux_counter_c,
              mux_counter_out_c
            );
            
mux_counter_aa_i:mux_counter  port map (
              out_counter_a,
              out_counter_b,
              out_counter_c,
              memory_data_out_b.r(12 downto 0),
              forced_mem_address_r_c(12 downto 0),
              mux_counter_aa,
              mux_counter_out_aa
            );

  mux_counter_bb_i:mux_counter  port map (
              out_counter_a,
              out_counter_b,
              out_counter_c,
              "0000000000001",--dummy
              out_counter_c,              
              mux_counter_bb,
              mux_counter_out_bb
            );

  mux_counter_cc_i:mux_counter  port map (
              out_counter_a,
              out_counter_b,
              out_counter_c,
              reg_hold_data_out_b(12 downto 0), 
                            out_counter_c,        
              mux_counter_cc,
              mux_counter_out_cc
            );            


  --- counters section ---
  
counter_a_i:counter  port map( 
	                 mux_done_out_a,clk,
	                 done_a,
	                 start_val,
	                 mux_mem_mgr_out_a,
	                 jump,
 	                 out_counter_a,
 	                 done_on_last_val_a,pc_clk

                );
counter_b_i:counter  port map( 
	                 mux_done_out_b,clk,
	                 done_b,
	                 start_val,
	                 mux_mem_mgr_out_b,
	                 jump,
 	                 out_counter_b,
 	                 done_on_last_val_b,pc_clk

                );                
counter_c_i:counter  port map( 
	                 mux_done_out_c,clk,
	                 done_c,
	                 start_val,
	                 mux_mem_mgr_out_c,
	                 jump,
 	                 out_counter_c,
 	                 done_on_last_val_c,pc_clk

                );  
 ---- SUB2Index -----
 
 
 
      sub2ind_a_i:sub2ind port map( 
	                 clk,
	                 mux_counter_out_a,
	                 mux_counter_out_aa,
	                 mem_manager_total_cols_a,
	                 index_a
	                                                                               

                ); 
      sub2ind_b_i:sub2ind port map( 
	                 clk,
	                 mux_counter_out_b,
	                 mux_counter_out_bb,
	                 mux_tc_out_b,
	                 index_b
	                                                                               

                ); 
      sub2ind_c_i:sub2ind port map( 
	                 clk,
	                 mux_counter_out_c,
	                 mux_counter_out_cc,
	                 mux_tc_out,
	                 index_c
	                                                                               

                ); 

  
  --- Mux_tc
  
   mux_tc_c_i:mux_tc port map(
              mem_manager_total_cols_c,
              mem_manager_total_cols_b,
              mem_manager_total_cols_a, --dummy
              mux_tc_sel,
              mux_tc_out
            );
            
            
    mux_tc_b_i:mux_tc port map(
              mem_manager_total_cols_c,
              mem_manager_total_cols_b,
              mem_manager_total_cols_a, --dummy
              mux_tc_sel_b,
              mux_tc_out_b
            );

  --- HOLD FOR WFSR
  
    reg_hold_data_a: reg_hold_data port map ( 
	                 clk,
	                 memory_data_out_a.r,
	                 reg_hold_data_out_a
	                                                                               

                );
                
                
    reg_hold_data_b: reg_hold_data port map ( 
	                 clk,
	                 memory_data_out_b.r,
	                 reg_hold_data_out_b
	                                                                               

                );                


  ---- Mux base address -----new one
  
  mux_base_address_b_i:mux_base_address port map(
              mem_manager_base_address_c,
              mem_manager_base_address_b,
              mem_manager_base_address_c,--dummy 
              mux_base_address_sel_b,
              mux_base_address_out_b
            );
  




  ---- Mux base address
  
  mux_base_address_i:mux_base_address port map(
              mem_manager_base_address_b,
              mem_manager_base_address_b,
              mem_manager_base_address_a,--dummy 
              mux_base_address_sel,
              mux_base_address_out
            );
  
  ----  Index plus Base Address part
  
  out_adder_a<=index_a+mem_manager_base_address_a-"00000000000000000001"; --be very careful with confusing names
  out_adder_b<=index_b+mux_base_address_out_b-"00000000000000000001";  
  out_adder_c<=index_c+mux_base_address_out-"00000000000000000001";  

  ---reg_hold_mem_address
  
  
  reg_hold_mem_address_i : reg_hold_mem_address port map ( 
	                 clk,
	                 out_adder_a,
	                 reg_hold_mem_address_out
	                                                                               

                );
  
  
  -- Muxes mux_main_memory address
  
  
  mux_mem_address_a_i:mux_mem_address port map (
              out_adder_a,
              forced_mem_address_w,
              reg_hold_mem_address_out,
              forced_mem_address_w, --Dummy
              mux_mem_addr_a,
              mux_mem_address_out_a
            );
            
  
  mux_mem_address_b_i:mux_mem_address port map (
              out_adder_b,
              forced_mem_address_r_c,
              forced_mem_address_r_b, --dummy
              forced_mem_address_w,              
              mux_mem_addr_b,
              mux_mem_address_out_b
            );
    
    
    mux_mem_address_c_i:mux_mem_address port map (
              out_adder_c,
              forced_mem_address_r_b,
              forced_mem_address_r_c, --dummy
              forced_mem_address_w,              
              mux_mem_addr_c,
              mux_mem_address_out_c
            );
    ------Main Memory
    
    mem_we<=(main_mem_we and mux_done_out_e);
     main_mem_i:memory port map( 
             clk,
             mem_we,
             mux_mem_address_out_c,
             mux_mem_address_out_b,
             mux_mem_address_out_a,
             memory_data_out_a,
             memory_data_out_b,
             mux_data_out_c 

              
            );
    
  ---Reg LSR
  
     --lsr_clk
     reg_lsr_i:reg_lsr port map ( 
	                 clk,
	                 memory_data_out_a,
	                 reg_lsr_out
	                                                                               

                );
       
    
    
  ---- Data Hold Reg 
  
  --reg_hol_data_i:reg_hold_data port map( 
	  --               clk,
	    --             memory_data_out_a,
	      --           reg_hold_data_out
	                                                                               

          --      );                     
  ----- MUX _ Data 
  mux_data_a_i:mux_data port map(
             
              memory_data_out_b,
              forced_mem_value_fp,
              forced_mem_value,-- Dummy
              reg_alu_adder_out, --Dummy
              forced_mem_value,-- Dummy
              reg_alu_adder_out, --Dummy              
              mux_data_a, 
              mux_data_out_a
            );
            
            
  mux_data_c_i:mux_data port map(
             
          
              alu_out_a,
              memory_data_out_a,
              forced_mem_value,
              reg_alu_adder_out,
              reg_lsr_out,
              memory_data_out_b, 
              mux_data_c, 
              mux_data_out_c
            );
                          


  ---- ALu reg part
  
  reg_alu_adder_out<=(reg_out + alu_out_a);
  
  reg_alu_i:reg port map( 
	                 clk,mux_done_out_f, --thats the reset
	                 reg_alu_adder_out,
	                 reg_out
	                                                                               

                );

  --------ALU 
  
  
  alu_i:alu port map( 
                 conj_flag_b,
                 conj_flag_c,
                	memory_data_out_a,
                	mux_data_out_a,
                	to_alu_opcode,
                	alu_out_a,
                	alu_out_b,
                	alu_flag
            );            
  ------ Mux _dones

    mux_done_a_i :mux_done port map(
              clk,
              done_a,
              done_b,
              done_c,
              done_on_last_val_a, --dummy
              done_on_last_val_b, --dummy
              done_on_last_val_c, --dummy
              done_c, --dummy
              mux_done_counter_a,
              mux_done_out_a
            );
            
            
    mux_done_b_i :mux_done port map(
              clk,
              done_a,
              done_b,
              done_c,
              done_on_last_val_a, --dummy
              done_on_last_val_b, --dummy
              done_on_last_val_c, --dummy
              done_c, --dummy
              mux_done_counter_b,
              mux_done_out_b
            );
            
            
    mux_done_c_i:mux_done port map(
              clk,
              done_a,
              done_b,
              done_c,
              done_on_last_val_a, --
              done_on_last_val_b, --
              done_on_last_val_c, --
              '0', --dummy
              mux_done_counter_c,
              mux_done_out_c
            );
            
            
   mux_done_d_i :mux_done port map(
              clk,
              done_a,
              done_b,
              done_c,
              done_on_last_val_a, --dummy
              done_on_last_val_b, --dummy
              done_on_last_val_c, --dummy
              '0', --dummy
              mux_done_counter_d,
              mux_done_out_d
            );
            
            
   mux_done_e_i :mux_done port map( --this mux is for memory write
              clk,
              done_a,
              done_b,
              done_c,
              done_on_last_val_a, --dummy
              done_on_last_val_b, --dummy
              done_on_last_val_c, --dummy
              '0', --dummy
              mux_done_counter_e,
              mux_done_out_e
            );


   mux_done_f_i :mux_done port map(
              reset,
              done_a,
              done_b,
              done_c,
              pc_clk, --- reset on every new inst
              done_on_last_val_b, --dummy
              done_on_last_val_c, --dummy
              done_c, --dummy
              mux_done_counter_f,
              mux_done_out_f
            );

            
  ---- Control Unit ----
  control_unit_i:control port map( 
	                 clk,
	                 imem_opcode,
                   mem_manager_rw,
	                 main_mem_we,
	                 to_alu_opcode,
	                 
	                 mux_done_counter_a,
	                 mux_done_counter_b,
	                 mux_done_counter_c,
	                 mux_done_counter_d,
	                 mux_done_counter_e,
	                 mux_done_counter_f,	                 
	                 
	                 mux_mem_mgr_a,
	                 mux_mem_mgr_b,
	                 mux_mem_mgr_c,
	                 
	                 
	                 mux_counter_a,
	                 mux_counter_b,
	                 mux_counter_c,
	                 
	                 mux_counter_aa,
	                 mux_counter_bb,
	                 mux_counter_cc,
	                 
	                 mux_mem_addr_a,
	                 mux_mem_addr_b,
	                 mux_mem_addr_c,


	                 mux_data_a,
	                 mux_data_b,
	                 mux_data_c,
	                 
	                 mux_base_address_sel,
	                 mux_base_address_sel_b,
	                 mux_tc_sel,
	                 mux_tc_sel_b
	                 
	                 
	                 
	                 
	                 
	                 
	                 
                );

  
  
  end arc_main;



