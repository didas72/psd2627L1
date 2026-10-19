-----------------------------------------------------------------------------
-- Memory generated for 'Fully-Connected Layer with ReLU', PSD/DSD (2026/27)
-- Copyright (C) by Paulo Flores <paulo.flores@tecnico.ulisboa.pt>
-- Version: Ver. 1.0 2026-10-07
-- Command: dat2mem.pl -n -s 1
-- Seed: -s 1 ( dat2mem.pl -n -s 1 -s 1 )
-- Date: 2026-10-19T09:31:57 WEST
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


architecture GEN1 of IMemB is
  signal data : std_logic_vector(31 downto 0);
begin

  MEM_in : BRAM_SINGLE_MACRO
    generic map (          -- memory initialization
      BRAM_SIZE => "36Kb", -- Target BRAM, "18Kb" or "36Kb"
      DEVICE => "7SERIES", -- Target Device: "VIRTEX5", "7SERIES", "VIRTEX6, "SPARTAN6"
      WRITE_WIDTH => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      READ_WIDTH  => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      -- Initialize memory predefined data
      INIT_00 => X"08E82032C83BED18F0B507EDF2FE822343AD6E366FD082A45A04970CB61930CD",
      INIT_01 => X"FCF6883DA5FFF1BD6A77F6ADE9FEF9311AB8B444FB1B533822F41BFE3F138677",
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

end GEN1;

-- B[ 0][ 0]=  -51 (0xCD)
-- B[ 1][ 0]=   48 (0x30)
-- B[ 2][ 0]=   25 (0x19)
-- B[ 3][ 0]=  -74 (0xB6)
-- B[ 4][ 0]=   12 (0x0C)
-- B[ 5][ 0]= -105 (0x97)
-- B[ 6][ 0]=    4 (0x04)
-- B[ 7][ 0]=   90 (0x5A)
-- B[ 8][ 0]=  -92 (0xA4)
-- B[ 9][ 0]= -126 (0x82)
-- B[10][ 0]=  -48 (0xD0)
-- B[11][ 0]=  111 (0x6F)
-- B[12][ 0]=   54 (0x36)
-- B[13][ 0]=  110 (0x6E)
-- B[14][ 0]=  -83 (0xAD)
-- B[15][ 0]=   67 (0x43)
-- B[16][ 0]=   35 (0x23)
-- B[17][ 0]= -126 (0x82)
-- B[18][ 0]=   -2 (0xFE)
-- B[19][ 0]=  -14 (0xF2)
-- B[20][ 0]=  -19 (0xED)
-- B[21][ 0]=    7 (0x07)
-- B[22][ 0]=  -75 (0xB5)
-- B[23][ 0]=  -16 (0xF0)
-- B[24][ 0]=   24 (0x18)
-- B[25][ 0]=  -19 (0xED)
-- B[26][ 0]=   59 (0x3B)
-- B[27][ 0]=  -56 (0xC8)
-- B[28][ 0]=   50 (0x32)
-- B[29][ 0]=   32 (0x20)
-- B[30][ 0]=  -24 (0xE8)
-- B[31][ 0]=    8 (0x08)
-- B[32][ 0]=  119 (0x77)
-- B[33][ 0]= -122 (0x86)
-- B[34][ 0]=   19 (0x13)
-- B[35][ 0]=   63 (0x3F)
-- B[36][ 0]=   -2 (0xFE)
-- B[37][ 0]=   27 (0x1B)
-- B[38][ 0]=  -12 (0xF4)
-- B[39][ 0]=   34 (0x22)
-- B[40][ 0]=   56 (0x38)
-- B[41][ 0]=   83 (0x53)
-- B[42][ 0]=   27 (0x1B)
-- B[43][ 0]=   -5 (0xFB)
-- B[44][ 0]=   68 (0x44)
-- B[45][ 0]=  -76 (0xB4)
-- B[46][ 0]=  -72 (0xB8)
-- B[47][ 0]=   26 (0x1A)
-- B[48][ 0]=   49 (0x31)
-- B[49][ 0]=   -7 (0xF9)
-- B[50][ 0]=   -2 (0xFE)
-- B[51][ 0]=  -23 (0xE9)
-- B[52][ 0]=  -83 (0xAD)
-- B[53][ 0]=  -10 (0xF6)
-- B[54][ 0]=  119 (0x77)
-- B[55][ 0]=  106 (0x6A)
-- B[56][ 0]=  -67 (0xBD)
-- B[57][ 0]=  -15 (0xF1)
-- B[58][ 0]=   -1 (0xFF)
-- B[59][ 0]=  -91 (0xA5)
-- B[60][ 0]=   61 (0x3D)
-- B[61][ 0]= -120 (0x88)
-- B[62][ 0]=  -10 (0xF6)
-- B[63][ 0]=   -4 (0xFC)


