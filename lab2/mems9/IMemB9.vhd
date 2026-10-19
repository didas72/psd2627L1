-----------------------------------------------------------------------------
-- Memory generated for 'Fully-Connected Layer with ReLU', PSD/DSD (2026/27)
-- Copyright (C) by Paulo Flores <paulo.flores@tecnico.ulisboa.pt>
-- Version: Ver. 1.0 2026-10-07
-- Command: dat2mem.pl -n -s 9
-- Seed: -s 9 ( dat2mem.pl -n -s 9 -s 9 )
-- Date: 2026-10-19T09:32:13 WEST
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


architecture GEN9 of IMemB is
  signal data : std_logic_vector(31 downto 0);
begin

  MEM_in : BRAM_SINGLE_MACRO
    generic map (          -- memory initialization
      BRAM_SIZE => "36Kb", -- Target BRAM, "18Kb" or "36Kb"
      DEVICE => "7SERIES", -- Target Device: "VIRTEX5", "7SERIES", "VIRTEX6, "SPARTAN6"
      WRITE_WIDTH => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      READ_WIDTH  => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      -- Initialize memory predefined data
      INIT_00 => X"B4ED1248FC7BFA4C14D47CF1CFE204C727CE5E04FFF7E53F90D0744017C65E26",
      INIT_01 => X"B3A3C707E664261B03C17919F3BCBC458D7860040B51584F3248FD50F32BB8B2",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000"
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

end GEN9;

-- B[ 0][ 0]=   38 (0x26)
-- B[ 1][ 0]=   94 (0x5E)
-- B[ 2][ 0]=  -58 (0xC6)
-- B[ 3][ 0]=   23 (0x17)
-- B[ 4][ 0]=   64 (0x40)
-- B[ 5][ 0]=  116 (0x74)
-- B[ 6][ 0]=  -48 (0xD0)
-- B[ 7][ 0]= -112 (0x90)
-- B[ 8][ 0]=   63 (0x3F)
-- B[ 9][ 0]=  -27 (0xE5)
-- B[10][ 0]=   -9 (0xF7)
-- B[11][ 0]=   -1 (0xFF)
-- B[12][ 0]=    4 (0x04)
-- B[13][ 0]=   94 (0x5E)
-- B[14][ 0]=  -50 (0xCE)
-- B[15][ 0]=   39 (0x27)
-- B[16][ 0]=  -57 (0xC7)
-- B[17][ 0]=    4 (0x04)
-- B[18][ 0]=  -30 (0xE2)
-- B[19][ 0]=  -49 (0xCF)
-- B[20][ 0]=  -15 (0xF1)
-- B[21][ 0]=  124 (0x7C)
-- B[22][ 0]=  -44 (0xD4)
-- B[23][ 0]=   20 (0x14)
-- B[24][ 0]=   76 (0x4C)
-- B[25][ 0]=   -6 (0xFA)
-- B[26][ 0]=  123 (0x7B)
-- B[27][ 0]=   -4 (0xFC)
-- B[28][ 0]=   72 (0x48)
-- B[29][ 0]=   18 (0x12)
-- B[30][ 0]=  -19 (0xED)
-- B[31][ 0]=  -76 (0xB4)
-- B[32][ 0]=  -78 (0xB2)
-- B[33][ 0]=  -72 (0xB8)
-- B[34][ 0]=   43 (0x2B)
-- B[35][ 0]=  -13 (0xF3)
-- B[36][ 0]=   80 (0x50)
-- B[37][ 0]=   -3 (0xFD)
-- B[38][ 0]=   72 (0x48)
-- B[39][ 0]=   50 (0x32)
-- B[40][ 0]=   79 (0x4F)
-- B[41][ 0]=   88 (0x58)
-- B[42][ 0]=   81 (0x51)
-- B[43][ 0]=   11 (0x0B)
-- B[44][ 0]=    4 (0x04)
-- B[45][ 0]=   96 (0x60)
-- B[46][ 0]=  120 (0x78)
-- B[47][ 0]= -115 (0x8D)
-- B[48][ 0]=   69 (0x45)
-- B[49][ 0]=  -68 (0xBC)
-- B[50][ 0]=  -68 (0xBC)
-- B[51][ 0]=  -13 (0xF3)
-- B[52][ 0]=   25 (0x19)
-- B[53][ 0]=  121 (0x79)
-- B[54][ 0]=  -63 (0xC1)
-- B[55][ 0]=    3 (0x03)
-- B[56][ 0]=   27 (0x1B)
-- B[57][ 0]=   38 (0x26)
-- B[58][ 0]=  100 (0x64)
-- B[59][ 0]=  -26 (0xE6)
-- B[60][ 0]=    7 (0x07)
-- B[61][ 0]=  -57 (0xC7)
-- B[62][ 0]=  -93 (0xA3)
-- B[63][ 0]=  -77 (0xB3)


