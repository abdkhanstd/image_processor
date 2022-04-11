


library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;

-- This basically a mux that can be used for data (specifically for size of data objects)

  entity mux_mem_mgr is
      port (
              mux_mem_mgr_in_a,mux_mem_mgr_in_b,mux_mem_mgr_in_c           :in mem_manager_total_rows;
              mux_mem_mgr_in_d,mux_mem_mgr_in_e,mux_mem_mgr_in_f           :in mem_manager_total_rows;
              mux_mem_mgr_sel                                              :in sel_3bit;
              mux_mem_mgr_out                                              :out counter_address
            );
  end mux_mem_mgr;

 
  architecture arc_mux_mem_mgr of mux_mem_mgr is
  begin
      mux_mem_mgr_out <= 
          '0' & mux_mem_mgr_in_a when mux_mem_mgr_sel= "000" else
          '0' & mux_mem_mgr_in_b when mux_mem_mgr_sel= "001" else
          '0' & mux_mem_mgr_in_c when mux_mem_mgr_sel= "010" else
          '0' & mux_mem_mgr_in_d when mux_mem_mgr_sel= "011" else
          '0' & mux_mem_mgr_in_e when mux_mem_mgr_sel= "100" else
          '0' & mux_mem_mgr_in_f when mux_mem_mgr_sel= "101";    	 


  end arc_mux_mem_mgr;
	
	


