library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.fixed_alg_pkg.all;
use work.definitions.all;
use work.fixed_pkg_c.to_slv;

entity mem_test is
port ( 
	a:in fpoint;
	b:out fpoint
);
end mem_test;



architecture arc_mem_test of mem_test is 
component clock
    GENERIC (period :      TIME      := 50 ns);
    PORT    (clk    :  OUT std_logic := '0');
end component;


component memory
      port ( 
             clk,memory_write_enable                                  :in flag;
             memory_address_a,memory_address_b,memory_write_address   :in memory_address;             
             memory_data_out_a,memory_data_out_b                      :out data;
             memory_data_in                                           :in data

              
            );
  end component;
  
  -----
  
  signal add_a,add_b,add_wr :memory_address;
  signal out_a,out_b,data_in :data;
  signal clk,we:flag;
  begin
    
  this:process
  begin  
        wait for 50 ns;
      we<='1'; 
     data_in <="0000000000000";
    add_wr<="00000000000000000000";
     
     wait for 50 ns;
        we<='0'; 
     add_a<="00000000000000000000";
      
      
      wait;
    end process;
      
    
    clk_use :clock port map(clk);
    mem_use:memory port map (clk,we,add_a,add_b,add_wr,out_a,out_b,data_in);  
      
    
  
  
end arc_mem_test;




