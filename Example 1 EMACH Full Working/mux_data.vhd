

library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;

-- This basically a mux that can be used for data (specifically for size of data objects)

  entity mux_data is
      port (
              mux_data_in_a,mux_data_in_b,mux_data_in_c,mux_data_in_d   :in mem_cell;
              mux_data_in_e,mux_data_in_f                               :in mem_cell;
              mux_data_sel                                              :in sel_3bit;
              mux_data_out                                              :out mem_cell
            );
  end mux_data;

 
  architecture arc_mux_data of mux_data is
  begin
      mux_data_out <= 
          mux_data_in_a when mux_data_sel= "000" else
          mux_data_in_b when mux_data_sel= "001" else
          mux_data_in_c when mux_data_sel= "010" else
          mux_data_in_d when mux_data_sel= "011" else
          mux_data_in_e when mux_data_sel= "100" else                    
      	   mux_data_in_f;


  end arc_mux_data;
	
	

