
library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.fixed_alg_pkg.all;
use work.definitions.all;
use work.fixed_pkg_c.to_slv;

entity stim_main is

end stim_main;



architecture arc_stim_main of stim_main is 
component clock
    GENERIC (period :      TIME      := 20 ns);
    PORT    (clk    :  OUT std_logic := '0');
end component;

component main 
          port ( 
	                 clk                       :in   flag;
 	                 reset                     :in   flag
                );
      end component;
  
signal clk,rst :flag;  
begin


stim_proc: process
   begin 
      rst<='1';
      wait for 5 ns;
      rst<='0';
      wait;
end process;


clk_i:clock port map  (clk);
main_i:main port map (clk,rst);
  


    
  
  
end arc_stim_main;







