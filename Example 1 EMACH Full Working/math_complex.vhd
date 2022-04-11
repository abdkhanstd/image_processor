
library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.fixed_alg_pkg.all;
use work.definitions.all;



Package math_complex is

        function "+" ( a: in mem_cell;  b: in mem_cell ) return mem_cell;
        function "-" ( a: in mem_cell;  b: in mem_cell ) return mem_cell;
        function "/" ( a: in mem_cell;  b: in mem_cell ) return mem_cell;                
        function "*" ( a: in mem_cell;  b: in mem_cell ) return mem_cell;









end  math_complex;

Package body math_complex is
        
        
end  math_complex;