

-- This is an 8 bit reg_mux_imem actually will work 0 - 255 will have a trigger 

library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;





      entity reg_mux_imem is
          port ( 
	                 clk                                :in   flag;
	                 reg_mux_imem_in                    :in   flag;
	                 reg_mux_imem_out                   :out  flag 
	                                                                               

                );
      end reg_mux_imem;

  architecture arc_reg_mux_imem of reg_mux_imem is
  begin
    
    
    
    process(clk)
    begin
     
     if clk'event and clk='1'
      then
        reg_mux_imem_out<=reg_mux_imem_in;                    
      end if;
      
    end process;
  
  
  
  
  
  
  
  end arc_reg_mux_imem;




