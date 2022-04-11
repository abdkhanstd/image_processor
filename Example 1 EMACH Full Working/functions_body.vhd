library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.fixed_alg_pkg.all;
use work.definitions.all;
use work.fixed_pkg_c.to_slv;
use ieee.numeric_std.all;


Package body functions is
    
    
    function chk ( a: in mem_cell) return mem_cell is
	  variable tmp : mem_cell;
	  variable ref:fpoint;
	  begin
    
    tmp:=a;
    if (to_slv(abs(to_sfixed(a.c,ref))) < thold) then
        tmp.c:=zero_std;
    end if;    
    
    if (to_slv(abs(to_sfixed(a.r,ref)))< thold) then
        tmp.r:=zero_std;
    end if;
         
          return (tmp.r , tmp.c);
       
    
     end chk;
    
    
    
    
    
    
    function conj ( a: in mem_cell) return mem_cell is
	   variable tmp_1 : rmfpoint;
	   variable ref:fpoint;
	   variable tmp_2 : fpoint;
    begin
    
          tmp_1:=to_sfixed(-1,ref)*to_sfixed(a.c,ref);
          tmp_2:=tmp_1( ip downto fp);
          
          return (a.r , to_slv(tmp_2));
       
    
     end conj;
    
    
    
    function "+" ( a: in mem_cell; b: in mem_cell ) return mem_cell is
    begin
    	   		return (a.r + b.r, a.c + b.c);
    end "+";    
       
 
 
   function "-" ( a: in mem_cell; b: in mem_cell ) return mem_cell is
    begin
    	   		return (a.r - b.r, a.c - b.c);
    end "-";        
       
       
   function "*" ( a: in mem_cell; b: in mem_cell ) return mem_cell is
  		variable tmp_1,tmp_2,tmp_3,tmp_4 : rmfpoint;
  		variable ref:fpoint;
    begin
      tmp_1:=to_sfixed(a.r,ref) * to_sfixed(b.r,ref);
      tmp_2:=to_sfixed(a.c,ref) * to_sfixed(b.c,ref);
      
      tmp_3:=to_sfixed(a.r,ref) * to_sfixed( b.c,ref);
      tmp_4:=to_sfixed(a.c,ref) * to_sfixed( b.r,ref);
      

        return (to_slv(tmp_1(ip downto fp )) - to_slv(tmp_2(ip downto fp )),to_slv( tmp_3(ip downto fp ))+ to_slv(tmp_4(ip downto fp )));
      

    end "*";        
              
      function "/" ( a: in mem_cell; b: mem_cell ) return mem_cell is  --This is not Complex Division

      variable ref,arr,acc:fpoint;
      variable ar,ac :rdfpoint;
      begin
        
               ar:=to_sfixed(a.r,ref)/to_sfixed(b.r,ref);
               ac:=to_sfixed(a.c,ref)/to_sfixed(b.r,ref);
               
                arr:=ar(ip downto 0) & ar(-1 downto fp) ;     
                 acc:=ac(ip downto 0) & ac(-1 downto fp) ;    
        
	         return (to_slv(arr),to_slv(acc));   
      
      end "/"; 
      
      
      function "**" ( a: in mem_cell; b: mem_cell ) return mem_cell is  --This is not Complex Power

      --variable ref,arr,acc:fpoint;
      variable ar,ac :fpoint;
      variable ref:fpoint;
      begin
        
               ar:=to_sfixed(a.r,ref)**to_sfixed(b.r,ref);
               ac:=to_sfixed(a.c,ref)**to_sfixed(b.r,ref);
               
        
	         return (to_slv(ar),to_slv(ac));   
      
      end "**"; 
        
end package body  functions;

