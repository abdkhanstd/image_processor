
-- This is an 8 bit reg actually will work 0 - 255 will have a trigger 

library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;





      entity reg is
          port ( 
	                 clk,reset                 :in   flag;
	                 reg_in                    :in   mem_cell;
	                 reg_out                   :out  mem_cell
	                                                                               

                );
      end reg;

  architecture arc_reg of reg is
  begin
    
    
    
    process(clk,reset)
     variable loaded:flag :='0';
    begin
     
     if loaded='0' and clk='1'
     then
       reg_out.r<=zero_std;
       reg_out.c<=zero_std;
       loaded:='1';
     
     elsif reset'event and rising_edge(reset)
      then
       reg_out.r<=zero_std;
       reg_out.c<=zero_std;
        
       elsif clk'event and clk='1'
      then
        reg_out<=reg_in;                    
      end if;
      
    end process;
  
  
  
  
  
  
  
  end arc_reg;



