library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;

package emach is
    

      
   
   
    --Now naming Matrix locations for my own ease 
    
    signal  FFT_MARTRIX     : mem_manager_address  := M0;   --M0
    signal  L_X             : mem_manager_address  := M2;   --M1
    signal  L_Y             : mem_manager_address  := M3;   --M2
    signal  IDM             : mem_manager_address  := M1;   --M1
    signal  ti_1            : mem_manager_address  := M4;   --M4    
    signal  ti_2            : mem_manager_address  := M5;   --M5    
    signal  ti_3            : mem_manager_address  := M6;   --M6            
    
---------------------------------------------------------------------------------
    
    signal  fft_ti_1        : mem_manager_address  := M7;   
    signal  fft_ti_2        : mem_manager_address  := M8;   
    signal  fft_ti_3        : mem_manager_address  := M9;           
 
 -- Signals for writing Back to original locations of Training images 
    signal  fft2_ti_1        : mem_manager_address  := M4;   
    signal  fft2_ti_2        : mem_manager_address  := M5;   
    signal  fft2_ti_3        : mem_manager_address  := M6;  
    
    
-- FOR FFT MEAN

    signal  SUM_FFT               : mem_manager_address  := M7;    
    signal  MEAN_FFT              : mem_manager_address  := M7;      
    
    
    signal  MEAN_FFT_Ti_diff      : mem_manager_address  := M8;  
    
    signal  ti_fft_diff_1         : mem_manager_address  := M9;
    signal  ti_fft_diff_2         : mem_manager_address  := M0;
    signal  ti_fft_diff_3         : mem_manager_address  := M8;            
    

    signal  ti_fft_diff_conj_1    : mem_manager_address  := M10;
    signal  ti_fft_diff_conj_2    : mem_manager_address  := M11;
    signal  ti_fft_diff_conj_3    : mem_manager_address  := M12;        
    
    
    
    signal  S_B_1                 : mem_manager_address  := M9;
    signal  S_B_2                 : mem_manager_address  := M0;    
    signal  S_B_3                 : mem_manager_address  := M8;    
    
    
    signal  SUM_S_B               : mem_manager_address  := M10;   
    signal  MEAN_S_B              : mem_manager_address  := M10;    
    signal  BETA_X_MEAN_FFT       : mem_manager_address  := M11;      
    
    
    signal  Y_1                   : mem_manager_address  := M12;
    signal  Y_2                   : mem_manager_address  := M9;    
    signal  Y_3                   : mem_manager_address  := M0;    
    
    
        
    signal  TP_Y_1                : mem_manager_address  := M11;
    signal  TP_Y_2                : mem_manager_address  := M8;    
    signal  TP_Y_3                : mem_manager_address  := M4;    
    
    signal  Y                     : mem_manager_address  := M13;   
    signal  Y_Transpose           : mem_manager_address  := M14;      
    signal  Y_X_Y                 : mem_manager_address   := M12;
     
    signal  eig_inp_a             : mem_manager_address   := M12;
    
    signal  R_a                   : mem_manager_address   := M12;
    
    
    signal  Q_a                   : mem_manager_address   := M9;
   
    
    
    signal  CPY_Q_a               : mem_manager_address   := M2;
    signal  eig_inp_a_cpy         : mem_manager_address   := M5;    
    
    signal  ID_a                  : mem_manager_address   := M0; 
    signal  TP_ID_a               : mem_manager_address   := M6;
    
    signal  V                     : mem_manager_address   := M11;
    signal  D                     : mem_manager_address   := M7;    
   ------------------------------------------------------------------------------------------ 
    signal  Y_X_V                 : mem_manager_address   := M14;    
    signal  D_Pow                 : mem_manager_address   := M6;    
    
    signal  Phi                   : mem_manager_address   := M15; 
    
  
    
    signal  TP_S_B_MEAN           : mem_manager_address   := M8;    
    
    signal  S_B_REPMAT            : mem_manager_address   := M16;

    signal  S_inv_Phi             : mem_manager_address   := M17;    
    
    
    signal  TP_Phi                : mem_manager_address   := M19; 
    
    signal  D_X_PHI_TP            : mem_manager_address   := M18; --TP_Phi
    
    signal  Eigen_B               : mem_manager_address   := M12; 
    
    signal  CPY_V                 : mem_manager_address   := M4; 
    
    signal  TP_V                 : mem_manager_address   := M4; 
    
    
    signal  FILTER                 : mem_manager_address   := M4; 
    
    
    

    
        

    
    
    
    
    


--- Single memory Locations


    signal  BETA                 : mem_manager_address      := R0;       
    signal  Minus_One            : mem_manager_address      := R1;    
    signal  NEG_BETA             : mem_manager_address      := R2;      
    signal  ONE_minus_BETA       : mem_manager_address      := R3;          
    signal  I_M1                 : mem_manager_address      := R9; 
    signal  MINUS_1BY2           : mem_manager_address      := R18; 


    signal  K                   : mem_manager_address      := R3;   
    signal  K_End               : mem_manager_address      := R6;
    
    signal  I                   : mem_manager_address      := R4;  
    signal  I_END               : mem_manager_address      := R8;     
    
    signal  J                   : mem_manager_address      := R5;      
    signal  J_End               : mem_manager_address      := R7;  
 
 
    signal  VAL_1               : mem_manager_address      := R10;  
    signal  VAL_2               : mem_manager_address      := R11;  
    
    
    signal  C               : mem_manager_address          := R12;  
    signal  S               : mem_manager_address          := R13;          
    
    signal  ADB               : mem_manager_address        := R14; 
    signal  ADBSQ             : mem_manager_address        := R19;     
    signal  ADBP1             : mem_manager_address        := R15; 
    signal  SQRT_ADBP1        : mem_manager_address        := R15; 
    signal  One_v             : mem_manager_address        := R16;  
    
    signal  Neg_S             : mem_manager_address        := R17; 
    signal  C_Zero            : mem_manager_address        := R20;     
    
    signal  FLAG_J            : mem_manager_address        := R21;     
    
 
 ---- Jump Tag Values
 
     signal  K_START            : mem_manager_address      := R67;  ---Means Line 59 
     signal  K_LAND             : mem_manager_address      := R66;     



     signal  J_START            : mem_manager_address      := R72;  ---Means Line 63 
     signal  J_LAND             : mem_manager_address      := R71;     
 
     signal  I_START            : mem_manager_address      := R76;  ---Means Line 67 
     signal  I_LAND             : mem_manager_address      := R75;     
     
     
     signal  B0                 : mem_manager_address      := R87;      
     signal  AGB                : mem_manager_address      := R90;          
     signal  ALB                : mem_manager_address      := R98;          
 
     signal  Normal_a           : mem_manager_address      := R106; 
     
     
     signal  reuse              : mem_manager_address      := R61; 
     
     
     signal  Normal_b           : mem_manager_address      := R155;  
     
     
 
 
-- Others 
        --- Total rows and cols of image input -- thgese are Values 
    signal  TR                   : mem_manager_address      := R3;   
    signal  TC                   : mem_manager_address      := R3;  
    
    
    signal  RC                   : mem_manager_address      := R9;    ---TR*TC
    signal  NT                   : mem_manager_address      := R3;    ---Number Training Images
       
 
end package emach;



