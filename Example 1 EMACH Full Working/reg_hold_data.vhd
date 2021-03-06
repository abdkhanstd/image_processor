

-- This is an 8 bit reg_hold_data actually will work 0 - 255 will have a trigger 

library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;





      entity reg_hold_data is
          port ( 
	                 clk                                 :in   flag;
	                 reg_hold_data_in                    :in   data;
	                 reg_hold_data_out                   :out  data 
	                                                                               

                );
      end reg_hold_data;

  architecture arc_reg_hold_data of reg_hold_data is
  begin
    
    
    
    process(clk)
    begin
     
            
      if rising_edge(clk)
      then
        reg_hold_data_out<=reg_hold_data_in;                    
      end if;
      
    end process;
  
  
  
  
  
  
  
  end arc_reg_hold_data;




