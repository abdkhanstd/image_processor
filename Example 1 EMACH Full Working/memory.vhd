
library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;


--remove these
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_textio.all;
use std.textio.all; -- remove
use ieee.std_logic_arith.all;

  entity memory is
      port ( 
             clk,memory_write_enable                                  :in flag :='0' ;
             memory_address_a,memory_address_b,memory_write_address   :in memory_address;             
             memory_data_out_a,memory_data_out_b                      :out mem_cell;
             memory_data_in                                           :in mem_cell 

              
            );
  end memory;
  
  
  
  
  architecture arc_memory of memory is
--------------------------------------------------------
-------------Loading from file--------------------------
--------------------------------------------------------
procedure LoadFile(signal im   	: out memory_array;
                             constant filename 	: in  string) is
                             file     ifile  		: text is in filename;
                             variable iline  		: line;
                             variable tmp      : bit_vector(ip-fp downto 0);
                             variable ok       : boolean := false;
                             variable i        : natural := 0;
                             
                             
                             
begin --procedue from loading file
i := 32;
while not endfile(ifile)loop
	readline(ifile, iline);
	read(iline, tmp, ok);
	im(i).r <= TO_STDLOGICVECTOR(tmp);
	readline(ifile, iline);
	read(iline, tmp, ok);
	im(i).c <= TO_STDLOGICVECTOR(tmp);
	i := i + 1;
	
end loop;
end LoadFile;
--------------------------------------------------------




    signal data_in_real,data_in_complex,data_out_a,data_out_b :real; ---remove 
    signal tmp:fpoint;---remove 
    signal main_memory:memory_array;
    signal ta,tb :mem_cell;
    begin
          --- This is the read part ,not sequential
          
                 
          
             
          
          --- This is the Write to memory part , The momory will be weittrn on Falling Edge of Clock
          
          process (clk,memory_write_enable,memory_address_a,memory_address_b,memory_write_address)

          variable read:integer :=0;
          begin
            
            
                if read=0
                then 
                  LoadFile(main_memory, "mem.abd");
                  read:=1;
                end if;
                  
            
           
                memory_data_out_a <= 	main_memory(conv_integer(memory_address_a));
        	       memory_data_out_b <= 	main_memory(conv_integer(memory_address_b));
        	       ta    <=    main_memory(conv_integer(memory_address_a));
        	       tb    <=    main_memory(conv_integer(memory_address_b)); 
           
             if falling_edge(CLK)  and memory_write_enable = '1' then
                  main_memory(conv_integer(memory_write_address))<=memory_data_in;
             end if;
          end process;
          
          ------------------ This part not synthesizeable remove it
         tmp<=to_sfixed(memory_data_in.r,tmp);
          data_in_real<=to_real(tmp);
          data_out_a<=to_real(to_sfixed(ta.r,tmp));
          data_out_b<=to_real(to_sfixed(tb.r,tmp));
          data_in_complex<=to_real( to_sfixed(memory_data_in.c,tmp));
end arc_memory;




