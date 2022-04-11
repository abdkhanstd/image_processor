library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.fixed_alg_pkg.all;
use work.definitions.all;
use work.fixed_pkg_c.to_slv;

entity Counter_Test is
port ( 
	a:in fpoint;
	b:out fpoint
);
end Counter_Test;



architecture arc_Counter_Test of Counter_Test is 
component clock
    GENERIC (period :      TIME      := 50 ns);
    PORT    (clk    :  OUT std_logic := '0');
end component;

      component counter
          port ( 
	                 clk                       :in  flag;
	                 done                      :out flag;
	                 start_val,end_val         :in  counter_address;
	                 jump                      :in  counter_address :="000000001";
 	                 out_counter               :out counter_address 

                );
      end component;
      component reg 
          port ( 
	                 clk                       :in   flag;
	                 reg_in                    :in   data;
	                 reg_out                   :out  data :="0000000000000"
	                                                                               

                );
      end component;
      
      component counter_imem 
          port ( 
	                 clk                       :in   flag;
	                 counter_imem_in           :in   counter_imem_address;
	                 counter_imem_out          :out  counter_imem_address 
	                                                                               

                );
      end component;
       component sub2ind is
          port ( 
	                 clk                       :in   flag;
	                 r,c                       :in   counter_address;
	                 tc                        :in   mem_manager_total_cols;
	                 index                     :out  memory_address
	                                                                               

                );
      end component;  
  
  -----
  

  signal clk,done,done_2:flag;
  signal start_val,end_val,jump :counter_address;
  signal X,Y:counter_address;
  signal XX,YY:data;
  signal in_c,out_c :counter_address;
  signal index:memory_address;
  begin
    

     start_val<="000000001";
     end_val  <="000100000";
     jump<="000000001";
  
      
    in_c<=X;
    XX<="0000"&X;
    clk_use :clock port map(clk);
    counter_X: counter port map (clk,done,start_val,end_val,jump,X);
    counter_Y: counter port map (done,done_2,start_val,end_val,jump,Y);
    --counter_imem_port: counter_imem port map (clk,in_c,out_c);
    reg_port: reg  port map (clk,XX,YY);
    sub: sub2ind  port map (clk,Y,X,"00100000",index);
      
    
  
  
end arc_Counter_Test;






