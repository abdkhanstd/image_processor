


-- This is an 8 bit reg_hold_mem_address actually will work 0 - 255 will have a trigger 

library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;





      entity reg_hold_mem_address is
          port ( 
	                 clk                                        :in   flag;
	                 reg_hold_mem_address_in                    :in   memory_address;
	                 reg_hold_mem_address_out                   :out  memory_address
	                                                                               

                );
      end reg_hold_mem_address;

  architecture arc_reg_hold_mem_address of reg_hold_mem_address is
  begin
    
    
    
    process(clk)
    begin
     
            
      if rising_edge(clk)
      then
        reg_hold_mem_address_out<=reg_hold_mem_address_in;                    
      end if;
      
    end process;
  
  
  
  
  
  
  
  end arc_reg_hold_mem_address;





