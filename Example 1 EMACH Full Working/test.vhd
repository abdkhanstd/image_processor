library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.fixed_alg_pkg.all;
use work.definitions.all;
use work.fixed_pkg_c.to_slv;

entity test is
port ( 
	a:in fpoint;
	b:out fpoint
);
end test;



architecture arc_test of test is 
--------------------------------------------------------------------------
component alu
     port ( 
                	alu_in_a,alu_in_b    :in data;
                	alu_command          :in command_alu;
                	alu_out_a,alu_out_b  :out data;
                	alu_flag             :out flag
            );
  end component;
--------------------------------------------------------------------------
  
signal s1,s2: data;
signal result_a,result_b:data;
signal dummy : fpoint;
signal s3 :data; 
signal flag:flag;

signal cmd:command_alu;
begin
 
  
  

s1 <=  to_slv(to_sfixed (-2.5,dummy));     -- s2 = "11001100" = -6.5
s2 <=  to_slv(to_sfixed (-2.5,dummy));

stim_proc: process
   begin 
cmd <=alu_add_fp;
wait for 7 ns;
cmd <=alu_sub_fp;
wait for 7 ns;
cmd <=alu_mul_fp;
wait for 7 ns;
cmd <=alu_div_fp;
wait for 7 ns;
cmd <=alu_sqrt_fp;
wait for 7 ns;
cmd <=alu_pow_fp;
wait for 7 ns;

  end process;

  
  AlU_Check :alu port map (s1,s2,cmd,result_a,result_b,flag);
  
  
  
  
  
  
end arc_test;

