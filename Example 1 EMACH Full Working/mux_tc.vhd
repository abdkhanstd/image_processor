


library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;

-- This basically a mux that can be used for data (specifically for size of data objects)

  entity mux_tc is
      port (
              mux_tc_in_a,mux_tc_in_b,mux_tc_in_c      :in mem_manager_total_cols;
              mux_tc_sel                               :in sel_2bit;
              mux_tc_out                               :out mem_manager_total_cols
            );
  end mux_tc;

 
  architecture arc_mux_tc of mux_tc is
  begin
      mux_tc_out <= 
          mux_tc_in_a when mux_tc_sel= "00" else
          mux_tc_in_b when mux_tc_sel= "01" else
          mux_tc_in_c;


  end arc_mux_tc;
	
	

