-----------------------------------------------------------------------------
-- Memory generated for 'Fully-Connected Layer with ReLU', PSD/DSD (2026/27)
-- Copyright (C) by Paulo Flores <paulo.flores@tecnico.ulisboa.pt>
-- Version: Ver. 1.0 2026-10-07
-- Command: dat2mem.pl -n -s 8
-- Seed: -s 8 ( dat2mem.pl -n -s 8 -s 8 )
-- Date: 2026-10-19T09:32:07 WEST
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


architecture GEN8 of IMemB is
  signal data : std_logic_vector(31 downto 0);
begin

  MEM_in : BRAM_SINGLE_MACRO
    generic map (          -- memory initialization
      BRAM_SIZE => "36Kb", -- Target BRAM, "18Kb" or "36Kb"
      DEVICE => "7SERIES", -- Target Device: "VIRTEX5", "7SERIES", "VIRTEX6, "SPARTAN6"
      WRITE_WIDTH => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      READ_WIDTH  => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      -- Initialize memory predefined data
      INIT_00 => X"52F273065B4CD94514F04FECE43B04526509204D1ED2C932C3EBCDA61621D957",
      INIT_01 => X"4344F0FE65E8FF000506E442F3251C023811D3FA58E5AEE419D0F0070D280F0C",
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

end GEN8;

-- B[ 0][ 0]=   87 (0x57)
-- B[ 1][ 0]=  -39 (0xD9)
-- B[ 2][ 0]=   33 (0x21)
-- B[ 3][ 0]=   22 (0x16)
-- B[ 4][ 0]=  -90 (0xA6)
-- B[ 5][ 0]=  -51 (0xCD)
-- B[ 6][ 0]=  -21 (0xEB)
-- B[ 7][ 0]=  -61 (0xC3)
-- B[ 8][ 0]=   50 (0x32)
-- B[ 9][ 0]=  -55 (0xC9)
-- B[10][ 0]=  -46 (0xD2)
-- B[11][ 0]=   30 (0x1E)
-- B[12][ 0]=   77 (0x4D)
-- B[13][ 0]=   32 (0x20)
-- B[14][ 0]=    9 (0x09)
-- B[15][ 0]=  101 (0x65)
-- B[16][ 0]=   82 (0x52)
-- B[17][ 0]=    4 (0x04)
-- B[18][ 0]=   59 (0x3B)
-- B[19][ 0]=  -28 (0xE4)
-- B[20][ 0]=  -20 (0xEC)
-- B[21][ 0]=   79 (0x4F)
-- B[22][ 0]=  -16 (0xF0)
-- B[23][ 0]=   20 (0x14)
-- B[24][ 0]=   69 (0x45)
-- B[25][ 0]=  -39 (0xD9)
-- B[26][ 0]=   76 (0x4C)
-- B[27][ 0]=   91 (0x5B)
-- B[28][ 0]=    6 (0x06)
-- B[29][ 0]=  115 (0x73)
-- B[30][ 0]=  -14 (0xF2)
-- B[31][ 0]=   82 (0x52)
-- B[32][ 0]=   12 (0x0C)
-- B[33][ 0]=   15 (0x0F)
-- B[34][ 0]=   40 (0x28)
-- B[35][ 0]=   13 (0x0D)
-- B[36][ 0]=    7 (0x07)
-- B[37][ 0]=  -16 (0xF0)
-- B[38][ 0]=  -48 (0xD0)
-- B[39][ 0]=   25 (0x19)
-- B[40][ 0]=  -28 (0xE4)
-- B[41][ 0]=  -82 (0xAE)
-- B[42][ 0]=  -27 (0xE5)
-- B[43][ 0]=   88 (0x58)
-- B[44][ 0]=   -6 (0xFA)
-- B[45][ 0]=  -45 (0xD3)
-- B[46][ 0]=   17 (0x11)
-- B[47][ 0]=   56 (0x38)
-- B[48][ 0]=    2 (0x02)
-- B[49][ 0]=   28 (0x1C)
-- B[50][ 0]=   37 (0x25)
-- B[51][ 0]=  -13 (0xF3)
-- B[52][ 0]=   66 (0x42)
-- B[53][ 0]=  -28 (0xE4)
-- B[54][ 0]=    6 (0x06)
-- B[55][ 0]=    5 (0x05)
-- B[56][ 0]=    0 (0x00)
-- B[57][ 0]=   -1 (0xFF)
-- B[58][ 0]=  -24 (0xE8)
-- B[59][ 0]=  101 (0x65)
-- B[60][ 0]=   -2 (0xFE)
-- B[61][ 0]=  -16 (0xF0)
-- B[62][ 0]=   68 (0x44)
-- B[63][ 0]=   67 (0x43)


