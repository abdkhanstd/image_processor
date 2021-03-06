library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use work.fixed_alg_pkg.all;
use ieee.std_logic_unsigned.all;
use work.definitions.all;
use work.emach.all;


--remove these
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_textio.all;
use std.textio.all; -- remove
use ieee.std_logic_arith.all;


entity imem is
port ( 
	         
	         pcin                                                     :in  imem_address;
	         imem_opcode                                              :out imem_opcode;
	         imem_matrix_loc_a,imem_matrix_loc_b,imem_matrix_loc_c    :out imem_matrix_address;
	         imem_jump_addrsss                                        :out counter_imem_address;
	         forced_mem_address_w                                     :out memory_address;
	         forced_mem_address_r_b                                   :out memory_address;	         
	         forced_mem_address_r_c                                   :out memory_address;	         	         
	         forced_mem_value                                         :out mem_cell;	         
 	         forced_mem_value_fp                                      :out mem_cell;
 	         
 	         
 	         
           imem_mem_manager_write_loc                               :out mem_manager_address;
           imem_mem_manager_write_TR                                :out mem_manager_total_rows;           
           imem_mem_manager_write_TC                                :out mem_manager_total_cols;
           
           imem_mat_name                                            :out mem_manager_address; 
           imem_row_out                                             :out counter_address;
           imem_col_out                                             :out counter_address

);
end imem;

architecture arcimem of imem is
signal imem_array :imem_array;
signal imem_row   :imem_row;
signal tmp:data;
signal tmp2:fpoint;

begin

 

-- FSM For Calculating FFT  of given Training Images

 ---- Change all IMATs Accordingly
 
--- Taking FFT OF Training Images



  ---------------------------------------------------------------------
-------------------------------------------------------------------------------------------
--                          OPCODE  DESTINATION   TARGET  SOURCE 



--- Please refer to Developed Algorithm tfor Optimal Memory Usage


--> STEP 1 :         Taking FFT of Training Images 

--------------------------Initializing New Matrices to store FFT first Then Writing Back FFT on Training Image Locations

--TAG START:




-- TAG Takin FFTS 
          -- Initializing Matrices    
          imem_array(0)       <=      IMAT          & fft_ti_1         & TR            & TC;             
          imem_array(1)       <=      IMAT          & fft_ti_2         & TR            & TC;          
          imem_array(2)       <=      IMAT          & fft_ti_3         & TR            & TC; 
          
          -- Now taking FFT-1 
          imem_array(3)       <=      FFTm          & fft_ti_1         & ti_1          & ti_1;          -- Source is DUMMY
          imem_array(4)       <=      FFTm          & fft_ti_2         & ti_2          & ti_2;          -- Source is DUMMY
          imem_array(5)       <=      FFTm          & fft_ti_3         & ti_3          & ti_3;          -- Source is DUMMY                   
          
          imem_array(6)       <=      FFTmm         & fft2_ti_1        & fft_ti_1      & fft_ti_1;      -- Source is DUMMY
          imem_array(7)       <=      FFTmm         & fft2_ti_2        & fft_ti_2      & fft_ti_2;      -- Source is DUMMY
          imem_array(8)       <=      FFTmm         & fft2_ti_3        & fft_ti_3      & fft_ti_3;      -- Source is DUMMY 
          


--> STEP 2 :         Taking Mean of the FFTs of the Trainig Images 

-- TAG MEAN _FFT
		
		    -- REUSING  LOCATIONS ASSIGNED IN FFTm 
		    
          imem_array(9)       <=      ADDm          & SUM_FFT         & fft2_ti_1      & fft2_ti_2; 
          imem_array(10)      <=      ADDm          & SUM_FFT         & SUM_FFT        & fft2_ti_3;           
          imem_array(11)      <=      DIVmi         & MEAN_FFT        & SUM_FFT        & RF3;              --SUM_FFT/3  (3) In Floating Point ;                   
          


--> STEP 2 :  Calculating ti_FFT_diff


--TAG Producing (1-Beta)

          imem_array(12)      <=      LODn          & Minus_One         & RFN1                  & RFN1;   --Loading -1 
          imem_array(13)      <=      LOD           & BETA              & RF2                   & RF2;           
          imem_array(14)      <=      MUL           & NEG_BETA          & Minus_One             & BETA;          
          imem_array(15)      <=      ADDi          & ONE_minus_BETA    & NEG_BETA              & RF1;                    
          

--TAG ((1-beta)*MEAN_FFT
          
          imem_array(16)      <=      MULmv         & MEAN_FFT_Ti_diff  & MEAN_FFT              & ONE_minus_BETA;
          
-- TAG (ti_fft_diff_x- MEAN_FFT_Ti_diff) ------ ti_fft_diff_x- MEAN_FFT_Ti_diff 

          imem_array(17)      <=      SUBm          & ti_fft_diff_1        & fft2_ti_1              & MEAN_FFT_Ti_diff;          
          imem_array(18)      <=      SUBm          & ti_fft_diff_2        & fft2_ti_2              & MEAN_FFT_Ti_diff;          
          imem_array(19)      <=      SUBm          & ti_fft_diff_3        & fft2_ti_3              & MEAN_FFT_Ti_diff;          
          
          
          ---- ti_diff Exactly Matches With MATLAB RESULTS Up Till here 
-- TAG Initializing Matrices to Hold Conjugate  CONJ(ti_fft_diff_x)
          
          imem_array(20)      <=      IMAT          & ti_fft_diff_conj_1   & TR                     & TC; 
          imem_array(21)      <=      IMAT          & ti_fft_diff_conj_2   & TR                     & TC;
          imem_array(22)      <=      IMAT          & ti_fft_diff_conj_3   & TR                     & TC;
          
          

-- TAG Setting CONJ FLAG
          imem_array(23)      <=      CPYm          & ti_fft_diff_conj_1   & ti_fft_diff_1          & ti_fft_diff_1; 
          imem_array(24)      <=      CPYm          & ti_fft_diff_conj_2   & ti_fft_diff_2          & ti_fft_diff_2;
          imem_array(25)      <=      CPYm          & ti_fft_diff_conj_3   & ti_fft_diff_3          & ti_fft_diff_3; 

          imem_array(26)      <=      SCONJ         & ti_fft_diff_conj_1  & ti_fft_diff_conj_1      & ti_fft_diff_conj_1; 
          imem_array(27)      <=      SCONJ         & ti_fft_diff_conj_2  & ti_fft_diff_conj_2      & ti_fft_diff_conj_2;
          imem_array(28)      <=      SCONJ         & ti_fft_diff_conj_3  & ti_fft_diff_conj_3      & ti_fft_diff_conj_3;  
          
          
          
          
          
-- TAG Calculating S_B_1,S_B_2,S_B_3                   
          
          imem_array(29)      <=      MULmd         & S_B_1              & ti_fft_diff_1            & ti_fft_diff_conj_1;                      
          imem_array(30)      <=      MULmd         & S_B_2              & ti_fft_diff_2            & ti_fft_diff_conj_2;          
          imem_array(31)      <=      MULmd         & S_B_3              & ti_fft_diff_3            & ti_fft_diff_conj_3;
          
-- TAG Resetting CONJ  S_B_1,S_B_2,S_B_3           
          imem_array(32)      <=      RCONJ         & ti_fft_diff_conj_1 & ti_fft_diff_conj_1       & ti_fft_diff_conj_1; 
          imem_array(33)      <=      RCONJ         & ti_fft_diff_conj_2 & ti_fft_diff_conj_2       & ti_fft_diff_conj_2;
          imem_array(34)      <=      RCONJ         & ti_fft_diff_conj_3 & ti_fft_diff_conj_3       & ti_fft_diff_conj_3;           

          ---- S_B_X Exactly Matches With MATLAB RESULTS Up Till here 
--TAG Mean S_B
    	 
          imem_array(35)      <=      ADDm         & SUM_S_B             & S_B_1                    & S_B_2;    	             
          imem_array(36)      <=      ADDm         & SUM_S_B             & SUM_S_B                  & S_B_3;    	                       
          imem_array(37)      <=      DIVmi        & MEAN_S_B            & SUM_S_B                  & RF3;           

           -- Exact Match With MATLAB 



--> STEP 3 : ti_FFTs - (BETA *MEAN_FFTs)
         
--TAG Producing Beta * M         
          imem_array(38)      <=      MULmv        & BETA_X_MEAN_FFT     & MEAN_FFT                 & BETA;
          imem_array(39)      <=      SUBm         & Y_1                 & fft2_ti_1                & BETA_X_MEAN_FFT;
          imem_array(40)      <=      SUBm         & Y_2                 & fft2_ti_2                & BETA_X_MEAN_FFT;                               
          imem_array(41)      <=      SUBm         & Y_3                 & fft2_ti_3                & BETA_X_MEAN_FFT;          
          
--> STEP 4 :  Y'*Y

--TAG Putting ALL Matrices in One Matrix after Resaping 
          imem_array(42)      <=      TP          & TP_Y_1               & Y_1                       & Y_1;
          imem_array(43)      <=      TP          & TP_Y_2               & Y_2                       & Y_2;
          imem_array(44)      <=      TP          & TP_Y_3               & Y_3                       & Y_3;                    

          imem_array(45)      <=      RSHP        & TP_Y_1               & RC                        & R1;
          imem_array(46)      <=      RSHP        & TP_Y_2               & RC                        & R1;
          imem_array(47)      <=      RSHP        & TP_Y_3               & RC                        & R1;      
          
  -- IMAT Y 9,3        
          imem_array(48)      <=      IMAT        & Y_Transpose          & NT                        & RC;  
          imem_array(49)      <=      IMAT        & Y                    & RC                        & NT;            
          
          imem_array(50)      <=      CPYC        & Y                    & TP_Y_1                    & R1;  --First col 
          imem_array(51)      <=      CPYC        & Y                    & TP_Y_2                    & R2;  --Second Col
          imem_array(52)      <=      CPYC        & Y                    & TP_Y_3                    & R3;  -- Third Col                    
          
          imem_array(53)      <=      TP          & Y_Transpose          & Y                         & Y;
          imem_array(54)      <=      SCONJ       & Y_Transpose          & Y_Transpose               & Y_Transpose;  -- Conjugating Like MATLAB        
          imem_array(55)      <=      MULm        & Y_X_Y                & Y_Transpose               & Y;
          imem_array(56)      <=      CREAL       & Y_X_Y                & Y_X_Y                     & Y_X_Y; -- REAL(Y_X_Y)   ------ REPLACE Target WITH  Y_X_Y If needed
          imem_array(57)      <=      RCONJ       & Y_Transpose          & Y_Transpose               & Y_Transpose;    -- Unconjugating so can be used Further
          
          

          imem_array(58)      <=     RSHP          &  TP_Y_1             &  TR                     &   TC; 
          imem_array(59)      <=     RSHP          &  TP_Y_2             &  TR                     &   TC;      
          imem_array(60)      <=     RSHP          &  TP_Y_3             &  TR                     &   TC;    
          
--Tag Reuse:                      
          imem_array(61)      <=     CPYm          & V                   & IDM                       & IDM;
                                                                                                            -- <--- Jump here 
              
                   
--> STEP 5 Eigen Decomposition :


--- TAG  Eigen Iteration Loop



          imem_array(62)       <=      LOD          & C_Zero              & C_Zero                 & RF0;   -- Loading for comparison ==0 
---Loop Info K


          imem_array(63)      <=      LOD        & K                     & R1                      & R1;   -- K=1:K_End 
          imem_array(64)      <=      LOD        & K_End                 & NT                      & NT;   -- K_END= Num Training Images --Its Number of Iterations
          imem_array(65)      <=      JMP        & K                     & K                       & K_START;                     
          
          
-- TAG  K_Land :

          imem_array(66)      <=      ADDi       & K                     & K                      & R1;      -- K=K+1 

-- TAG  K_START:
    
         
                              
          
  ---Loop Info J        
           imem_array(67)      <=      CPYm      & Q_a                   & IDM                       & IDM;                      
           imem_array(68)      <=      LOD       & J                     & R1                      & R1;  
           imem_array(69)      <=      LOD       & J_End                 & TR                      & TR;             
           imem_array(70)      <=      JMP       & TC                    & TC                      & J_START;  
           
 -- TAG  J_Land :  
           
           imem_array(71)      <=      ADDi       & J                     & J                      & R1;     -- J=J+1;
           
-- TAG J_START :


-- TAG I_INFO :

          imem_array(72)      <=      LOD        & I                     & TR                      & TR;   -- I= Total Rows 
          imem_array(73)      <=      ADDi       & I_End                 & J                       & R1;   -- I_END= J+1
          imem_array(74)      <=      JMP        & K                     & K                       & I_START;                     
          

 -- TAG  I_Land :           
          
          imem_array(75)      <=     SUBi        & I                     & I                      & R1; -- I=I-1;          
           
               
-- TAG I_Start:
          -- Creating Eigen 
          imem_array(76)      <=     CPYm        & ID_a                  & IDM                    & IDM; -- ID_a=eye(Tr,Tc)
          imem_array(77)      <=     SUBi        & I_M1                  & I                      & R1;  -- I-1  --- in decimal
                    
          
          
          imem_array(78)     <=      LRC         &  eig_inp_a            &  I_M1                  &   J;  -- R(i-1,j)
          imem_array(79)     <=      WTSR        &  eig_inp_a            &  I_M1                  &   J;  
          imem_array(80)     <=      SFSR        &  VAL_1                &  VAL_1                 &   VAL_1;  --- a=R7 <--- A
          
          
          
          imem_array(81)     <=      LRC         &  eig_inp_a            &  I                     &   J;  -- R(i-1,j)
          imem_array(82)     <=      WTSR        &  eig_inp_a            &  I                     &   J;  
          imem_array(83)     <=      SFSR        &  VAL_2                &  VAL_2                 &   VAL_1;  --- a=R7 <--- B
          
                                 --   R(i-1,j),R(i,j)
                                 
                                 
          imem_array(84)     <=      JEQ         &  VAL_2                &  C_Zero                &  B0;  --Case B=0;  
          imem_array(85)     <=      JGABS       &  VAL_2                &  VAL_1                 &  AGB;  --Case abs(a)>abs(b); 
          imem_array(86)     <=      JMP         &  VAL_2                &  VAL_1                 &  ALB;  --Case a<b; 
          
          
--TAG B=0


         imem_array(87)      <=     LOD          &  C                   &  RF1                   &   RF1; ---c=1  ---in Fixed Point
         imem_array(88)      <=     LOD          &  S                   &  RF0                   &   RF0; ---s=0
         imem_array(89)      <=     JMP          &  R55                 &  R55                   &   Normal_a;-- 40 ---Normal: --JMP

-- TAG AGB VAL 2>VAL 1

         imem_array(90)      <=     DIV          &  ADB                 &  VAL_1                 &   VAL_2; ---in Fixed Point
         imem_array(91)      <=     MUL          &  ADBSQ               &  ADB                   &   ADB; --R^2 ADB^2
         imem_array(92)      <=     ADDi         &  ADBP1               &  ADBSQ                 &   RF1; --1+R^2
         imem_array(93)      <=     POWi         &  SQRT_ADBP1          &  ADBP1                 &   RFD5; --- Sqrt (1+R^2)
         imem_array(94)      <=     LOD          &  One_v               &  RF1                   &   RF1;
         imem_array(95)      <=     DIV          &  S                   &  One_v                 &   SQRT_ADBP1;   --- S
         imem_array(96)      <=     MUL          &  C                   &  S                     &   ADB;   --- C
         imem_array(97)      <=     JMP          &  R55                 &  R55                   &   Normal_a; --46 ---Normal: --JMP
 
 



-- TAG ALB
         imem_array(98)      <=     DIV          &  ADB                &  VAL_2                  &   VAL_1; ---in Fixed Point
         imem_array(99)      <=     MUL          &  ADBSQ              &  ADB                    &   ADB; ---R^2
         imem_array(100)     <=     ADDi         &  ADBP1              &  ADBSQ                  &   RF1;   --R14= 1+r^2
         imem_array(101)      <=    POWi         &  SQRT_ADBP1         &  ADBP1                  &   RFD5; --0.5 --- Sqrt (1+R^2)
         imem_array(102)      <=    LOD          &  One_v              &  RF1                    &   RF1;
         imem_array(103)      <=    DIV          &  C                  &  One_v                  &   SQRT_ADBP1;   --- C
         imem_array(104)     <=     MUL          &  S                  &  C                      &   ADB;   --- S
         imem_array(105)     <=     JMP          &  R55                &  R55                    &   Normal_a;  --46 ---Normal: --JMP
          
-- TAG Normal_a           

        imem_array(106)      <=     LSR          &  C                  &  C                      &   C; 
        imem_array(107)      <=     WFSR         &  ID_a               &  I_M1                   &   I_M1;   --M14(i-1,i-1)=c

       
        imem_array(108)      <=     LODn         &  Minus_One          &  RFN1                    &   RFN1 ; 
        imem_array(109)      <=     MUL          &  Neg_S              &  Minus_One               &   S   ;   -- -S
        imem_array(110)      <=     LSR          &  Neg_S              &  Neg_S                   &   Neg_S; 
        imem_array(111)      <=     WFSR         &  ID_a               &  I_M1                    &   I;  --M14(i-1,i)=-s


        imem_array(112)      <=     LSR          &  S                  &  S                       &   S; 
        imem_array(113)      <=     WFSR         &  ID_a               &  I                       &   I_M1;   --M14(i,i-1)=S

        imem_array(114)      <=     LSR          &  C                  &  C                       &   C; 
        imem_array(115)      <=     WFSR         &  ID_a               &  I                       &   I;   --M14(i,i)=c
    
       -----------------
    
        imem_array(116)      <=     TP           &  TP_ID_a            &  ID_a                     &   ID_a;  -- No Conjugation as valus must be real
        imem_array(117)      <=     CPYm         &  eig_inp_a_cpy      &  eig_inp_a                &   eig_inp_a;         
        imem_array(118)      <=     MULm         &  eig_inp_a          &  TP_ID_a                  &   eig_inp_a_cpy;   ---R_a

        imem_array(119)      <=     CPYm         &  CPY_Q_a            &  Q_a                     &   Q_a;   
        imem_array(120)      <=     MULm         &  Q_a                &  CPY_Q_a                 &   ID_a;     --Q_a



        imem_array(121)      <=     JLT          &  I_END              &  I                       &   I_LAND;   ---- I < J+1
        imem_array(122)      <=     JNE          &  I                  &  J_END                   &   J_LAND;         
        
        
        
        
       
       
       -- Q_a , R_a
       
       imem_array(123)      <=     CPYm          &  CPY_V              &  V                       &   V;     -- V is already Eye
       imem_array(124)      <=     MULm          &  V                  &  CPY_V                   &   Q_a; 
       imem_array(125)      <=     MULm          &  D                  &  R_a                     &   Q_a; --AA 
       imem_array(126)      <=     CPYm          &  eig_inp_a          &  D                       &   D;        
       imem_array(127)      <=     JNE           &  K                  &  K_END                   &   K_LAND;                
       

       imem_array(128)      <=     MULmd         &  D                  &  IDM                     &   D;        
       
       imem_array(129)      <=     JEQ           &  FLAG_j             &  One_v                   &   Normal_b;

       
-- Reshaping Left Eleements       

       imem_array(130)      <=     LOD           &  FLAG_j             &  RF1                    &   RF1; 
   
       
       ---- Checked Till Here on Matlab Real Parts Match , On Matlab QR wasn Working , Produces NAN 
       
  

       imem_array(131)      <=     RSHP          &  Y_X_V              &  RC                     &   NT;  -- OK
       imem_array(132)      <=     MULm          &  Y_X_V              &  Y                      &   V;   -- OK
       imem_array(133)      <=     LODn          &  MINUS_1BY2         &  MINUS_1BY2             &   RFND5; -- OK
       imem_array(134)      <=     POWmv         &  D_Pow              &  D                      &   MINUS_1BY2; --OK  --Refer to Mpower , In this cas 0/X is converted to zero as main diagonal is non zero only , other wise use Mpower
       imem_array(135)      <=     IMAT          &  Phi                &  RC                     &   NT;       -- OK 
       imem_array(136)      <=     MULm          &  Phi                &  Y_X_V                  &   D_Pow;    --OK
       
      
       
       imem_array(137)      <=     TP            &  TP_S_B_MEAN        &  MEAN_S_B               &   MEAN_S_B;      -- This is adjustment TP
       imem_array(138)      <=     CREAL         &  TP_S_B_MEAN        &  TP_S_B_MEAN            &   TP_S_B_MEAN;       
       imem_array(139)      <=     RSHP          &  TP_S_B_MEAN        &  RC                     &   R1;   ---  RC,1   
       
--TAG REPMAT S_B

       imem_array(140)      <=     IMAT          &  S_B_REPMAT         &  RC                     &   NT; 
       imem_array(141)      <=     CPYC          &  S_B_REPMAT         &  TP_S_B_MEAN            &   R1;        
       imem_array(142)      <=     CPYC          &  S_B_REPMAT         &  TP_S_B_MEAN            &   R2;        
       imem_array(143)      <=     CPYC          &  S_B_REPMAT         &  TP_S_B_MEAN            &   R3; 
       
       imem_array(144)      <=     IMAT          &  S_inv_Phi          &  RC                     &   NT;        
       imem_array(145)      <=     IMAT          &  TP_Phi             &  NT                     &   RC;   -- <-------------       
       imem_array(146)      <=     DIVm          &  S_inv_Phi          &  Phi                    &   S_B_REPMAT;  
       

 -- Values Matching With Maltlab Uptill here, Check for Iteration of Eigen no 2
       imem_array(147)      <=     TP            &  TP_Phi             &  Phi                   &   Phi;     
       imem_array(148)      <=     SCONJ         &  TP_Phi             &  TP_Phi                &   TP_Phi;  -- Setting Conj
       
      
       
       imem_array(149)      <=     IMAT          &  D_X_PHI_TP         &  NT                    &   RC;
       imem_array(150)      <=     MULm          &  D_X_PHI_TP         &  D                     &   TP_Phi;
       imem_array(151)      <=     RCONJ         &  TP_Phi             &  TP_Phi                &   TP_Phi;  -- Resetting Conj         
       imem_array(152)      <=     MULm          &  Eigen_B            &  D_X_PHI_TP            &   S_inv_Phi;              
       imem_array(153)      <=     CREAL         &  Eigen_B            &  Eigen_B               &   Eigen_B;   ----eig_inp_a    
       imem_array(154)      <=     JMP           &  TP_Phi             &  TP_Phi                &   reuse;   --        
       
--Normat _b

       imem_array(155)      <=     TP            &  TP_V               &  V                      &   V;   --         Playing with Orientation 
       imem_array(156)      <=     RSHP          &  TP_V               &  NT                     &   R1;   --         Maskig as NT,1        
       
       
       imem_array(157)      <=     RSHP          &  FILTER             &  RC                     &   R1;  
       imem_array(158)      <=     MULm          &  FILTER             &  S_inv_Phi              &   TP_V;   --         Maskig as NT,1 
       
       imem_array(159)      <=     STOP;
       
       
       
       
       
       
                            
       
      


















          
-------------------------------------------------------------------------------------		

      imem_row <= 	imem_array(conv_integer(pcin));
    
      -- Now Breaking up the row in to addresses 
      imem_opcode           <=   imem_row(imem_inst_size-1 downto imem_inst_size-opcode_bits );
      imem_matrix_loc_a     <=   imem_row(imem_inst_size-opcode_bits-1 downto imem_inst_size-opcode_bits-matrix_address_bits);      
      imem_matrix_loc_b     <=   "00000000000000" when imem_row(imem_inst_size-1 downto imem_inst_size-opcode_bits ) = FFTm else
                                  imem_row(imem_inst_size-opcode_bits-matrix_address_bits-1 downto imem_inst_size-opcode_bits-(2*matrix_address_bits));      
      imem_matrix_loc_c     <=   imem_row(imem_inst_size-opcode_bits-matrix_address_bits-1 downto imem_inst_size-opcode_bits-(2*matrix_address_bits)) when imem_row(imem_inst_size-1 downto imem_inst_size-opcode_bits ) = FFTm else
                                  "00000000000000" when imem_row(imem_inst_size-1 downto imem_inst_size-opcode_bits ) = FFTmm else
                                  imem_row(imem_inst_size-opcode_bits-(2*matrix_address_bits)-1 downto 0);        
  
      
      imem_jump_addrsss     <=   imem_row(imem_address_size-1 downto 0);  -- These are the end most values on right side 

      forced_mem_address_w       <="0000000000" & imem_row(imem_inst_size-opcode_bits-1 downto imem_inst_size-opcode_bits-matrix_address_bits);   --a   
      forced_mem_address_r_c     <="0000000000" & imem_row(imem_inst_size-opcode_bits-(2*matrix_address_bits)-1 downto 0);                        --c                            
      forced_mem_address_r_b     <="0000000000" & imem_row(imem_inst_size-opcode_bits-matrix_address_bits-1 downto imem_inst_size-opcode_bits-(2*matrix_address_bits)); --b


      forced_mem_value_fp.r    <= universal_high_std(ip-fp downto bits_mem_manager_address) & imem_row(imem_inst_size-opcode_bits-(2*matrix_address_bits)-1 downto 0) when imem_row(imem_inst_size-1 downto imem_inst_size-opcode_bits )=LODn else
                                  universal_zero_std(ip-fp downto bits_mem_manager_address) & imem_row(imem_inst_size-opcode_bits-(2*matrix_address_bits)-1 downto 0);
                              
                              
                              
      forced_mem_value_fp.c    <= universal_zero_std(ip-fp downto 0);
      
      forced_mem_value.r     <= universal_high_std(ip-fp downto bits_mem_manager_address) & imem_row(imem_inst_size-opcode_bits-(2*matrix_address_bits)-1 downto 0) when imem_row(imem_inst_size-1 downto imem_inst_size-opcode_bits )=LODn else
                                universal_zero_std(ip-fp downto bits_mem_manager_address) & imem_row(imem_inst_size-opcode_bits-(2*matrix_address_bits)-1 downto 0);
                              
      forced_mem_value.c     <= universal_zero_std(ip-fp downto 0);
      imem_jump_addrsss      <= imem_row(imem_address_size-1 downto 0);
      
      
      
     -----
      imem_mem_manager_write_loc <= imem_row(imem_inst_size-opcode_bits-1 downto imem_inst_size-opcode_bits-matrix_address_bits);
      imem_mem_manager_write_TR  <= imem_row(imem_inst_size-opcode_bits-matrix_address_bits-1-2 downto imem_inst_size-opcode_bits-(2*matrix_address_bits)); 
      imem_mem_manager_write_TC  <= imem_row(imem_inst_size-opcode_bits-(2*matrix_address_bits)-1-2 downto 0);        
      
      ----
      
            

end arcimem;
	
	


                   



