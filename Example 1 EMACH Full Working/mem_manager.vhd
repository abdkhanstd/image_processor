library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;


--remove these
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_textio.all;
use std.textio.all; -- remove
use ieee.std_logic_arith.all;



  entity mem_manager is
      port ( 
             clk,reset                       :in flag;
             mem_manager_rw                  :in sel_3bit;
             mem_manager_address_a           :in mem_manager_address;  
             mem_manager_address_b           :in mem_manager_address;
             mem_manager_address_c           :in mem_manager_address;  
                        
             mem_manager_total_rows_a        :out mem_manager_total_rows;
             mem_manager_total_cols_a        :out mem_manager_total_cols;
             mem_manager_base_address_a      :out mem_manager_base_address;
             
                        
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
  end mem_manager;
  
  
  
  
  architecture arc_mem_manager of mem_manager is
  signal  mem_manager     :mem_manager_array;
  signal  mem_manager_row_a,mem_manager_row_b,mem_manager_row_c :mem_manager_row;
  signal  conj_col :std_logic_vector (0 to mem_manager_height);     
    
  begin
--------------------------------- Paste Here ---------------------------------



          
     
-------------------------------------------------------------------------------          
          mem_manager_row_a          <=  mem_manager(conv_integer(mem_manager_address_a));
          mem_manager_total_rows_a   <=  mem_manager_row_a(bits_total-1 downto (bits_total)-bits_size_total_rows);
          mem_manager_total_cols_a   <=  mem_manager_row_a(bits_total-bits_size_total_rows -1 downto bits_total-bits_size_total_rows-bits_size_total_cols);
          mem_manager_base_address_a <=  mem_manager_row_a(bits_total-bits_size_total_rows-bits_size_total_cols-1 downto 0);
        
        
          
          mem_manager_row_b          <=  mem_manager(conv_integer(mem_manager_address_b)) when mem_manager_address_b <="0000100000";
          mem_manager_total_rows_b   <=  mem_manager_row_b(bits_total-1 downto (bits_total)-bits_size_total_rows);
          mem_manager_total_cols_b   <=  mem_manager_row_b(bits_total-bits_size_total_rows -1 downto bits_total-bits_size_total_rows-bits_size_total_cols);
          mem_manager_base_address_b <=  mem_manager_row_b(bits_total-bits_size_total_rows-bits_size_total_cols-1 downto 0);
                         conj_flag_b <=  conj_col(conv_integer(mem_manager_address_b)) when mem_manager_address_b <="0000100000";
          
          
          
          mem_manager_row_c          <=  mem_manager(conv_integer(mem_manager_address_c)) when mem_manager_address_c <="0000100000";
          mem_manager_total_rows_c   <=  mem_manager_row_c(bits_total-1 downto (bits_total)-bits_size_total_rows);
          mem_manager_total_cols_c   <=  mem_manager_row_c(bits_total-bits_size_total_rows -1 downto bits_total-bits_size_total_rows-bits_size_total_cols);
          mem_manager_base_address_c <=  mem_manager_row_c(bits_total-bits_size_total_rows-bits_size_total_cols-1 downto 0);
                         conj_flag_c <=  conj_col(conv_integer(mem_manager_address_c)) when mem_manager_address_c <="0000100000";
    
     
                          
                 
                                
              
          process (clk)
          
       
          
          
            
 ---->    ---->          ---->          ---->          ---->          ---->          ---->          ---->          ---->  
 
             
variable na :mem_manager_base_address :="000000000000000001011111";---->---Also update this one 


 ---->    ---->          ---->          ---->          ---->          ---->          ---->          ---->          ---->  
---->    ---->          ---->          ---->          ---->          ---->          ---->          ---->          ---->  
          variable read,i:flag :='0';
      
          begin
            
            
            
            
            
               
          
          if  falling_edge(CLK)  and mem_manager_rw ="011"
          then 
            
            conj_col(conv_integer(mem_manager_address_b))<='1';
            
          end if;
            
            
             if  falling_edge(CLK)  and mem_manager_rw ="100"
          then 
            
            conj_col(conv_integer(mem_manager_address_b))<='0';
            
          end if;
            
            
            
            
            
            
            
            
            
            if read='0'
            then
 ---->    ---->          ---->          ---->          ---->          ---->          ---->          ---->          ---->                

mem_manager(0)<="0000000000011000000000011000000000000000000100000";
mem_manager(1)<="0000000000011000000000011000000000000000000101001";
mem_manager(2)<="0000000000011000000000011000000000000000000110010";
mem_manager(3)<="0000000000011000000000011000000000000000000111011";
mem_manager(4)<="0000000000011000000000011000000000000000001000100";
mem_manager(5)<="0000000000011000000000011000000000000000001001101";
mem_manager(6)<="0000000000011000000000011000000000000000001010110";
    
 ---->    ---->          ---->          ---->          ---->          ---->          ---->          ---->          ---->                   
 ---->    ---->          ---->          ---->          ---->          ---->          ---->          ---->          ---->      
            read:='1';
             elsif falling_edge(CLK)  and (mem_manager_rw = "001"  or mem_manager_rw = "10") then
                 
                 if mem_manager_rw="01" then
                 mem_manager(conv_integer(mem_manager_write_loc))<='0'&mem_manager_write_TR&mem_manager_write_TC&na;
                 na := (mem_manager_write_TR*mem_manager_write_TC)+na;
                  
                  elsif mem_manager_rw="010" then
                      mem_manager(conv_integer(mem_manager_write_loc))<='0'&mem_manager_write_TR&mem_manager_write_TC&mem_manager_row_a(bits_total-bits_size_total_rows-bits_size_total_cols-1 downto 0);
                                   
               end if; 
                   end if; 
               
          end process;
          
          
          
          --- This is the Write to mem_manager part , The momory will be weittrn on Falling Edge of Clock
          
        
        
          
          
          
end arc_mem_manager;



