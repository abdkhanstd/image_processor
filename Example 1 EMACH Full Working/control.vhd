

-- This is an 8 bit control actually will work 0 - 255 will have a trigger 

library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;





      entity control is
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
      end control;

  architecture arc_control of control is
  begin
    
        

         
 ----------------------------------------------------------------------------------                 
      mem_manager_rw        <=  "001"     when control_opcode_in = IMAT else
                                "010"     when control_opcode_in = RSHP else
                                "010"     when control_opcode_in = MERG else                                
                                "011"     when control_opcode_in = SCONJ else 
                                "100"     when control_opcode_in = RCONJ else                                 
                                "000"   ;   -- Write only when INTS MEM required


      main_mem_we           <=  '0'          when control_opcode_in = STOPP or control_opcode_in = WTSR  or control_opcode_in = LRC or control_opcode_in = LSR or control_opcode_in = SCONJ or control_opcode_in = RCONJ or control_opcode_in = MERG or control_opcode_in = RSHP or control_opcode_in = IMAT or control_opcode_in = JEQ or control_opcode_in = JNE or control_opcode_in = JMP or control_opcode_in = JGE  or control_opcode_in = JGT  or  control_opcode_in = JGABS  or  control_opcode_in = JLT  or control_opcode_in = JLE or control_opcode_in = JLE else
                                '1';

      to_alu_opcode         <=  alu_mul_fp   when control_opcode_in = MULm or control_opcode_in = FFTm  or control_opcode_in = FFTmm   else
                                alu_mul_fp   when control_opcode_in = MULmd or control_opcode_in = MUL else
                                alu_mul_fp   when control_opcode_in = MULmi or control_opcode_in = MULmv else 
                                alu_add_fp   when control_opcode_in = ADDmi or control_opcode_in = ADDi or control_opcode_in = ADDmv or control_opcode_in = ADDm or control_opcode_in = ADD else                           
                                alu_sub_fp   when control_opcode_in = SUBB or control_opcode_in = MUL   or control_opcode_in = SUBi or control_opcode_in = SUBm  or control_opcode_in = SUBmi or  control_opcode_in = SUBmv  else
	                              alu_div_fp   when control_opcode_in = DIVm  or control_opcode_in = DIVi or control_opcode_in = DIVmv  or control_opcode_in =DIVmi or control_opcode_in =DIV else
	                              alu_pow_fp   when control_opcode_in = POWmi or control_opcode_in = POWmv or control_opcode_in = POWi or control_opcode_in = POW else
	                              alu_eq_fp    when control_opcode_in = JEQ else
	                              alu_neq_fp   when control_opcode_in = JNE else
	                              alu_lteq     when control_opcode_in = JLE else
	                              alu_gteq	    when control_opcode_in = JGE else 
	                              alu_jmp      when control_opcode_in = JMP else  
	                              alu_lt       when control_opcode_in = JLT else                      
	                              alu_gt       when control_opcode_in = JGT else
	                              alu_real     when control_opcode_in = CREAL else 	                                             
	                              alu_JGT_ABS  when control_opcode_in = JGABS else 	
	                              alu_null;
	                              
	                              
	             
-----------------------------------------------------------------------------------               
	                 
      mux_done_counter_a    <=  "000" when control_opcode_in = MULm or control_opcode_in = FFTm  or control_opcode_in = FFTmm else
                                "000" when control_opcode_in = MULmd else
                                "000" when control_opcode_in = MULmi else 
                                "000" when control_opcode_in = ADDm  or  control_opcode_in = CPYm  or control_opcode_in = CREAL  or  control_opcode_in = SUBmi or control_opcode_in = SUBm or control_opcode_in = DIVm else 
                                "000" when control_opcode_in = ADDmi or control_opcode_in = POWmi or control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv or control_opcode_in =DIVmi else
                                "000" when control_opcode_in = CPY or control_opcode_in = CPYC  or control_opcode_in =  SFSR  or control_opcode_in = WTSR  or control_opcode_in = LRC or control_opcode_in = RCONJ or control_opcode_in = WFSR or control_opcode_in = TP or control_opcode_in = LSR or control_opcode_in = IMAT or control_opcode_in = SCONJ  or control_opcode_in = RSHP or control_opcode_in = MERG  or control_opcode_in = JEQ  or control_opcode_in = JNE or control_opcode_in = JMP or control_opcode_in = JGE  or control_opcode_in = JGT  or  control_opcode_in = JGABS  or  control_opcode_in = JLT  or control_opcode_in = JLE  or control_opcode_in = ADDi or control_opcode_in = POWi  or control_opcode_in = DIVi or control_opcode_in = SUBi  or control_opcode_in = SUBi     or control_opcode_in = LOD or control_opcode_in = LODn  or control_opcode_in = SUBB or control_opcode_in = MUL  or control_opcode_in = ADD or control_opcode_in = MUL  or control_opcode_in = POW  or control_opcode_in =DIV;                                
                          
                              
      mux_done_counter_b    <=  "001" when control_opcode_in = MULm or control_opcode_in = FFTm  or control_opcode_in = FFTmm else
                                "001" when control_opcode_in = MULmd else
                                "001" when control_opcode_in = MULmi else 
                                "001" when control_opcode_in = ADDm  or  control_opcode_in = TP or control_opcode_in = CPYm  or control_opcode_in = CREAL  or control_opcode_in = SUBm or control_opcode_in = DIVm else
                                "001" when control_opcode_in = ADDmi or control_opcode_in = POWmi or  control_opcode_in = SUBmi or  control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv or control_opcode_in =DIVmi else
                                "000" when control_opcode_in = CPY or control_opcode_in = CPYC  or control_opcode_in =  SFSR  or control_opcode_in = WTSR   or control_opcode_in = LRC or control_opcode_in = WFSR  or control_opcode_in = LSR or control_opcode_in = IMAT or control_opcode_in = SCONJ or control_opcode_in = RCONJ    or control_opcode_in = RSHP or control_opcode_in = MERG or control_opcode_in = JEQ or control_opcode_in = JNE or control_opcode_in = JMP or control_opcode_in = JGE  or control_opcode_in = JGT  or  control_opcode_in = JGABS  or  control_opcode_in = JLT  or control_opcode_in = JLE  or control_opcode_in = ADDi  or control_opcode_in = POWi  or control_opcode_in = DIVi   or control_opcode_in = SUBi   or control_opcode_in = SUBi    or control_opcode_in = LOD or control_opcode_in = LODn  or control_opcode_in = SUBB or control_opcode_in = MUL  or control_opcode_in = ADD or control_opcode_in = MUL  or control_opcode_in = POW  or control_opcode_in =DIV   ;                                
                                                        
                        
      mux_done_counter_c    <=  "010" when control_opcode_in = MULm  or control_opcode_in = FFTm or control_opcode_in = FFTmm  else
                                "010" when control_opcode_in = MULmd else
                                "010" when control_opcode_in = MULmi else 
                                "010" when control_opcode_in = ADDm or  control_opcode_in = CPYm  or control_opcode_in = CREAL  or control_opcode_in = SUBm or control_opcode_in = DIVm else 
                                "010" when control_opcode_in = ADDmi or control_opcode_in = POWmi or  control_opcode_in = SUBmi or control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv or control_opcode_in =DIVmi else
                                "000" when control_opcode_in = CPY ;                                
         --Next operation Mux               
      mux_done_counter_d    <=  "111" when control_opcode_in = STOPP  else
                                "011" when control_opcode_in = MULm  or control_opcode_in = FFTm  or control_opcode_in = FFTmm else
                                "010" when control_opcode_in = MULmd else  
                                "010" when control_opcode_in = MULmi else 
                                "010" when control_opcode_in = ADDm or  control_opcode_in = CPYm  or control_opcode_in = CREAL  or control_opcode_in = SUBm or control_opcode_in = DIVm  else                                
                                "010" when control_opcode_in = ADDmi or control_opcode_in = POWmi or  control_opcode_in = SUBmi or control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv or control_opcode_in =DIVmi else
                                "000" when control_opcode_in = ADD  or control_opcode_in = POW   or control_opcode_in =DIV    or control_opcode_in = SUBB or control_opcode_in = MUL  or control_opcode_in = MUL  else         ---000 means on clk
                                "000" when control_opcode_in = CPY  or control_opcode_in =  SFSR  or control_opcode_in = WTSR  or control_opcode_in = LRC or control_opcode_in = WFSR  or control_opcode_in = LSR or control_opcode_in = IMAT  or control_opcode_in = SCONJ or control_opcode_in = RCONJ    or control_opcode_in = RSHP or control_opcode_in = MERG or control_opcode_in = JEQ or control_opcode_in = JNE or control_opcode_in = JMP or control_opcode_in = JGE  or control_opcode_in = JGT  or  control_opcode_in = JGABS  or  control_opcode_in = JLT  or control_opcode_in = JLE  or control_opcode_in = LOD or control_opcode_in = LODn   or control_opcode_in = ADDi  or control_opcode_in = POWi   or control_opcode_in = DIVi   or control_opcode_in = SUBi   or control_opcode_in = SUBi  else
                                "010" when control_opcode_in = TP else
                                "001" when control_opcode_in = CPYC ;                          
                          
      mux_done_counter_e    <=  "100" when control_opcode_in = MULm  or control_opcode_in = FFTm  or control_opcode_in = FFTmm else
                                "000" when control_opcode_in = MULmd else
                                "000" when control_opcode_in = MULmi or control_opcode_in =  CPY else 
                                "000" when control_opcode_in = ADDm or  control_opcode_in = CPYm  or control_opcode_in = CREAL  or control_opcode_in = SUBm or control_opcode_in = DIVm  else
                                "000" when control_opcode_in = ADDmi or control_opcode_in = POWmi  or  control_opcode_in = SUBmi or control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv or control_opcode_in =DIVmi else                                                                
                                "000" when control_opcode_in = ADD or control_opcode_in = CPYC  or control_opcode_in =  SFSR  or control_opcode_in = TP   or control_opcode_in = WFSR   or control_opcode_in = POW  or control_opcode_in = ADDi  or control_opcode_in = POWi   or control_opcode_in = DIVi or control_opcode_in = SUBi  or control_opcode_in = SUBi  or control_opcode_in =DIV   or control_opcode_in = SUBB or control_opcode_in = MUL   or control_opcode_in = LOD or control_opcode_in = LODn   ;
                               
      mux_done_counter_f    <=  "001" when control_opcode_in = MULm or control_opcode_in = FFTm  or control_opcode_in = FFTmm else
                                "100";
	                 
------------------------------------------------------------------------	                 
	                 
	                 
	                 
	                 
	                 
	                 
	                 
	                 
	                 
	                 
	                 
	                           --prev 011
      mux_mem_mgr_a         <= "011" when control_opcode_in = MULm  or control_opcode_in = FFTm  or control_opcode_in = FFTmm else
                               "000" when control_opcode_in = MULmd else 
                               "000" when control_opcode_in = MULmi else 
                               "000" when control_opcode_in = ADDm  or control_opcode_in = WFSR  or  control_opcode_in = CPYm  or control_opcode_in = CREAL  or control_opcode_in = SUBm or control_opcode_in = DIVm  else                               
                               "000" when control_opcode_in = ADDmi or control_opcode_in = POWmi or  control_opcode_in = SUBmi or control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv or control_opcode_in =DIVmi else
                               "001" when control_opcode_in = SFSR else
                               "000" when control_opcode_in =  CPYC else
                               "001" when control_opcode_in = TP ;
                               --101
                        
      mux_mem_mgr_b        <= "101" when control_opcode_in = MULm  or control_opcode_in = FFTm  or control_opcode_in = FFTmm else
                              "001" when control_opcode_in = MULmd else
                              "001" when control_opcode_in = MULmi else 
                              "001" when control_opcode_in = ADDm  or  control_opcode_in = CPYm  or control_opcode_in = CREAL  or control_opcode_in = SUBm or control_opcode_in = DIVm  else                              
                              "001" when control_opcode_in = ADDmi or control_opcode_in = POWmi or  control_opcode_in = SUBmi or control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv or control_opcode_in =DIVmi else
                              "000" when control_opcode_in = TP ;                                                        
                               --100
                            --Prev 010 for Mulm,
      mux_mem_mgr_c         <= "010" when control_opcode_in = MULm  or control_opcode_in = FFTm  or control_opcode_in = FFTmm else
                               "010" when control_opcode_in = MULmd else
                               "010" when control_opcode_in = MULmi else 
                               "010" when control_opcode_in = ADDm or control_opcode_in = TP  or  control_opcode_in = CPYm  or control_opcode_in = CREAL  or control_opcode_in = SUBm or control_opcode_in = DIVm  else                               
                               "010" when control_opcode_in = ADDmi or control_opcode_in = POWmi or  control_opcode_in = SUBmi or control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv or control_opcode_in =DIVmi;                               


	                 
--------------------------------------------------------------------------              
      mux_counter_a         <="010"  when control_opcode_in = MULm  or control_opcode_in = FFTm  or control_opcode_in = FFTmm else
     	                        "000"  when control_opcode_in = MULmd  or control_opcode_in =  CPYC else 
      	                       "000"  when control_opcode_in = MULmi else 
                              "000"  when control_opcode_in = ADDm or  control_opcode_in = CPYm  or control_opcode_in = CREAL  or control_opcode_in = SUBm or control_opcode_in = DIVm  else       	                      
                              "000"  when control_opcode_in = ADDmi or control_opcode_in = POWmi or  control_opcode_in = SUBmi or control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv or control_opcode_in =DIVmi else
                              "011"  when control_opcode_in = WFSR else
                              "001" when control_opcode_in = TP else  
                              "000" when control_opcode_in = CPYC;                               
                                                            
	                 
      mux_counter_b         <="000" when control_opcode_in = MULm  or control_opcode_in = FFTm  or control_opcode_in = FFTmm else
	                            "000" when control_opcode_in = MULmd else
	                            "000" when control_opcode_in = MULmi else 
                              "000" when control_opcode_in = ADDm or  control_opcode_in = CPYm  or control_opcode_in = CREAL  or control_opcode_in = SUBm or control_opcode_in = DIVm  else	                            
                              "000" when control_opcode_in = ADDmi or control_opcode_in = POWmi or  control_opcode_in = SUBmi or control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv or control_opcode_in =DIVmi else
                              "000" when control_opcode_in = TP else
                              "000" when control_opcode_in = CPYC;                                
	                 
      mux_counter_c         <="010" when control_opcode_in = MULm  or control_opcode_in = FFTm  or control_opcode_in = FFTmm else --M1(i,j)
      	                       "000" when control_opcode_in = MULmd else
      	                       "000" when control_opcode_in = MULmi else 
                              "000" when control_opcode_in = ADDm or  control_opcode_in = CPYm  or control_opcode_in = CREAL  or control_opcode_in = SUBm or control_opcode_in = DIVm  else      	                       
                              "000" when control_opcode_in = ADDmi or control_opcode_in = POWmi or  control_opcode_in = SUBmi or control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv or control_opcode_in =DIVmi else
	                            "011" when  control_opcode_in = WTSR ;
--------------------------------------------------------------------------	                 
	                 
      mux_counter_aa        <="001" when control_opcode_in  = MULm  or control_opcode_in = FFTm  or control_opcode_in = FFTmm else  
      	                       "001" when control_opcode_in  = MULmd else 
      	                       "001" when control_opcode_in  = MULmi else 
                              "001" when control_opcode_in  = ADDm  or control_opcode_in = CPYm  or control_opcode_in = CREAL  or control_opcode_in = SUBm or control_opcode_in = DIVm  else      	                      
                              "001" when control_opcode_in  = ADDmi or control_opcode_in = POWmi or  control_opcode_in = SUBmi or control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv or control_opcode_in =DIVmi else                              
                              "011"  when control_opcode_in = WFSR else
                              "000" when control_opcode_in = TP else                               
                              "100" when control_opcode_in = CPYC;
	                 
      mux_counter_bb        <="001" when control_opcode_in = MULm  or control_opcode_in = FFTm  or control_opcode_in = FFTmm else
      	                       "001" when control_opcode_in = MULmd else 
      	                       "001" when control_opcode_in = MULmi else 
                              "001" when control_opcode_in = ADDm or  control_opcode_in = CPYm  or control_opcode_in = CREAL  or control_opcode_in = SUBm or control_opcode_in = DIVm  else       	                       
                              "001" when control_opcode_in = ADDmi or  control_opcode_in = SUBmi or control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv or control_opcode_in =DIVmi else
                              "001" when control_opcode_in = TP else
                              "011" when control_opcode_in = CPYC;                                                                                         
	                 
      mux_counter_cc        <="000" when control_opcode_in = MULm  or control_opcode_in = FFTm  or control_opcode_in = FFTmm else --M1(i,j)
      	                       "001" when control_opcode_in = MULmd else 
      	                       "001" when control_opcode_in = MULmi else 
                              "001" when control_opcode_in = ADDm or  control_opcode_in = CPYm  or control_opcode_in = CREAL  or control_opcode_in = SUBm or control_opcode_in = DIVm  else       	                       
                              "001" when control_opcode_in = ADDmi or control_opcode_in = POWmi or  control_opcode_in = SUBmi or control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv or control_opcode_in =DIVmi else
                              "011" when control_opcode_in = WTSR; 
--------------------------------------------------------------------------	 
      mux_mem_addr_a        <="00" when control_opcode_in  = MULm or control_opcode_in = WFSR   or control_opcode_in = FFTm  or control_opcode_in = FFTmm else 
      	                       "00" when control_opcode_in  = MULmd else  --prev 10
      	                       "00" when control_opcode_in  = MULmi else      	                       
	                            "00" when control_opcode_in  = ADDm  or control_opcode_in = TP  or  control_opcode_in = CPYm  or control_opcode_in = CREAL  or control_opcode_in = SUBm or control_opcode_in = DIVm  else  
	                            "00" when control_opcode_in  = ADDmi or control_opcode_in = POWmi or  control_opcode_in = SUBmi or control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv or control_opcode_in =DIVmi else
                              "01" when control_opcode_in  = CPY   else
	                            "01" when control_opcode_in  = ADD  or control_opcode_in = POW  or control_opcode_in = ADDi  or control_opcode_in = POWi   or control_opcode_in = DIVi or control_opcode_in = SUBi   or control_opcode_in = SUBi    or control_opcode_in =DIV   or control_opcode_in = SUBB or control_opcode_in = MUL  or control_opcode_in = LOD or control_opcode_in = LODn  else
                              "00" when control_opcode_in = JEQ  or control_opcode_in = JNE or control_opcode_in = JMP or control_opcode_in = JGE  or control_opcode_in = JGT  or  control_opcode_in = JGABS  or  control_opcode_in = JLT  or control_opcode_in = JLE else  	                            
                              "00" when control_opcode_in = CPYC;
	                            
	                       
	                                            	           
      mux_mem_addr_b        <="00" when control_opcode_in  = MULm  or control_opcode_in = FFTm  or control_opcode_in = FFTmm else
      	                       "00" when control_opcode_in  = MULmd else
      	                       "00" when control_opcode_in  = MULmi else      	                         --prev 10
	                            "00" when control_opcode_in  = ADDm  or control_opcode_in = TP  or  control_opcode_in = CPYm  or control_opcode_in = CREAL  or control_opcode_in = SUBm or control_opcode_in = DIVm  else  
	                            "00" when control_opcode_in  = ADDmi  or control_opcode_in = POWmi or  control_opcode_in = SUBmi or control_opcode_in =DIVmi else	                            
	                            "01" when control_opcode_in  = ADDmv  or control_opcode_in = WFSR  or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv else	                            
                              "01" when control_opcode_in  = ADD  or control_opcode_in = POW  or control_opcode_in = SUBB or control_opcode_in = MUL  or control_opcode_in =DIV else
                              "10" when control_opcode_in  = JEQ   or control_opcode_in = JNE or control_opcode_in = JMP or control_opcode_in = JGE or control_opcode_in = JGT  or  control_opcode_in = JGABS  or  control_opcode_in = JLT  or control_opcode_in = JLE else
                              "01" when control_opcode_in = LRC else
                               "00" when control_opcode_in = CPYC;
                               
     mux_mem_addr_c         <="01"	 when control_opcode_in =  ADD  or control_opcode_in = WFSR  or control_opcode_in = POW  or control_opcode_in =DIV   or control_opcode_in = SUBB or control_opcode_in = MUL  else
                              "01"  when control_opcode_in =  CPY  or control_opcode_in = ADDi  or control_opcode_in = POWi   or control_opcode_in = DIVi or control_opcode_in = SUBi   or control_opcode_in = SUBi   else     
                              "11"  when control_opcode_in = JEQ  or control_opcode_in = JNE or control_opcode_in = LSR or control_opcode_in = JMP or control_opcode_in = JGE  or control_opcode_in = JGT  or  control_opcode_in = JGABS  or  control_opcode_in = JLT  or control_opcode_in = JLE  else 
                              "01"  when control_opcode_in = LRC else
                              "00";                           
	                                            	           	                 
--------------------------------------------------------------------------
      mux_data_a            <="000" when control_opcode_in = MULm  or control_opcode_in = FFTm  or control_opcode_in = FFTmm else
	                            "000" when control_opcode_in = MULmd else
	                            "001" when control_opcode_in = MULmi  or control_opcode_in = ADDi  or control_opcode_in = POWi   or control_opcode_in = DIVi  or control_opcode_in = SUBi   or control_opcode_in = SUBi   else 
                              "000" when control_opcode_in = ADDm  or  control_opcode_in = CPYm  or control_opcode_in = CREAL  or control_opcode_in = SUBm or control_opcode_in = DIVm  else	
                              "001" when control_opcode_in = ADDmi or control_opcode_in = POWmi or  control_opcode_in = SUBmi or control_opcode_in =DIVmi else
                              "000" when control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv else
                              "000" when control_opcode_in = ADD or control_opcode_in = JEQ or control_opcode_in = JNE or control_opcode_in = JMP or control_opcode_in = JGE  or control_opcode_in = JGT  or  control_opcode_in = JGABS  or  control_opcode_in = JLT  or control_opcode_in = JLE  or control_opcode_in = POW    or control_opcode_in =DIV  or control_opcode_in = SUBB or control_opcode_in = MUL  ;                             
                              
  
      mux_data_c            <="011" when control_opcode_in = MULm  or control_opcode_in = FFTm  or control_opcode_in = FFTmm else --prev 01
                  	           "000" when control_opcode_in = MULmd else --prev 01
                  	           "000" when control_opcode_in = MULmi  or control_opcode_in = ADDi  or control_opcode_in = POWi   or control_opcode_in = DIVi or control_opcode_in = SUBi  or control_opcode_in = SUBi   else 
                              "000" when control_opcode_in = ADDm  or control_opcode_in = SUBm  or control_opcode_in = DIVm  else                  	           
                              "000" when control_opcode_in = ADDmi or control_opcode_in = POWmi or  control_opcode_in = SUBmi or control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv or control_opcode_in =DIVmi else
                              "000" when control_opcode_in = ADD or control_opcode_in = CREAL   or control_opcode_in = POW    or control_opcode_in = DIV    or control_opcode_in = SUBB or control_opcode_in = MUL   else
                              "001" when control_opcode_in = CPYm  or control_opcode_in = CPY else
                              "010" when control_opcode_in = LOD or control_opcode_in = LODn  else
                              "100" when control_opcode_in = WFSR or control_opcode_in =  SFSR else
                              "101" when control_opcode_in = TP or control_opcode_in = CPYC;                              
 ---------------------------------------------------------------------------------------                             

      mux_base_address_sel  <="01" when control_opcode_in  = MULmi or control_opcode_in  = ADDmi or control_opcode_in = POWmi or  control_opcode_in = SUBmi or control_opcode_in =DIVmi or control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or control_opcode_in = MULmv or control_opcode_in =DIVmv else
                              "10" when control_opcode_in  = WTSR else 
                              "00";
      mux_base_address_sel_b <= "01" when control_opcode_in  = CPYC else 
                                "00";

    
      mux_tc_sel            <="01" when control_opcode_in  = MULmi or control_opcode_in  = ADDmi or control_opcode_in = POWmi or  control_opcode_in = SUBmi or control_opcode_in =DIVmi or  control_opcode_in = ADDmv or control_opcode_in = POWmv or  control_opcode_in = SUBmv  or  control_opcode_in = SUBmv or control_opcode_in = MULmv or control_opcode_in =DIVmv  else
                              "10" when control_opcode_in = WTSR else 
                              "01" when control_opcode_in = MULm else 
                              "00";

     mux_tc_sel_b    <= "00" when control_opcode_in  = MULm else
                        "01";



  
  end arc_control;



