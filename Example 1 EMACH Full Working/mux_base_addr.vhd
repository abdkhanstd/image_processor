

library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;

-- This basically a mux that can be used for data (specifically for size of data objects)

  entity mux_base_address is
      port (
              mux_base_address_in_a,mux_base_address_in_b,mux_base_address_in_c      :in memory_address;
              mux_base_address_sel                                                   :in sel_2bit;
              mux_base_address_out                                                   :out memory_address
            );
  end mux_base_address;

 
  architecture arc_mux_base_address of mux_base_address is
  begin
      mux_base_address_out <= 
          mux_base_address_in_a when mux_base_address_sel= "00" else
          mux_base_address_in_b when mux_base_address_sel= "01" else
          mux_base_address_in_c;


  end arc_mux_base_address;
	
	
