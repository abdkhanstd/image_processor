


library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;

-- This basically a mux that can be used for data (specifically for size of data objects)

  entity mux_imem is
      port (
              mux_imem_in_a,mux_imem_in_b  :in  counter_imem_address;
              mux_imem_sel                 :in  sel_1bit;
              mux_imem_out                 :out counter_imem_address
            );
  end mux_imem;

 
  architecture arc_mux_imem of mux_imem is
  begin
      mux_imem_out <= 
          mux_imem_in_a when mux_imem_sel= '0' else
     	    mux_imem_in_b;


  end arc_mux_imem;
	
	


