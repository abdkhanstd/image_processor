


library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;

-- This basically a mux that can be used for data (specifically for size of data objects)

  entity mux_done is
      port (
              mux_done_in_a,mux_done_in_b,mux_done_in_c,mux_done_in_d   :in  flag;
              mux_done_in_e,mux_done_in_f,mux_done_in_g,mux_done_in_h   :in  flag;
              mux_done_sel                                              :in  sel_3bit;
              mux_done_out                                              :out flag
            );
  end mux_done;

 
  architecture arc_mux_done of mux_done is
  begin
      mux_done_out <= 
          mux_done_in_a when mux_done_sel= "000" else
          mux_done_in_b when mux_done_sel= "001" else
          mux_done_in_c when mux_done_sel= "010" else
          mux_done_in_d when mux_done_sel= "011" else
          mux_done_in_e when mux_done_sel= "100" else
          mux_done_in_f when mux_done_sel= "101" else
          mux_done_in_g when mux_done_sel= "110" else
          mux_done_in_h when mux_done_sel= "111";


  end arc_mux_done;
	
	


