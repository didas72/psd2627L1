-----------------------------------------------------------------------------
-- Memory generated for 'Fully-Connected Layer with ReLU', PSD/DSD (2026/27)
-- Copyright (C) by Paulo Flores <paulo.flores@tecnico.ulisboa.pt>
-- Version: Ver. 1.0 2026-10-07
-- Command: dat2mem.pl -n -s 4
-- Seed: -s 4 ( dat2mem.pl -n -s 4 -s 4 )
-- Date: 2026-10-19T09:32:01 WEST
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


architecture GEN4 of IMemB is
  signal data : std_logic_vector(31 downto 0);
begin

  MEM_in : BRAM_SINGLE_MACRO
    generic map (          -- memory initialization
      BRAM_SIZE => "36Kb", -- Target BRAM, "18Kb" or "36Kb"
      DEVICE => "7SERIES", -- Target Device: "VIRTEX5", "7SERIES", "VIRTEX6, "SPARTAN6"
      WRITE_WIDTH => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      READ_WIDTH  => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      -- Initialize memory predefined data
      INIT_00 => X"72F87BFA34992D2CEF611326B6D200021CFA181015BF55FF8E2CAE40C50B501E",
      INIT_01 => X"A0A89023A00B0815F15E23DD6DC87E79B5F09DDC21C1C250C2AFA1E00C74D807",
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

end GEN4;

-- B[ 0][ 0]=   30 (0x1E)
-- B[ 1][ 0]=   80 (0x50)
-- B[ 2][ 0]=   11 (0x0B)
-- B[ 3][ 0]=  -59 (0xC5)
-- B[ 4][ 0]=   64 (0x40)
-- B[ 5][ 0]=  -82 (0xAE)
-- B[ 6][ 0]=   44 (0x2C)
-- B[ 7][ 0]= -114 (0x8E)
-- B[ 8][ 0]=   -1 (0xFF)
-- B[ 9][ 0]=   85 (0x55)
-- B[10][ 0]=  -65 (0xBF)
-- B[11][ 0]=   21 (0x15)
-- B[12][ 0]=   16 (0x10)
-- B[13][ 0]=   24 (0x18)
-- B[14][ 0]=   -6 (0xFA)
-- B[15][ 0]=   28 (0x1C)
-- B[16][ 0]=    2 (0x02)
-- B[17][ 0]=    0 (0x00)
-- B[18][ 0]=  -46 (0xD2)
-- B[19][ 0]=  -74 (0xB6)
-- B[20][ 0]=   38 (0x26)
-- B[21][ 0]=   19 (0x13)
-- B[22][ 0]=   97 (0x61)
-- B[23][ 0]=  -17 (0xEF)
-- B[24][ 0]=   44 (0x2C)
-- B[25][ 0]=   45 (0x2D)
-- B[26][ 0]= -103 (0x99)
-- B[27][ 0]=   52 (0x34)
-- B[28][ 0]=   -6 (0xFA)
-- B[29][ 0]=  123 (0x7B)
-- B[30][ 0]=   -8 (0xF8)
-- B[31][ 0]=  114 (0x72)
-- B[32][ 0]=    7 (0x07)
-- B[33][ 0]=  -40 (0xD8)
-- B[34][ 0]=  116 (0x74)
-- B[35][ 0]=   12 (0x0C)
-- B[36][ 0]=  -32 (0xE0)
-- B[37][ 0]=  -95 (0xA1)
-- B[38][ 0]=  -81 (0xAF)
-- B[39][ 0]=  -62 (0xC2)
-- B[40][ 0]=   80 (0x50)
-- B[41][ 0]=  -62 (0xC2)
-- B[42][ 0]=  -63 (0xC1)
-- B[43][ 0]=   33 (0x21)
-- B[44][ 0]=  -36 (0xDC)
-- B[45][ 0]=  -99 (0x9D)
-- B[46][ 0]=  -16 (0xF0)
-- B[47][ 0]=  -75 (0xB5)
-- B[48][ 0]=  121 (0x79)
-- B[49][ 0]=  126 (0x7E)
-- B[50][ 0]=  -56 (0xC8)
-- B[51][ 0]=  109 (0x6D)
-- B[52][ 0]=  -35 (0xDD)
-- B[53][ 0]=   35 (0x23)
-- B[54][ 0]=   94 (0x5E)
-- B[55][ 0]=  -15 (0xF1)
-- B[56][ 0]=   21 (0x15)
-- B[57][ 0]=    8 (0x08)
-- B[58][ 0]=   11 (0x0B)
-- B[59][ 0]=  -96 (0xA0)
-- B[60][ 0]=   35 (0x23)
-- B[61][ 0]= -112 (0x90)
-- B[62][ 0]=  -88 (0xA8)
-- B[63][ 0]=  -96 (0xA0)


