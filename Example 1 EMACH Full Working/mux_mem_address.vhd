

library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;

-- This basically a mux that can be used for data (specifically for size of data objects)

  entity mux_mem_address is
      port (
              mux_mem_address_in_a,mux_mem_address_in_b,mux_mem_address_in_c,mux_mem_address_in_d        :in memory_address;
              mux_mem_address_sel                                                                        :in sel_2bit;
              mux_mem_address_out                                                                        :out memory_address
            );
  end mux_mem_address;

 
  architecture arc_mux_mem_address of mux_mem_address is
  begin
      mux_mem_address_out <= 
          mux_mem_address_in_a when mux_mem_address_sel= "00" else
          mux_mem_address_in_b when mux_mem_address_sel= "01" else
          mux_mem_address_in_c when mux_mem_address_sel= "10" else
          mux_mem_address_in_d;

  end arc_mux_mem_address;
	
	



