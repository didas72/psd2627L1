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
      INIT_00 => X"EF63FFEFF1FFCA120FD15637061F022FB1E9EFEDF3AC60B0D9BE2A26F68C7A1B",
      INIT_01 => X"7A124EBAA5FD6DD767402BFAE716DF91A3511945999BA7FBEC73D239253F401D",
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


