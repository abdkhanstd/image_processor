

-- This is an 8 bit reg_lsr actually will work 0 - 255 will have a trigger 

library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;





      entity reg_lsr is
          port ( 
	                 clk                           :in   flag;
	                 reg_lsr_in                    :in   mem_cell;
	                 reg_lsr_out                   :out  mem_cell
	                                                                               

                );
      end reg_lsr;

  architecture arc_reg_lsr of reg_lsr is
  begin
    
    
    
    process(clk)
    begin
     
            
      if rising_edge(clk)
      then
        reg_lsr_out<=reg_lsr_in;                    
      end if;
      
    end process;
  
  
  
  
  
  
  
  end arc_reg_lsr;






