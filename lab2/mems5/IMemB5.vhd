-----------------------------------------------------------------------------
-- Memory generated for 'Fully-Connected Layer with ReLU', PSD/DSD (2026/27)
-- Copyright (C) by Paulo Flores <paulo.flores@tecnico.ulisboa.pt>
-- Version: Ver. 1.0 2026-10-07
-- Command: dat2mem.pl -n -s 5
-- Seed: -s 5 ( dat2mem.pl -n -s 5 -s 5 )
-- Date: 2026-10-19T09:32:03 WEST
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


architecture GEN5 of IMemB is
  signal data : std_logic_vector(31 downto 0);
begin

  MEM_in : BRAM_SINGLE_MACRO
    generic map (          -- memory initialization
      BRAM_SIZE => "36Kb", -- Target BRAM, "18Kb" or "36Kb"
      DEVICE => "7SERIES", -- Target Device: "VIRTEX5", "7SERIES", "VIRTEX6, "SPARTAN6"
      WRITE_WIDTH => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      READ_WIDTH  => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      -- Initialize memory predefined data
      INIT_00 => X"96FDE83E5E1F0B321244C203A112FFF40EBD9AD988E48E0DDAE691A6662F0694",
      INIT_01 => X"D7F3E81BE1F1E7D0745B02CAEE225AC5F958EA1D83F543FC08694C2A26DE611E",
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

end GEN5;

-- B[ 0][ 0]= -108 (0x94)
-- B[ 1][ 0]=    6 (0x06)
-- B[ 2][ 0]=   47 (0x2F)
-- B[ 3][ 0]=  102 (0x66)
-- B[ 4][ 0]=  -90 (0xA6)
-- B[ 5][ 0]= -111 (0x91)
-- B[ 6][ 0]=  -26 (0xE6)
-- B[ 7][ 0]=  -38 (0xDA)
-- B[ 8][ 0]=   13 (0x0D)
-- B[ 9][ 0]= -114 (0x8E)
-- B[10][ 0]=  -28 (0xE4)
-- B[11][ 0]= -120 (0x88)
-- B[12][ 0]=  -39 (0xD9)
-- B[13][ 0]= -102 (0x9A)
-- B[14][ 0]=  -67 (0xBD)
-- B[15][ 0]=   14 (0x0E)
-- B[16][ 0]=  -12 (0xF4)
-- B[17][ 0]=   -1 (0xFF)
-- B[18][ 0]=   18 (0x12)
-- B[19][ 0]=  -95 (0xA1)
-- B[20][ 0]=    3 (0x03)
-- B[21][ 0]=  -62 (0xC2)
-- B[22][ 0]=   68 (0x44)
-- B[23][ 0]=   18 (0x12)
-- B[24][ 0]=   50 (0x32)
-- B[25][ 0]=   11 (0x0B)
-- B[26][ 0]=   31 (0x1F)
-- B[27][ 0]=   94 (0x5E)
-- B[28][ 0]=   62 (0x3E)
-- B[29][ 0]=  -24 (0xE8)
-- B[30][ 0]=   -3 (0xFD)
-- B[31][ 0]= -106 (0x96)
-- B[32][ 0]=   30 (0x1E)
-- B[33][ 0]=   97 (0x61)
-- B[34][ 0]=  -34 (0xDE)
-- B[35][ 0]=   38 (0x26)
-- B[36][ 0]=   42 (0x2A)
-- B[37][ 0]=   76 (0x4C)
-- B[38][ 0]=  105 (0x69)
-- B[39][ 0]=    8 (0x08)
-- B[40][ 0]=   -4 (0xFC)
-- B[41][ 0]=   67 (0x43)
-- B[42][ 0]=  -11 (0xF5)
-- B[43][ 0]= -125 (0x83)
-- B[44][ 0]=   29 (0x1D)
-- B[45][ 0]=  -22 (0xEA)
-- B[46][ 0]=   88 (0x58)
-- B[47][ 0]=   -7 (0xF9)
-- B[48][ 0]=  -59 (0xC5)
-- B[49][ 0]=   90 (0x5A)
-- B[50][ 0]=   34 (0x22)
-- B[51][ 0]=  -18 (0xEE)
-- B[52][ 0]=  -54 (0xCA)
-- B[53][ 0]=    2 (0x02)
-- B[54][ 0]=   91 (0x5B)
-- B[55][ 0]=  116 (0x74)
-- B[56][ 0]=  -48 (0xD0)
-- B[57][ 0]=  -25 (0xE7)
-- B[58][ 0]=  -15 (0xF1)
-- B[59][ 0]=  -31 (0xE1)
-- B[60][ 0]=   27 (0x1B)
-- B[61][ 0]=  -24 (0xE8)
-- B[62][ 0]=  -13 (0xF3)
-- B[63][ 0]=  -41 (0xD7)


