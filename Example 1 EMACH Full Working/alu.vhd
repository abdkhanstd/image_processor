
library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.fixed_alg_pkg.all;
use work.definitions.all;
use work.functions.all;
use work.fixed_pkg_c.to_slv;

  entity alu is
      port ( 
                	conj_a,conj_b            :in flag;
                	alu_in_av,alu_in_bv       :in mem_cell;
                	alu_command               :in command_alu;
                	alu_out_a,alu_out_b       :out mem_cell;
                	alu_flag                  :out flag :='0'
            );
  end alu;


  architecture arc_alu of alu is 
  
  signal in_a,in_b :real;
  signal out_a_real,out_a_complex :real;
  signal ref:fpoint;
  signal tmp,tmp2,alu_in_a,alu_in_b:mem_cell;
  
  begin
        alu_in_a<=conj(alu_in_av) when  conj_a ='1' else
                    alu_in_av;

        alu_in_b<=conj(alu_in_bv) when  conj_b ='1' else
                  alu_in_bv;
        
        
        --replace tmp when synthesizing
            alu_out_a<=tmp;



            tmp<=
            
            (alu_in_a+alu_in_b)         when        alu_command = alu_add_fp else
            (alu_in_a-alu_in_b)         when        alu_command = alu_sub_fp else
            (alu_in_a**alu_in_b)        when        alu_command = alu_pow_fp else 
            (alu_in_a*alu_in_b)         when        alu_command = alu_mul_fp else 
            (alu_in_a/alu_in_b)         when        alu_command = alu_div_fp else    
            (tmp2)                      when        alu_command = alu_real;  
            
            
            
            
            tmp2.r<=alu_in_av.r;
            tmp2.c<=zero_std;
            
                   

-----------------------------------------------------------------------------------------    
      
      
      -- Comparison done only on real Part
      alu_flag<=  
  		              
 		         '1'   when alu_command = alu_eq_fp     and (alu_in_a.r   =  alu_in_b.r)    else
  		         '1'   when alu_command = alu_neq_fp    and (alu_in_a.r  /=  alu_in_b.r)    else  		   
  		         '1'   when alu_command = alu_lt        and (alu_in_a.r   <  alu_in_b.r)    else
  		         '1'   when alu_command = alu_gt        and (alu_in_a.r   >  alu_in_b.r)    else
  		         '1'   when alu_command = alu_JGT_ABS   and (to_slv(abs(to_sfixed(alu_in_a.r,ref)))   >  to_slv(abs(to_sfixed(alu_in_b.r,ref))))    else  		         
  		         '1'   when alu_command = alu_lteq      and (alu_in_a.r  <=  alu_in_b.r)    else
  		         '1'   when alu_command = alu_gteq      and (alu_in_a.r  >=  alu_in_b.r)    else
  		         '1'   when alu_command = alu_jmp                                           else   -----Just raise the flag
  		         '0';


  		        
  		  
-----------------------------------------------------------------------------------------
  		  
  		  in_a<=to_real(to_sfixed(alu_in_a.r,ref));
  		  in_b<=to_real(to_sfixed(alu_in_b.r,ref));
  		  out_a_real<=to_real(to_sfixed(tmp.r,ref));
  		  out_a_complex<=to_real(to_sfixed(tmp.c,ref));
  
          
  
  end arc_alu;