


library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;

-- This basically a mux that can be used for data (specifically for size of data objects)

  entity mux_counter is
      port (
              mux_counter_in_a,mux_counter_in_b,mux_counter_in_c,mux_counter_in_d,mux_counter_in_e      :in counter_address;
              mux_counter_sel                                                                           :in sel_3bit;
              mux_counter_out                                                                           :out counter_address
            );
  end mux_counter;

 
  architecture arc_mux_counter of mux_counter is
  begin
      mux_counter_out <= 
          mux_counter_in_a when mux_counter_sel= "000" else
          mux_counter_in_b when mux_counter_sel= "001" else
          mux_counter_in_c when mux_counter_sel= "010" else
          mux_counter_in_d when mux_counter_sel= "011" else
          mux_counter_in_e;

  end arc_mux_counter;
	
	




