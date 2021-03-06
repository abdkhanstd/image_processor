
library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.fixed_alg_pkg.all;
use work.definitions.all;



Package functions is

        function "+"  ( a: in mem_cell;  b: in mem_cell ) return mem_cell;
        function "-"  ( a: in mem_cell;  b: in mem_cell ) return mem_cell;
        function "/"  ( a: in mem_cell;  b: in mem_cell ) return mem_cell;  --Divide with Real part of b                
        function "*"  ( a: in mem_cell;  b: in mem_cell ) return mem_cell;
        function "**"  ( a: in mem_cell;  b: in mem_cell ) return mem_cell;        
        function conj ( a: in mem_cell)                   return mem_cell;
        
        function chk ( a: in mem_cell)                   return mem_cell;








end  functions;

