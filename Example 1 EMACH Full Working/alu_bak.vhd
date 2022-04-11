
library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.fixed_alg_pkg.all;
use work.definitions.all;
use work.fixed_pkg_c.to_slv;

  entity alu is
      port ( 
                	alu_in_a,alu_in_b         :in mem_cell;
                	alu_command               :in command_alu;
                	alu_out_a,alu_out_b       :out mem_cell;
                	alu_flag                  :out flag :='0'
            );
  end alu;


  architecture arc_alu of alu is 
--Real Part  
  
  signal result_r                       :rfpoint;
  signal alu_op_fp_a_r,alu_op_fp_b_r    :fpoint;
  signal result_r_sqrt_r                :fpoint; 
  signal result_r_mul_r                 :rmfpoint;
  signal result_r_div_r                 :rdfpoint;
  signal out_a_r,out_b_r                :data;
  



  
    
  --non synthsizeable
  signal alu_in_real_a,alu_in_real_b,alu_out_real_a,alu_out_real_b :real;
   
  begin
    
    
      alu_op_fp_a_r<=to_sfixed(alu_in_a.r,alu_op_fp_a_r);
      alu_op_fp_b_r<=to_sfixed(alu_in_b.r,alu_op_fp_b_r);
       
  		   result_r <= 
  
      (alu_op_fp_a_r+alu_op_fp_b_r)	                                       when alu_command = alu_add_fp      else
		  (alu_op_fp_a_r-alu_op_fp_b_r)	                                       when alu_command = alu_sub_fp      else
		  result_r_div_r(ip+1 downto 0) & result_r_div_r(-1 downto fp)         when alu_command = alu_div_fp      else
		  '0'&(power_of(alu_op_fp_a_r,alu_op_fp_b_r))                          when alu_command = alu_pow_fp      else
  		  '0'&(sqrt(alu_op_fp_a_r))                                            when alu_command = alu_sqrt_fp     else
		  result_r_mul_r(ip+1 downto 0) & result_r_mul_r(-1 downto fp)         when alu_command = alu_mul_fp      else
       unknown ;
      
       out_b_r<=
      --For Integer values 
      (alu_in_a.r+alu_in_b.r)   when alu_command = alu_add  else
      (alu_in_a.r-alu_in_b.r)	  when alu_command = alu_sub  else
      
      
      to_slv(unknown(ip downto fp));
 		 
  		  alu_out_b.r<=out_b_r;
	    out_a_r<=to_slv(result_r(ip downto fp));
  		  
  		  
  		  -- Truncating and pushong out the result_rs
  		  alu_out_a.r <= to_slv(result_r(ip downto fp));
  		  
  		  
  		
  		  
  		  -- Calculating Multiplication result_rs seprately According to fixed point IEEE Standards
  		  result_r_mul_r <=(alu_op_fp_a_r * alu_op_fp_b_r);
  	   
  		  
  		  
  		  -- Calculating Division (Newton Ralphson Methods) result_rs seprately According to fixed point IEEE Standards
		  result_r_div_r<=alu_op_fp_a_r/alu_op_fp_b_r;
  		  
  		  
  		  
  		  
-----------------------------------------------------------------------------------------
  		  
  		  
  		   alu_flag<=  
  		   
  		   '1'   when alu_command = alu_eq_fp     and (alu_op_fp_a_r   =  alu_op_fp_b_r)    else
  		   '1'   when alu_command = alu_neq_fp    and (alu_op_fp_a_r  /=  alu_op_fp_b_r)    else  		   
  		   '1'   when alu_command = alu_lt_fp     and (alu_op_fp_a_r   <  alu_op_fp_b_r)    else
  		   '1'   when alu_command = alu_gt_fp     and (alu_op_fp_a_r   >  alu_op_fp_b_r)    else
  		   '1'   when alu_command = alu_lteq_fp   and (alu_op_fp_a_r  <=  alu_op_fp_b_r)    else
  		   '1'   when alu_command = alu_gteq_fp   and (alu_op_fp_a_r  >=  alu_op_fp_b_r)    else
  		   --For Integer values
		   '1'   when alu_command = alu_eq        and (alu_in_a.r   =  alu_in_b.r)          else
  		   '1'   when alu_command = alu_neq       and (alu_in_a.r  /=  alu_in_b.r)          else  		   
  		   '1'   when alu_command = alu_lt        and (alu_in_a.r   <  alu_in_b.r)          else
  		   '1'   when alu_command = alu_gt        and (alu_in_a.r   >  alu_in_b.r)          else
  		   '1'   when alu_command = alu_lteq      and (alu_in_a.r  <=  alu_in_b.r)          else
  		   '1'   when alu_command = alu_gteq      and (alu_in_a.r  >=  alu_in_b.r)          else
  		   '1'   when alu_command = alu_jmp                                             else   -----Just raise the flag
  		   '0';
  		   
-- Remove this part not synthesizeable
alu_in_real_a <=to_real(alu_op_fp_a_r);
alu_in_real_b <=to_real(alu_op_fp_b_r);
alu_out_real_a <=to_real(to_sfixed(out_a_r,result_r_sqrt_r));
alu_out_real_b <=to_real(to_sfixed(out_b_r,result_r_sqrt_r));
        
          
  
  end arc_alu;
