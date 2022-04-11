

-- This is an 8 bit reg_hold_jump_address actually will work 0 - 255 will have a trigger 

library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;





      entity reg_hold_jump_address is
          port ( 
	                 clk                                         :in   flag;
	                 reg_hold_jump_address_in                    :in   counter_imem_address;
	                 reg_hold_jump_address_out                   :out  counter_imem_address 
	                                                                               

                );
      end reg_hold_jump_address;

  architecture arc_reg_hold_jump_address of reg_hold_jump_address is
  begin
    
    
    
    process(clk)
    begin
     
     if clk'event and clk='1'
      then
        reg_hold_jump_address_out<=reg_hold_jump_address_in;                    
      end if;
      
    end process;
  
  
  
  
  
  
  
  end arc_reg_hold_jump_address;






