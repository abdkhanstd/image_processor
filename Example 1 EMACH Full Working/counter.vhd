
-- This is an 8 bit counter actually will work 0 - 255 will have a trigger 

library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;





      entity counter is
          port ( 
	                 clk,clkk                  :in  flag;
	                 done                      :out flag;
	                 start_val,end_val         :in  counter_address;
	                 jump                      :in  counter_address :="0000000000001";
 	                 out_counter               :out counter_address :="0000000000001";
                   done_on_last_val          :out flag; 
                   reset                     :in flag                   
                                      
                   
                );
      end counter;

  architecture arc_counter of counter is
  --signal loaded:flag :='0';
  
  begin
    
    
    
    process(clk,clkk,reset)
    variable val:counter_address :="0000000000001";
    variable don:flag :='0';
    begin
      
          
            if falling_edge(clkk)
            then 
              done <=  don and clkk;

            end if;
          
          
          if rising_edge(reset)
                then
                  
                    val:=start_val;
                    out_counter<=val;
                      
           elsif rising_edge(clk)
            then
                        
                
                       if val=end_val-1
                      then
                       done_on_last_val<='1';
                     else
                       done_on_last_val<='0';
                     end if;
                  
                  if val <= end_val-jump
                  then
                      
                  
                      
                      val:=val+jump;
                      out_counter<=val;
                      don:='0';
                      done <= don;
                    else
                     
                     val:=start_val;
                     out_counter<=val;
                      
                     don:='1';
                     done <= don;
                    end if;
                 
              
                  
             end if;  
                             
      
      
      
    end process;
  
  
  
  
  
  
  
  end arc_counter;
