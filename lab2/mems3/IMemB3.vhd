-----------------------------------------------------------------------------
-- Memory generated for 'Fully-Connected Layer with ReLU', PSD/DSD (2026/27)
-- Copyright (C) by Paulo Flores <paulo.flores@tecnico.ulisboa.pt>
-- Version: Ver. 1.0 2026-10-07
-- Command: dat2mem.pl -n -s 3
-- Seed: -s 3 ( dat2mem.pl -n -s 3 -s 3 )
-- Date: 2026-10-19T09:31:59 WEST
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


architecture GEN3 of IMemB is
  signal data : std_logic_vector(31 downto 0);
begin

  MEM_in : BRAM_SINGLE_MACRO
    generic map (          -- memory initialization
      BRAM_SIZE => "36Kb", -- Target BRAM, "18Kb" or "36Kb"
      DEVICE => "7SERIES", -- Target Device: "VIRTEX5", "7SERIES", "VIRTEX6, "SPARTAN6"
      WRITE_WIDTH => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      READ_WIDTH  => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      -- Initialize memory predefined data
      INIT_00 => X"06F35CC70C2D4FDAF083E3B536CA00F4D9CBEAC7339AC88B3FF194D9F2E5E550",
      INIT_01 => X"1642C8ADA2095507EF693B05EBB0AA360F08302D41F638E2F3BAF316F3396DAD",
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

end GEN3;

-- B[ 0][ 0]=   80 (0x50)
-- B[ 1][ 0]=  -27 (0xE5)
-- B[ 2][ 0]=  -27 (0xE5)
-- B[ 3][ 0]=  -14 (0xF2)
-- B[ 4][ 0]=  -39 (0xD9)
-- B[ 5][ 0]= -108 (0x94)
-- B[ 6][ 0]=  -15 (0xF1)
-- B[ 7][ 0]=   63 (0x3F)
-- B[ 8][ 0]= -117 (0x8B)
-- B[ 9][ 0]=  -56 (0xC8)
-- B[10][ 0]= -102 (0x9A)
-- B[11][ 0]=   51 (0x33)
-- B[12][ 0]=  -57 (0xC7)
-- B[13][ 0]=  -22 (0xEA)
-- B[14][ 0]=  -53 (0xCB)
-- B[15][ 0]=  -39 (0xD9)
-- B[16][ 0]=  -12 (0xF4)
-- B[17][ 0]=    0 (0x00)
-- B[18][ 0]=  -54 (0xCA)
-- B[19][ 0]=   54 (0x36)
-- B[20][ 0]=  -75 (0xB5)
-- B[21][ 0]=  -29 (0xE3)
-- B[22][ 0]= -125 (0x83)
-- B[23][ 0]=  -16 (0xF0)
-- B[24][ 0]=  -38 (0xDA)
-- B[25][ 0]=   79 (0x4F)
-- B[26][ 0]=   45 (0x2D)
-- B[27][ 0]=   12 (0x0C)
-- B[28][ 0]=  -57 (0xC7)
-- B[29][ 0]=   92 (0x5C)
-- B[30][ 0]=  -13 (0xF3)
-- B[31][ 0]=    6 (0x06)
-- B[32][ 0]=  -83 (0xAD)
-- B[33][ 0]=  109 (0x6D)
-- B[34][ 0]=   57 (0x39)
-- B[35][ 0]=  -13 (0xF3)
-- B[36][ 0]=   22 (0x16)
-- B[37][ 0]=  -13 (0xF3)
-- B[38][ 0]=  -70 (0xBA)
-- B[39][ 0]=  -13 (0xF3)
-- B[40][ 0]=  -30 (0xE2)
-- B[41][ 0]=   56 (0x38)
-- B[42][ 0]=  -10 (0xF6)
-- B[43][ 0]=   65 (0x41)
-- B[44][ 0]=   45 (0x2D)
-- B[45][ 0]=   48 (0x30)
-- B[46][ 0]=    8 (0x08)
-- B[47][ 0]=   15 (0x0F)
-- B[48][ 0]=   54 (0x36)
-- B[49][ 0]=  -86 (0xAA)
-- B[50][ 0]=  -80 (0xB0)
-- B[51][ 0]=  -21 (0xEB)
-- B[52][ 0]=    5 (0x05)
-- B[53][ 0]=   59 (0x3B)
-- B[54][ 0]=  105 (0x69)
-- B[55][ 0]=  -17 (0xEF)
-- B[56][ 0]=    7 (0x07)
-- B[57][ 0]=   85 (0x55)
-- B[58][ 0]=    9 (0x09)
-- B[59][ 0]=  -94 (0xA2)
-- B[60][ 0]=  -83 (0xAD)
-- B[61][ 0]=  -56 (0xC8)
-- B[62][ 0]=   66 (0x42)
-- B[63][ 0]=   22 (0x16)


