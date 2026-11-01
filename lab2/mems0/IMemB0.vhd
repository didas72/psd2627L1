-----------------------------------------------------------------------------
-- Memory generated for 'Fully-Connected Layer with ReLU', PSD/DSD (2026/27)
-- Copyright (C) by Paulo Flores <paulo.flores@tecnico.ulisboa.pt>
-- Version: Ver. 1.0 2026-10-07
-- Command: dat2mem.pl -n -s 0
-- Seed: -s 0 ( dat2mem.pl -n -s 0 -s 0 )
-- Date: 2026-10-19T09:31:55 WEST
-----------------------------------------------------------------------------
library ieee;
library UNISIM;
library UNIMACRO;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use UNISIM.Vcomponents.all;
use UNIMACRO.vcomponents.all;


entity IMemB is
  port (
    clk   : in  std_logic;
    addr  : in  std_logic_vector(9 downto 0);
    data0 : out std_logic_vector(7 downto 0);
    data1 : out std_logic_vector(7 downto 0);
    data2 : out std_logic_vector(7 downto 0);
    data3 : out std_logic_vector(7 downto 0)
    );
end IMemB;


architecture GEN0 of IMemB is
  signal data : std_logic_vector(31 downto 0);
begin

  MEM_in : BRAM_SINGLE_MACRO
    generic map (          -- memory initialization
      BRAM_SIZE => "36Kb", -- Target BRAM, "18Kb" or "36Kb"
      DEVICE => "7SERIES", -- Target Device: "VIRTEX5", "7SERIES", "VIRTEX6, "SPARTAN6"
      WRITE_WIDTH => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      READ_WIDTH  => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      -- Initialize memory predefined data
      
--      --Men 0
--      INIT_00 => X"EF63FFEFF1FFCA120FD15637061F022FB1E9EFEDF3AC60B0D9BE2A26F68C7A1B",
--      INIT_01 => X"7A124EBAA5FD6DD767402BFAE716DF91A3511945999BA7FBEC73D239253F401D",
--      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000"
      
--      -- Mem 1 
--    INIT_00 => X"08E82032C83BED18F0B507EDF2FE822343AD6E366FD082A45A04970CB61930CD",
--    INIT_01 => X"FCF6883DA5FFF1BD6A77F6ADE9FEF9311AB8B444FB1B533822F41BFE3F138677",
--    INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000"
    
--    -- Mem 2 
--    INIT_00 => X"02EDC20B1E8C8FE1F067356E22E6FFE8368E14FD2F751B690CB7AC0D623F9BFE",
--    INIT_01 => X"F223E035DDFB4EDF6B4F99D5E9992F8CAB1F8234A2D2336A28DDFA34D919342E",
--    INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000"
    
--    -- Mem 3 
--    INIT_00 => X"06F35CC70C2D4FDAF083E3B536CA00F4D9CBEAC7339AC88B3FF194D9F2E5E550",
--    INIT_01 => X"1642C8ADA2095507EF693B05EBB0AA360F08302D41F638E2F3BAF316F3396DAD",
--    INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000"
    
--    -- Mem 4 
--    INIT_00 => X"72F87BFA34992D2CEF611326B6D200021CFA181015BF55FF8E2CAE40C50B501E",
--    INIT_01 => X"A0A89023A00B0815F15E23DD6DC87E79B5F09DDC21C1C250C2AFA1E00C74D807",
--    INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000"
    
--    -- Mem 5 
--    INIT_00 => X"96FDE83E5E1F0B321244C203A112FFF40EBD9AD988E48E0DDAE691A6662F0694",
--    INIT_01 => X"D7F3E81BE1F1E7D0745B02CAEE225AC5F958EA1D83F543FC08694C2A26DE611E",
--    INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000"
    
--    -- Mem 6 
--    INIT_00 => X"E37D360007A7EAC712D770A27374FF9700FEE55FD98810195960D0F412563DC5",
--    INIT_01 => X"CFF1C0ED63113DB58A95A0F0F00A4DFD424049EAE52DB736D1FEC78D404FE542",
--    INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000"
    
--    -- Mem 8 
    INIT_00 => X"52F273065B4CD94514F04FECE43B04526509204D1ED2C932C3EBCDA61621D957",
    INIT_01 => X"4344F0FE65E8FF000506E442F3251C023811D3FA58E5AEE419D0F0070D280F0C",
    INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000"
    
    -- Mem 9 
--    INIT_00 => X"B4ED1248FC7BFA4C14D47CF1CFE204C727CE5E04FFF7E53F90D0744017C65E26",
--    INIT_01 => X"B3A3C707E664261B03C17919F3BCBC458D7860040B51584F3248FD50F32BB8B2",
--    INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000"
    
--    -- Test +127
--    INIT_00 => X"7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F",
--    INIT_01 => X"7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F",
--    INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000"
    
--    -- Test -128
--    INIT_00 => X"8080808080808080808080808080808080808080808080808080808080808080",
--    INIT_01 => X"8080808080808080808080808080808080808080808080808080808080808080",
--    INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000"


    
    
    )
    port map (
      CLK   => clk,         -- Clock
      ADDR  => addr,        -- 10-bit Address Input, width defined by read/write port depth
      DI    => x"00000000", -- 32-bit Data Input, width defined by WRITE_WIDTH parameter
      DO    => data,        -- 32-bit Data Output, width defined by READ_WIDTH parameter
      EN    => '1',         -- 1-bit RAM Enable Input
      WE    => "0000",      -- Write Enable Input, width defined by write port depth
      REGCE => '0',         -- 1-bit Input, output register enable
      RST   => '0'          -- 1-bit Input reset
      );

  data0 <= data(7 downto 0);
  data1 <= data(15 downto 8);
  data2 <= data(23 downto 16);
  data3 <= data(31 downto 24);

end GEN0;

-- B[ 0][ 0]=   27 (0x1B)
-- B[ 1][ 0]=  122 (0x7A)
-- B[ 2][ 0]= -116 (0x8C)
-- B[ 3][ 0]=  -10 (0xF6)
-- B[ 4][ 0]=   38 (0x26)
-- B[ 5][ 0]=   42 (0x2A)
-- B[ 6][ 0]=  -66 (0xBE)
-- B[ 7][ 0]=  -39 (0xD9)
-- B[ 8][ 0]=  -80 (0xB0)
-- B[ 9][ 0]=   96 (0x60)
-- B[10][ 0]=  -84 (0xAC)
-- B[11][ 0]=  -13 (0xF3)
-- B[12][ 0]=  -19 (0xED)
-- B[13][ 0]=  -17 (0xEF)
-- B[14][ 0]=  -23 (0xE9)
-- B[15][ 0]=  -79 (0xB1)
-- B[16][ 0]=   47 (0x2F)
-- B[17][ 0]=    2 (0x02)
-- B[18][ 0]=   31 (0x1F)
-- B[19][ 0]=    6 (0x06)
-- B[20][ 0]=   55 (0x37)
-- B[21][ 0]=   86 (0x56)
-- B[22][ 0]=  -47 (0xD1)
-- B[23][ 0]=   15 (0x0F)
-- B[24][ 0]=   18 (0x12)
-- B[25][ 0]=  -54 (0xCA)
-- B[26][ 0]=   -1 (0xFF)
-- B[27][ 0]=  -15 (0xF1)
-- B[28][ 0]=  -17 (0xEF)
-- B[29][ 0]=   -1 (0xFF)
-- B[30][ 0]=   99 (0x63)
-- B[31][ 0]=  -17 (0xEF)
-- B[32][ 0]=   29 (0x1D)
-- B[33][ 0]=   64 (0x40)
-- B[34][ 0]=   63 (0x3F)
-- B[35][ 0]=   37 (0x25)
-- B[36][ 0]=   57 (0x39)
-- B[37][ 0]=  -46 (0xD2)
-- B[38][ 0]=  115 (0x73)
-- B[39][ 0]=  -20 (0xEC)
-- B[40][ 0]=   -5 (0xFB)
-- B[41][ 0]=  -89 (0xA7)
-- B[42][ 0]= -101 (0x9B)
-- B[43][ 0]= -103 (0x99)
-- B[44][ 0]=   69 (0x45)
-- B[45][ 0]=   25 (0x19)
-- B[46][ 0]=   81 (0x51)
-- B[47][ 0]=  -93 (0xA3)
-- B[48][ 0]= -111 (0x91)
-- B[49][ 0]=  -33 (0xDF)
-- B[50][ 0]=   22 (0x16)
-- B[51][ 0]=  -25 (0xE7)
-- B[52][ 0]=   -6 (0xFA)
-- B[53][ 0]=   43 (0x2B)
-- B[54][ 0]=   64 (0x40)
-- B[55][ 0]=  103 (0x67)
-- B[56][ 0]=  -41 (0xD7)
-- B[57][ 0]=  109 (0x6D)
-- B[58][ 0]=   -3 (0xFD)
-- B[59][ 0]=  -91 (0xA5)
-- B[60][ 0]=  -70 (0xBA)
-- B[61][ 0]=   78 (0x4E)
-- B[62][ 0]=   18 (0x12)
-- B[63][ 0]=  122 (0x7A)


