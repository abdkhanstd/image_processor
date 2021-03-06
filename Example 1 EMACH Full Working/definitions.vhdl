library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--force clk 0 30,1 30, 0 30 -repeat 30

package definitions is

  ------------------------------------ CONSTANTS -------------------------------------------
  
  -- 
  -- This defines the length of integer  part and fractional part size (Total control of Model)

  constant ip:integer  :=24;       --integer  Part length
  constant fp:integer  :=-12;      --Fractional  Part length
  ---When Increase FP to higher limit , also increase size of MEM LOC in instruction to avoid lesse vals
  constant max_size_image_support:integer :=64; ----Its N X N
  constant mem_size:integer :=10;
  constant max_image_size:integer  :=64;      -- (NXN) Max size of image that this processor will handle
  constant main_memory_height:integer  :=max_size_image_support*max_size_image_support*mem_size; 
  
  

  
  
    
  ------------------------------------ Data Types --------------------------------------------
  
  -- Defining the subtype fixed point for my Architecture
  subtype fpoint    is sfixed(ip downto fp);            
  subtype rfpoint   is sfixed(ip+1 downto fp);            --storage location for Addition Subtraction of fpoint
  subtype rmfpoint  is sfixed((ip*2)+1 downto 2*fp);      --storage location for multplication of fpoint
  subtype rmdata    is std_logic_vector((2*(ip-fp))+1 downto 0);      --storage location for multplication of fpoint  
  subtype rdfpoint  is sfixed(ip-fp+1 downto fp-ip);      --storage location for Division of fpoint
  subtype data      is std_logic_vector(ip-fp downto 0);  --Its basically a memory location of bits specified (ipbits - (-FP bits))
  subtype flag      is std_logic;                         --Flag is just a one bit value 
  
  
   -- The Value that will be stored for addresses ets thats basically std_logic_vector
  
  

  
  
  
  -------------------------------------MISC Values----------------------------------------------
  
  
   
   constant unknownuniversal    :sfixed(33 downto -16) :="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"; --32 Bit Universal Unknown
   constant universal_zero_std  :std_logic_vector (40 downto 0)    :="00000000000000000000000000000000000000000";
   constant universal_high_std  :std_logic_vector(40 downto 0)            :="11111111111111111111111111111111111111111";
   constant unknown             :rfpoint :=unknownuniversal(ip+1 downto fp); --ip+fp Bit  Unknown
   

   
   constant universal_zero   :sfixed(33 downto -16)    :="00000000000000000000000000000000000000000000000000";

   constant universal_high   :sfixed(33 downto -16)    :="11111111111111111111111111111111111111111111111111";
   
   constant one_fp           :fpoint                  :=universal_zero(ip downto 1)&'1' & universal_zero(-1 downto fp);
   constant minus_one_fp     :fpoint                  :=universal_high(ip downto 0) & universal_zero(-1 downto fp);
   constant zero_fp          :fpoint                  :=universal_zero(ip downto 0) & universal_zero(-1 downto fp);
   constant one              :data                    :=universal_zero_std(ip-fp downto 1) &'1';
   constant zero_std         :data                    :=universal_zero_std(ip-fp downto 0);

  
  
   constant Thold            :data                    :=universal_zero_std(ip-fp downto 1) & '1'               ;          --0.002 else wise that will be == 0
  
-------------------------------------ALU Definitions-----------------------------------------
  subtype command_alu is std_logic_vector(4 downto 0);
    

    --Arithmetic Operations Opcode for Fixed Points
    
    signal alu_add_fp     : command_alu     :="00000";       --Add fixed Point Values
    signal alu_sub_fp     : command_alu     :="00001";       --Sub fixed Point Values
    signal alu_mul_fp     : command_alu     :="00010";       --Multiply  fixed Point Values
    signal alu_div_fp     : command_alu     :="00011";       --Divide fixed Point Values
    signal alu_sqrt_fp    : command_alu     :="00100";       --Square root of (a) fixed Point Values
    signal alu_pow_fp     : command_alu     :="00101";       --Power a^b of fixed Point Values 
    
    
    
    -- Logic Operations Opcode  for Fixed Points
    
    signal alu_eq_fp      : command_alu     :="00110";       --Check Equality of fixed Point Values
    signal alu_neq_fp     : command_alu     :="00111";       --Check InEquality of fixed Point Values
    signal alu_lt_fp      : command_alu     :="01000";       --Less than (a<b)for fixed Point Values
    signal alu_gt_fp      : command_alu     :="01001";       --Greater than (a>b) fixed Point Values
    signal alu_lteq_fp    : command_alu     :="01010";       --Less than or equal to (a<=b) fixed Point Values
    signal alu_gteq_fp    : command_alu     :="01011";        --Greater than or equal to (a>=b) fixed Point Values
    
    --Arithmetic Operations Opcode (useful for jumps etc)
    signal alu_add        : command_alu     :="01100";       --Add  
    signal alu_sub        : command_alu     :="01101";       --Sub   
    signal alu_mul        : command_alu     :="01110";       --Multiply    
    signal alu_div        : command_alu     :="01111";       --Divide   
    signal alu_pow        : command_alu     :="10000";       --Power a^b     
    
    signal alu_eq         : command_alu     :="10001";       --Check Equality    
    signal alu_neq        : command_alu     :="10010";       --Check InEquality    
    signal alu_lt         : command_alu     :="10011";       --Less than (a<b)   
    signal alu_gt         : command_alu     :="10100";       --Greater than (a>b)   
    signal alu_lteq       : command_alu     :="10101";       --Less than or equal to (a<=b)   
    signal alu_gteq       : command_alu     :="10110";        --Greater than or equal to (a>=b)
    signal alu_jmp        : command_alu     :="10111";      
    signal alu_real       : command_alu     :="11000"; 
    
    
    signal alu_null       : command_alu     :="11111";        --Greater than or equal to (a>=b)
    signal alu_JGT_ABS    : command_alu     :="11100";    

    
    -------------------------------------- Control OPCODE --------------------------------------------
  
    subtype opcode is std_logic_vector(4 downto 0);
    
   
    
    ------------------------------------- MEMORY Definitions -----------------------------------------
    
    constant memory_address_bits:integer  :=24;
    type mem_cell is
        record
                r: data;        -- Real part
                c: data;        -- Imaginary part
        end record;
        
    type memory_array is  array (0 to main_memory_height ) of mem_cell;
    subtype memory_address is std_logic_vector(memory_address_bits-1 downto 0);
    
    
    
    
    -------------------------------------- MEMORY MANAGER ------------------------------------------
  --constant bits_size_matrix         :integer  :=9;    -- Not Needed
    constant bits_size_total_rows     :integer  :=12;    --Number of bits for size
    constant bits_size_total_cols     :integer  :=12;    
    constant bits_size_total_base     :integer  :=memory_address_bits;        
    constant bits_size_total_next     :integer  :=memory_address_bits;        
    constant bits_total               :integer  := bits_size_total_rows+bits_size_total_cols+ bits_size_total_base;             
    constant mem_manager_height       :integer  :=100; 
    constant bits_mem_manager_address :integer  :=14;    --Cahnge MEMORY NAMES if editted in IMEM Section   
    constant mem_manager_next         :integer  :=bits_size_total_base; --Should have same number of bits as next

    
    
    

    subtype mem_manager_row           is  std_logic_vector(bits_total downto 0);
    subtype mem_manager_row_BV        is  bit_vector(bits_total-1 downto 0);
    subtype mem_manager_address       is  std_logic_vector(bits_mem_manager_address-1 downto 0);
    subtype mem_manager_total_rows    is  std_logic_vector(bits_size_total_rows-1 downto 0);
    subtype mem_manager_total_cols    is  std_logic_vector(bits_size_total_cols-1 downto 0);
    subtype mem_manager_base_address  is  std_logic_vector(bits_size_total_base-1 downto 0);
    subtype mem_manager_next_address  is  std_logic_vector(mem_manager_next-1 downto 0);

    type mem_manager_array            is  array (0 to mem_manager_height ) of mem_manager_row;   

   --------------------------------------- IMEM Guide------------------------------------------
   
   constant imem_address_size     :integer  :=10;    --Number of bits for size for PC in
   constant matrix_address_bits   :integer  :=bits_mem_manager_address;
   constant opcode_bits           :integer  :=6;
   constant imem_inst_size        :integer  :=(3*matrix_address_bits)+(opcode_bits);    --Number of bits for size for PC in
   constant imem_height           :integer  :=200;
  


   subtype imem_row             is  std_logic_vector(imem_inst_size-1 downto 0);
   subtype imem_matrix_address  is  std_logic_vector(matrix_address_bits-1 downto 0);
   subtype imem_address         is  std_logic_vector(imem_address_size-1 downto 0);   
   subtype imem_opcode          is  std_logic_vector(opcode_bits-1 downto 0);   
   
   type    imem_array           is  array (0 to imem_height ) of imem_row; 
   constant one_counter         :imem_address       :=universal_zero_std(imem_address_size-1 downto 1) &'1';
  
  
   --------------------------------------Some Defs for Counter ----------------------------
   subtype counter_address                is  std_logic_vector(bits_size_total_rows downto 0);


   --------------------------------------Mux Selection ----------------------------
   subtype sel_3bit                is  std_logic_vector(2 downto 0);
   subtype sel_1bit                is  std_logic;
   subtype sel_2bit                is  std_logic_vector(1 downto 0);  
   
   

  

   --------------------------------------Some Defs for IMEM Counter ----------------------------
   subtype counter_imem_address           is  std_logic_vector(imem_address_size-1 downto 0); 


   --------------------------------------Some Defs for Writing memory with reg value ----------------------------   
   
   
   -----------
   
   --------------------------------------OP CODES AND MEMORY LOCS----------------------------
    
    -- FOR MATRICES/IMAGES
                                                                                                                       -- Status tested /Implimented      
    signal  MULm         : imem_opcode     :="000000";        --MUL MATRICES ,                                 MULm M0,M1,M2   --
    signal  MULmd        : imem_opcode     :="000001";        --MUL MATRICES M0.*M1                            MULm M0,M1,M2   -- 
    signal  MULmi        : imem_opcode     :="000010";        --MUL Matrix with Immidiate ,                    MULmi M0,1,M2   -- 
    signal  MULmv        : imem_opcode     :="000011";        --MUL Matrix with value in some memory loc ,     MULmv M0,R0,M2  --    
    signal  DIVm         : imem_opcode     :="000100";        --DIV Matrix with value in some memory loc ,     DIVm M0,M1,M2   --(M1./M2   )
    signal  DIVmv        : imem_opcode     :="000101";        --DIV Matrix with value in some memory loc ,     DIVmv M0,R0,M2  --   
    signal  DIVmi        : imem_opcode     :="000110";        --DIV Matrix with Immidiate Value ,              DIVmi M0,2,M2   --  
    signal  ADDm         : imem_opcode     :="000111";        --Matrix Addition                                ADDm M0,M1,M2   --
    signal  SUBm         : imem_opcode     :="001000";        --Matrix Subtraction                             SUBm M0,M1,M2   --   
    signal  ADDmv        : imem_opcode     :="001001";        --Matrix Addition with some value in memory      ADDmv M0,R0,M2  --   
    signal  SUBmv        : imem_opcode     :="001010";        --Matrix Subtraction with some value in memory   SUBmv M0,R0,M2  --
    signal  SUBmi        : imem_opcode     :="001011";        --Matrix Subtraction with Immidiate Value        SUBmi M0,M2,2   --            
    signal  ADDmi        : imem_opcode     :="001100";        --Matrix Subtraction with Immidiate Value        ADDmi M0,M2,2   --   
    signal  POWmi        : imem_opcode     :="001101";        --Matrix RAISED TO POWER                         POWmi M0,2      -- 
    signal  POWmv        : imem_opcode     :="001110";        --Matrix RAISED TO POWER                         POWmv M0,R0     -- 
    
    

        
    -- Specialized Functions for Matrices
    signal  TP           : imem_opcode     :="001111";     --   --Matrix Transpose                               TP M0,M2        
    signal  SCONJ        : imem_opcode     :="010000";     --   --Raise a Conjugate Flag for next matrix         CONJ M1,M2     
    signal  RCONJ        : imem_opcode     :="010001";     --   --Resets the CONJ Flag
    signal  FFTm         : imem_opcode     :="010010";     --
    signal  FFTmm        : imem_opcode     :="010011";     --   --Calculate Mean Of Matrix row wise              MEANmr M1,M2                   
    signal  MEANmc       : imem_opcode     :="010100";          --Calculate Mean Of Matrix col wise              MEANmc M1,M2
    signal  SFFTm        : imem_opcode     :="010101";          --FFT Shifts of a  given matrix                  SFFTm M1,M3  


    -- FOR GENERAL Arithmedic
    signal  ADD          : imem_opcode     :="010110";        -- ADD  RO,R1,R2    --        
    signal  MUL          : imem_opcode     :="010111";        -- MUL  RO,R1,R2    --     
    signal  SUBB         : imem_opcode     :="011000";        -- SUB  RO,R1,R2    -- 
    signal  DIV          : imem_opcode     :="011001";        -- DIV  RO,R1,R2    --      -- R1 will be overwritten with remainder 
    signal  ADDi         : imem_opcode     :="011010";        -- ADDi RO,1,R2     --        
    signal  SUBi         : imem_opcode     :="011011";        -- SUBi RO,1,R2     --          
    signal  DIVi         : imem_opcode     :="011100";        -- DIVi RO,R1,1     Problem with div ALU      -- R1 will be overwritten with remainder 
    signal  POWi         : imem_opcode     :="011101";        -- POWi RO,1,R1     --     
    signal  POW          : imem_opcode     :="011110";        -- POWv RO,R2,R1    Left DIVi and Pow need Alu Modifications       
    
  
    -- Branch Instructions (will work on single mem locs only) 

    signal  JEQ         : imem_opcode     :="011111";   --     -- JEQ RO,R2,Line_Address        --Cannot jump more than 256 Lines up down --changer seee new index
    signal  JNE         : imem_opcode     :="100000";   --     -- JNE RO,R2,Line_Address         
    signal  JLE         : imem_opcode     :="100001";   --     -- JLE RO,R2,Line_Address          
    signal  JGE         : imem_opcode     :="100010";   --     -- JGE RO,R2,Line_Address     
    signal  JMP         : imem_opcode     :="100011";   --     -- JMP Line_Address              -- Unconditional Jump
    
    signal  JLT         : imem_opcode     :="100100"; 
    
    signal  JGT         : imem_opcode     :="100101"; 
    signal  CREAL       : imem_opcode     :="100110"; 

    
    --Immidiate loading to memory
    
    signal  LOD         : imem_opcode     :="100111";
    signal  LODn        : imem_opcode     :="101000";       --     -- LOD RO,Value(1,2,3,...)       --             like Li (load Immidiate )
    signal  CPY         : imem_opcode     :="101001";   --    -- CPY RO,R1 its just MOV        --
    signal  CPYm        : imem_opcode     :="101010";   --     -- CPYm M0,M1copy matrix         --
    signal  CPYC        : imem_opcode     :="101011";  
    
    
    signal  LSR          : imem_opcode    :="101100";  --    -- Load to special Register         LSR R0; 
    signal  WFSR         : imem_opcode    :="101101";  --     -- write from special register     WFSR M0 R1 R2  M0(X,Y)
    
    signal  SFSR         : imem_opcode    :="101110";   --     -- Load to special Register          WFSR M0 R1 R2  M0(X,Y)  -- Use This one instead fo lfsr
    signal  LRC          : imem_opcode    :="101111";  --      -- LOAD ROW and COl drom memory      LRC dummy , R0,R1 
    signal  WTSR         : imem_opcode    :="110000";   --     -- write from special register       WTSR M0 R1 R2=>  M0(X,Y)    

    -- Specialized Functions
    
    signal  IMAT        : imem_opcode     :="110001";    --     --Initalize a matrix (before saving results) IMAT M16,256,256 --row,col                  
    signal  RSHP        : imem_opcode     :="110010";    -- 
    signal  MERG        : imem_opcode     :="110011";    --      
    signal  JGABS       : imem_opcode     :="111101";    -- 

    signal  STOPP       : imem_opcode     :="111111";    --    -- Caution DONOT CAHNGE THIS VALUE OR ADJUST WITH STOP first 6 BITS BELOW Stop Porcessor                                 POWmv M0,R0    
   
   
      
   
   
    --Now naming Matrix locations for my own ease 
    
       signal  M0          : mem_manager_address  :="00000000000000";
    signal  M1          : mem_manager_address  :="00000000000001";
    signal  M2          : mem_manager_address  :="00000000000010";
    signal  M3          : mem_manager_address  :="00000000000011";
    signal  M4          : mem_manager_address  :="00000000000100";
    signal  M5          : mem_manager_address  :="00000000000101";
    signal  M6          : mem_manager_address  :="00000000000110";
    signal  M7          : mem_manager_address  :="00000000000111";
    signal  M8          : mem_manager_address  :="00000000001000";
    signal  M9          : mem_manager_address  :="00000000001001";
    signal  M10          : mem_manager_address  :="00000000001010";
    signal  M11          : mem_manager_address  :="00000000001011";
    signal  M12          : mem_manager_address  :="00000000001100";
    signal  M13          : mem_manager_address  :="00000000001101";
    signal  M14          : mem_manager_address  :="00000000001110";
    signal  M15          : mem_manager_address  :="00000000001111";
    signal  M16          : mem_manager_address  :="00000000010000";
    signal  M17          : mem_manager_address  :="00000000010001";
    signal  M18          : mem_manager_address  :="00000000010010";
    signal  M19          : mem_manager_address  :="00000000010011";
    signal  M20          : mem_manager_address  :="00000000010100";
    signal  M21          : mem_manager_address  :="00000000010101";
    signal  M22          : mem_manager_address  :="00000000010110";
    signal  M23          : mem_manager_address  :="00000000010111";
    signal  M24          : mem_manager_address  :="00000000011000";
    signal  M25          : mem_manager_address  :="00000000011001";
    signal  M26          : mem_manager_address  :="00000000011010";
    signal  M27          : mem_manager_address  :="00000000011011";
    signal  M28          : mem_manager_address  :="00000000011100";
    signal  M29          : mem_manager_address  :="00000000011101";
    signal  M30          : mem_manager_address  :="00000000011110";
    signal  M31          : mem_manager_address  :="00000000011111";
    signal  R0          : mem_manager_address  :="00000000000000";
    signal  R1          : mem_manager_address  :="00000000000001";
    signal  R2          : mem_manager_address  :="00000000000010";
    signal  R3          : mem_manager_address  :="00000000000011";
    signal  R4          : mem_manager_address  :="00000000000100";
    signal  R5          : mem_manager_address  :="00000000000101";
    signal  R6          : mem_manager_address  :="00000000000110";
    signal  R7          : mem_manager_address  :="00000000000111";
    signal  R8          : mem_manager_address  :="00000000001000";
    signal  R9          : mem_manager_address  :="00000000001001";
    signal  R10          : mem_manager_address  :="00000000001010";
    signal  R11          : mem_manager_address  :="00000000001011";
    signal  R12          : mem_manager_address  :="00000000001100";
    signal  R13          : mem_manager_address  :="00000000001101";
    signal  R14          : mem_manager_address  :="00000000001110";
    signal  R15          : mem_manager_address  :="00000000001111";
    signal  R16          : mem_manager_address  :="00000000010000";
    signal  R17          : mem_manager_address  :="00000000010001";
    signal  R18          : mem_manager_address  :="00000000010010";
    signal  R19          : mem_manager_address  :="00000000010011";
    signal  R20          : mem_manager_address  :="00000000010100";
    signal  R21          : mem_manager_address  :="00000000010101";
    signal  R22          : mem_manager_address  :="00000000010110";
    signal  R23          : mem_manager_address  :="00000000010111";
    signal  R24          : mem_manager_address  :="00000000011000";
    signal  R25          : mem_manager_address  :="00000000011001";
    signal  R26          : mem_manager_address  :="00000000011010";
    signal  R27          : mem_manager_address  :="00000000011011";
    signal  R28          : mem_manager_address  :="00000000011100";
    signal  R29          : mem_manager_address  :="00000000011101";
    signal  R30          : mem_manager_address  :="00000000011110";
    signal  R31          : mem_manager_address  :="00000000011111";
    signal  R32          : mem_manager_address  :="00000000100000";
    signal  R33          : mem_manager_address  :="00000000100001";
    signal  R34          : mem_manager_address  :="00000000100010";
    signal  R35          : mem_manager_address  :="00000000100011";
    signal  R36          : mem_manager_address  :="00000000100100";
    signal  R37          : mem_manager_address  :="00000000100101";
    signal  R38          : mem_manager_address  :="00000000100110";
    signal  R39          : mem_manager_address  :="00000000100111";
    signal  R40          : mem_manager_address  :="00000000101000";
    signal  R41          : mem_manager_address  :="00000000101001";
    signal  R42          : mem_manager_address  :="00000000101010";
    signal  R43          : mem_manager_address  :="00000000101011";
    signal  R44          : mem_manager_address  :="00000000101100";
    signal  R45          : mem_manager_address  :="00000000101101";
    signal  R46          : mem_manager_address  :="00000000101110";
    signal  R47          : mem_manager_address  :="00000000101111";
    signal  R48          : mem_manager_address  :="00000000110000";
    signal  R49          : mem_manager_address  :="00000000110001";
    signal  R50          : mem_manager_address  :="00000000110010";
    signal  R51          : mem_manager_address  :="00000000110011";
    signal  R52          : mem_manager_address  :="00000000110100";
    signal  R53          : mem_manager_address  :="00000000110101";
    signal  R54          : mem_manager_address  :="00000000110110";
    signal  R55          : mem_manager_address  :="00000000110111";
    signal  R56          : mem_manager_address  :="00000000111000";
    signal  R57          : mem_manager_address  :="00000000111001";
    signal  R58          : mem_manager_address  :="00000000111010";
    signal  R59          : mem_manager_address  :="00000000111011";
    signal  R60          : mem_manager_address  :="00000000111100";
    signal  R61          : mem_manager_address  :="00000000111101";
    signal  R62          : mem_manager_address  :="00000000111110";
    signal  R63          : mem_manager_address  :="00000000111111";
    signal  R64          : mem_manager_address  :="00000001000000";
    signal  R65          : mem_manager_address  :="00000001000001";
    signal  R66          : mem_manager_address  :="00000001000010";
    signal  R67          : mem_manager_address  :="00000001000011";
    signal  R68          : mem_manager_address  :="00000001000100";
    signal  R69          : mem_manager_address  :="00000001000101";
    signal  R70          : mem_manager_address  :="00000001000110";
    signal  R71          : mem_manager_address  :="00000001000111";
    signal  R72          : mem_manager_address  :="00000001001000";
    signal  R73          : mem_manager_address  :="00000001001001";
    signal  R74          : mem_manager_address  :="00000001001010";
    signal  R75          : mem_manager_address  :="00000001001011";
    signal  R76          : mem_manager_address  :="00000001001100";
    signal  R77          : mem_manager_address  :="00000001001101";
    signal  R78          : mem_manager_address  :="00000001001110";
    signal  R79          : mem_manager_address  :="00000001001111";
    signal  R80          : mem_manager_address  :="00000001010000";
    signal  R81          : mem_manager_address  :="00000001010001";
    signal  R82          : mem_manager_address  :="00000001010010";
    signal  R83          : mem_manager_address  :="00000001010011";
    signal  R84          : mem_manager_address  :="00000001010100";
    signal  R85          : mem_manager_address  :="00000001010101";
    signal  R86          : mem_manager_address  :="00000001010110";
    signal  R87          : mem_manager_address  :="00000001010111";
    signal  R88          : mem_manager_address  :="00000001011000";
    signal  R89          : mem_manager_address  :="00000001011001";
    signal  R90          : mem_manager_address  :="00000001011010";
    signal  R91          : mem_manager_address  :="00000001011011";
    signal  R92          : mem_manager_address  :="00000001011100";
    signal  R93          : mem_manager_address  :="00000001011101";
    signal  R94          : mem_manager_address  :="00000001011110";
    signal  R95          : mem_manager_address  :="00000001011111";
    signal  R96          : mem_manager_address  :="00000001100000";
    signal  R97          : mem_manager_address  :="00000001100001";
    signal  R98          : mem_manager_address  :="00000001100010";
    signal  R99          : mem_manager_address  :="00000001100011";
    signal  R100          : mem_manager_address  :="00000001100100";
    signal  R101          : mem_manager_address  :="00000001100101";
    signal  R102          : mem_manager_address  :="00000001100110";
    signal  R103          : mem_manager_address  :="00000001100111";
    signal  R104          : mem_manager_address  :="00000001101000";
    signal  R105          : mem_manager_address  :="00000001101001";
    signal  R106          : mem_manager_address  :="00000001101010";
    signal  R107          : mem_manager_address  :="00000001101011";
    signal  R108          : mem_manager_address  :="00000001101100";
    signal  R109          : mem_manager_address  :="00000001101101";
    signal  R110          : mem_manager_address  :="00000001101110";
    signal  R111          : mem_manager_address  :="00000001101111";
    signal  R112          : mem_manager_address  :="00000001110000";
    signal  R113          : mem_manager_address  :="00000001110001";
    signal  R114          : mem_manager_address  :="00000001110010";
    signal  R115          : mem_manager_address  :="00000001110011";
    signal  R116          : mem_manager_address  :="00000001110100";
    signal  R117          : mem_manager_address  :="00000001110101";
    signal  R118          : mem_manager_address  :="00000001110110";
    signal  R119          : mem_manager_address  :="00000001110111";
    signal  R120          : mem_manager_address  :="00000001111000";
    signal  R121          : mem_manager_address  :="00000001111001";
    signal  R122          : mem_manager_address  :="00000001111010";
    signal  R123          : mem_manager_address  :="00000001111011";
    signal  R124          : mem_manager_address  :="00000001111100";
    signal  R125          : mem_manager_address  :="00000001111101";
    signal  R126          : mem_manager_address  :="00000001111110";
    signal  R127          : mem_manager_address  :="00000001111111";
    signal  R128          : mem_manager_address  :="00000010000000";
    signal  R129          : mem_manager_address  :="00000010000001";
    signal  R130          : mem_manager_address  :="00000010000010";
    signal  R131          : mem_manager_address  :="00000010000011";
    signal  R132          : mem_manager_address  :="00000010000100";
    signal  R133          : mem_manager_address  :="00000010000101";
    signal  R134          : mem_manager_address  :="00000010000110";
    signal  R135          : mem_manager_address  :="00000010000111";
    signal  R136          : mem_manager_address  :="00000010001000";
    signal  R137          : mem_manager_address  :="00000010001001";
    signal  R138          : mem_manager_address  :="00000010001010";
    signal  R139          : mem_manager_address  :="00000010001011";
    signal  R140          : mem_manager_address  :="00000010001100";
    signal  R141          : mem_manager_address  :="00000010001101";
    signal  R142          : mem_manager_address  :="00000010001110";
    signal  R143          : mem_manager_address  :="00000010001111";
    signal  R144          : mem_manager_address  :="00000010010000";
    signal  R145          : mem_manager_address  :="00000010010001";
    signal  R146          : mem_manager_address  :="00000010010010";
    signal  R147          : mem_manager_address  :="00000010010011";
    signal  R148          : mem_manager_address  :="00000010010100";
    signal  R149          : mem_manager_address  :="00000010010101";
    signal  R150          : mem_manager_address  :="00000010010110";
    signal  R151          : mem_manager_address  :="00000010010111";
    signal  R152          : mem_manager_address  :="00000010011000";
    signal  R153          : mem_manager_address  :="00000010011001";
    signal  R154          : mem_manager_address  :="00000010011010";
    signal  R155          : mem_manager_address  :="00000010011011";
    signal  R156          : mem_manager_address  :="00000010011100";
    signal  R157          : mem_manager_address  :="00000010011101";
    signal  R158          : mem_manager_address  :="00000010011110";
    signal  R159          : mem_manager_address  :="00000010011111";
    signal  R160          : mem_manager_address  :="00000010100000";
    signal  R161          : mem_manager_address  :="00000010100001";
    signal  R162          : mem_manager_address  :="00000010100010";
    signal  R163          : mem_manager_address  :="00000010100011";
    signal  R164          : mem_manager_address  :="00000010100100";
    signal  R165          : mem_manager_address  :="00000010100101";
    signal  R166          : mem_manager_address  :="00000010100110";
    signal  R167          : mem_manager_address  :="00000010100111";
    signal  R168          : mem_manager_address  :="00000010101000";
    signal  R169          : mem_manager_address  :="00000010101001";
    signal  R170          : mem_manager_address  :="00000010101010";
    signal  R171          : mem_manager_address  :="00000010101011";
    signal  R172          : mem_manager_address  :="00000010101100";
    signal  R173          : mem_manager_address  :="00000010101101";
    signal  R174          : mem_manager_address  :="00000010101110";
    signal  R175          : mem_manager_address  :="00000010101111";
    signal  R176          : mem_manager_address  :="00000010110000";
    signal  R177          : mem_manager_address  :="00000010110001";
    signal  R178          : mem_manager_address  :="00000010110010";
    signal  R179          : mem_manager_address  :="00000010110011";
    signal  R180          : mem_manager_address  :="00000010110100";
    signal  R181          : mem_manager_address  :="00000010110101";
    signal  R182          : mem_manager_address  :="00000010110110";
    signal  R183          : mem_manager_address  :="00000010110111";
    signal  R184          : mem_manager_address  :="00000010111000";
    signal  R185          : mem_manager_address  :="00000010111001";
    signal  R186          : mem_manager_address  :="00000010111010";
    signal  R187          : mem_manager_address  :="00000010111011";
    signal  R188          : mem_manager_address  :="00000010111100";
    signal  R189          : mem_manager_address  :="00000010111101";
    signal  R190          : mem_manager_address  :="00000010111110";
    signal  R191          : mem_manager_address  :="00000010111111";
    signal  R192          : mem_manager_address  :="00000011000000";
    signal  R193          : mem_manager_address  :="00000011000001";
    signal  R194          : mem_manager_address  :="00000011000010";
    signal  R195          : mem_manager_address  :="00000011000011";
    signal  R196          : mem_manager_address  :="00000011000100";
    signal  R197          : mem_manager_address  :="00000011000101";
    signal  R198          : mem_manager_address  :="00000011000110";
    signal  R199          : mem_manager_address  :="00000011000111";
    signal  R200          : mem_manager_address  :="00000011001000";
    signal  RFN5          : mem_manager_address  :="10000000000000";
    signal  RFN4          : mem_manager_address  :="10000000000000";
    signal  RFN3          : mem_manager_address  :="10000000000000";
    signal  RFN2          : mem_manager_address  :="10000000000000";
    signal  RFN1          : mem_manager_address  :="11000000000000";
    signal  RF0          : mem_manager_address  :="00000000000000";
    signal  RF1          : mem_manager_address  :="01000000000000";
    signal  RF2          : mem_manager_address  :="10000000000000";
    signal  RF3          : mem_manager_address  :="11000000000000";

    signal  RFND5         : mem_manager_address  :="11100000000000";
    signal  RFD5          : mem_manager_address  :="00100000000000";

    
    --Adjusted Full Instruction   
    signal  STOP        : imem_row     :="111111000000000000000000000000000000000000000000";        --Stop Porcessor                                 POWmv M0,R0    
   
 
end package definitions;
