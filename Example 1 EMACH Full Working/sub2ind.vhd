
-- This is an 8 bit sub2ind actually will work 0 - 255 will have a trigger 

library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;





      entity sub2ind is
          port ( 
	                 clk                       :in   flag;
	                 r,c                       :in   counter_address;
	                 tc                        :in   mem_manager_total_cols;
	                 index                     :out  memory_address
	                                                                               

                );
      end sub2ind;

  architecture arc_sub2ind of sub2ind is
    signal  a_r,a_c              :memory_address;
	  signal  a_tc                 :memory_address;
	  signal  one                  :memory_address;
	  signal  result               :std_logic_vector((2*memory_address_bits)-1 downto 0);
  begin
                
   ---Converting r , c tc to the size memory_address (Zero Padding)
    
one<=(universal_zero_std(memory_address_bits downto 2) & '1');  -- 1
a_r<=(universal_zero_std(memory_address_bits-bits_size_total_rows downto 2) & r); -- r
a_c<=(universal_zero_std(memory_address_bits-bits_size_total_rows downto 2) & c); -- c

a_tc<=universal_zero_std(memory_address_bits-bits_size_total_rows downto 1) & tc ;--tc
    
                
  result<=   ((a_r-one)*a_tc)+a_c;
  
  index<=result(memory_address_bits-1 downto 0);
      

  
  
  
  
  
  
  
  end arc_sub2ind;





