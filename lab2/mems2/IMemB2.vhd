-----------------------------------------------------------------------------
-- Memory generated for 'Fully-Connected Layer with ReLU', PSD/DSD (2026/27)
-- Copyright (C) by Paulo Flores <paulo.flores@tecnico.ulisboa.pt>
-- Version: Ver. 1.0 2026-10-07
-- Command: dat2mem.pl -n -s 2
-- Seed: -s 2 ( dat2mem.pl -n -s 2 -s 2 )
-- Date: 2026-10-19T09:31:58 WEST
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


architecture GEN2 of IMemB is
  signal data : std_logic_vector(31 downto 0);
begin

  MEM_in : BRAM_SINGLE_MACRO
    generic map (          -- memory initialization
      BRAM_SIZE => "36Kb", -- Target BRAM, "18Kb" or "36Kb"
      DEVICE => "7SERIES", -- Target Device: "VIRTEX5", "7SERIES", "VIRTEX6, "SPARTAN6"
      WRITE_WIDTH => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      READ_WIDTH  => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      -- Initialize memory predefined data
      INIT_00 => X"02EDC20B1E8C8FE1F067356E22E6FFE8368E14FD2F751B690CB7AC0D623F9BFE",
      INIT_01 => X"F223E035DDFB4EDF6B4F99D5E9992F8CAB1F8234A2D2336A28DDFA34D919342E",
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

end GEN2;

-- B[ 0][ 0]=   -2 (0xFE)
-- B[ 1][ 0]= -101 (0x9B)
-- B[ 2][ 0]=   63 (0x3F)
-- B[ 3][ 0]=   98 (0x62)
-- B[ 4][ 0]=   13 (0x0D)
-- B[ 5][ 0]=  -84 (0xAC)
-- B[ 6][ 0]=  -73 (0xB7)
-- B[ 7][ 0]=   12 (0x0C)
-- B[ 8][ 0]=  105 (0x69)
-- B[ 9][ 0]=   27 (0x1B)
-- B[10][ 0]=  117 (0x75)
-- B[11][ 0]=   47 (0x2F)
-- B[12][ 0]=   -3 (0xFD)
-- B[13][ 0]=   20 (0x14)
-- B[14][ 0]= -114 (0x8E)
-- B[15][ 0]=   54 (0x36)
-- B[16][ 0]=  -24 (0xE8)
-- B[17][ 0]=   -1 (0xFF)
-- B[18][ 0]=  -26 (0xE6)
-- B[19][ 0]=   34 (0x22)
-- B[20][ 0]=  110 (0x6E)
-- B[21][ 0]=   53 (0x35)
-- B[22][ 0]=  103 (0x67)
-- B[23][ 0]=  -16 (0xF0)
-- B[24][ 0]=  -31 (0xE1)
-- B[25][ 0]= -113 (0x8F)
-- B[26][ 0]= -116 (0x8C)
-- B[27][ 0]=   30 (0x1E)
-- B[28][ 0]=   11 (0x0B)
-- B[29][ 0]=  -62 (0xC2)
-- B[30][ 0]=  -19 (0xED)
-- B[31][ 0]=    2 (0x02)
-- B[32][ 0]=   46 (0x2E)
-- B[33][ 0]=   52 (0x34)
-- B[34][ 0]=   25 (0x19)
-- B[35][ 0]=  -39 (0xD9)
-- B[36][ 0]=   52 (0x34)
-- B[37][ 0]=   -6 (0xFA)
-- B[38][ 0]=  -35 (0xDD)
-- B[39][ 0]=   40 (0x28)
-- B[40][ 0]=  106 (0x6A)
-- B[41][ 0]=   51 (0x33)
-- B[42][ 0]=  -46 (0xD2)
-- B[43][ 0]=  -94 (0xA2)
-- B[44][ 0]=   52 (0x34)
-- B[45][ 0]= -126 (0x82)
-- B[46][ 0]=   31 (0x1F)
-- B[47][ 0]=  -85 (0xAB)
-- B[48][ 0]= -116 (0x8C)
-- B[49][ 0]=   47 (0x2F)
-- B[50][ 0]= -103 (0x99)
-- B[51][ 0]=  -23 (0xE9)
-- B[52][ 0]=  -43 (0xD5)
-- B[53][ 0]= -103 (0x99)
-- B[54][ 0]=   79 (0x4F)
-- B[55][ 0]=  107 (0x6B)
-- B[56][ 0]=  -33 (0xDF)
-- B[57][ 0]=   78 (0x4E)
-- B[58][ 0]=   -5 (0xFB)
-- B[59][ 0]=  -35 (0xDD)
-- B[60][ 0]=   53 (0x35)
-- B[61][ 0]=  -32 (0xE0)
-- B[62][ 0]=   35 (0x23)
-- B[63][ 0]=  -14 (0xF2)


