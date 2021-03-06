
-- This is an 8 bit counter_imem actually will work 0 - 255 will have a trigger 

library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;





      entity counter_imem is
          port ( 
	                 clk,reset,jmp             :in   flag;
	                 counter_imem_in           :in   counter_imem_address;
	                 counter_imem_out          :out  counter_imem_address
	                                                                               

                );
      end counter_imem;

  architecture arc_counter_imem of counter_imem is
  begin
    
    
    
    
    
    process(clk,jmp)
    begin
      
      if rising_edge(clk) and jmp ='0'
      then
        counter_imem_out<=counter_imem_in+(universal_zero_std(imem_address_size-1 downto 1)&'1');
        
    elsif jmp ='1' then
          counter_imem_out<=counter_imem_in;
            
      end if;
        
      if   reset='1'
      then
          counter_imem_out<= universal_zero_std(imem_address_size-1 downto 0);
      end if;
        
      
    end process;
  
  
  
  
  
  
  
  end arc_counter_imem;

