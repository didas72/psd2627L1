-----------------------------------------------------------------------------
-- Memory generated for 'Fully-Connected Layer with ReLU', PSD/DSD (2026/27)
-- Copyright (C) by Paulo Flores <paulo.flores@tecnico.ulisboa.pt>
-- Version: Ver. 1.0 2026-10-07
-- Command: dat2mem.pl -n -s 6
-- Seed: -s 6 ( dat2mem.pl -n -s 6 -s 6 )
-- Date: 2026-10-19T09:32:04 WEST
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


architecture GEN6 of IMemB is
  signal data : std_logic_vector(31 downto 0);
begin

  MEM_in : BRAM_SINGLE_MACRO
    generic map (          -- memory initialization
      BRAM_SIZE => "36Kb", -- Target BRAM, "18Kb" or "36Kb"
      DEVICE => "7SERIES", -- Target Device: "VIRTEX5", "7SERIES", "VIRTEX6, "SPARTAN6"
      WRITE_WIDTH => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      READ_WIDTH  => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      -- Initialize memory predefined data
      INIT_00 => X"E37D360007A7EAC712D770A27374FF9700FEE55FD98810195960D0F412563DC5",
      INIT_01 => X"CFF1C0ED63113DB58A95A0F0F00A4DFD424049EAE52DB736D1FEC78D404FE542",
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

end GEN6;

-- B[ 0][ 0]=  -59 (0xC5)
-- B[ 1][ 0]=   61 (0x3D)
-- B[ 2][ 0]=   86 (0x56)
-- B[ 3][ 0]=   18 (0x12)
-- B[ 4][ 0]=  -12 (0xF4)
-- B[ 5][ 0]=  -48 (0xD0)
-- B[ 6][ 0]=   96 (0x60)
-- B[ 7][ 0]=   89 (0x59)
-- B[ 8][ 0]=   25 (0x19)
-- B[ 9][ 0]=   16 (0x10)
-- B[10][ 0]= -120 (0x88)
-- B[11][ 0]=  -39 (0xD9)
-- B[12][ 0]=   95 (0x5F)
-- B[13][ 0]=  -27 (0xE5)
-- B[14][ 0]=   -2 (0xFE)
-- B[15][ 0]=    0 (0x00)
-- B[16][ 0]= -105 (0x97)
-- B[17][ 0]=   -1 (0xFF)
-- B[18][ 0]=  116 (0x74)
-- B[19][ 0]=  115 (0x73)
-- B[20][ 0]=  -94 (0xA2)
-- B[21][ 0]=  112 (0x70)
-- B[22][ 0]=  -41 (0xD7)
-- B[23][ 0]=   18 (0x12)
-- B[24][ 0]=  -57 (0xC7)
-- B[25][ 0]=  -22 (0xEA)
-- B[26][ 0]=  -89 (0xA7)
-- B[27][ 0]=    7 (0x07)
-- B[28][ 0]=    0 (0x00)
-- B[29][ 0]=   54 (0x36)
-- B[30][ 0]=  125 (0x7D)
-- B[31][ 0]=  -29 (0xE3)
-- B[32][ 0]=   66 (0x42)
-- B[33][ 0]=  -27 (0xE5)
-- B[34][ 0]=   79 (0x4F)
-- B[35][ 0]=   64 (0x40)
-- B[36][ 0]= -115 (0x8D)
-- B[37][ 0]=  -57 (0xC7)
-- B[38][ 0]=   -2 (0xFE)
-- B[39][ 0]=  -47 (0xD1)
-- B[40][ 0]=   54 (0x36)
-- B[41][ 0]=  -73 (0xB7)
-- B[42][ 0]=   45 (0x2D)
-- B[43][ 0]=  -27 (0xE5)
-- B[44][ 0]=  -22 (0xEA)
-- B[45][ 0]=   73 (0x49)
-- B[46][ 0]=   64 (0x40)
-- B[47][ 0]=   66 (0x42)
-- B[48][ 0]=   -3 (0xFD)
-- B[49][ 0]=   77 (0x4D)
-- B[50][ 0]=   10 (0x0A)
-- B[51][ 0]=  -16 (0xF0)
-- B[52][ 0]=  -16 (0xF0)
-- B[53][ 0]=  -96 (0xA0)
-- B[54][ 0]= -107 (0x95)
-- B[55][ 0]= -118 (0x8A)
-- B[56][ 0]=  -75 (0xB5)
-- B[57][ 0]=   61 (0x3D)
-- B[58][ 0]=   17 (0x11)
-- B[59][ 0]=   99 (0x63)
-- B[60][ 0]=  -19 (0xED)
-- B[61][ 0]=  -64 (0xC0)
-- B[62][ 0]=  -15 (0xF1)
-- B[63][ 0]=  -49 (0xCF)


