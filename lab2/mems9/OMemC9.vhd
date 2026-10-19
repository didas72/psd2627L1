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


entity OMemC is
  port (
    clk     : in  std_logic;
    addr    : in  std_logic_vector(9 downto 0);
    we      : in  std_logic;
    dataIN  : in  std_logic_vector(31 downto 0);
    dataOUT : out std_logic_vector(31 downto 0)
    );
end OMemC;


architecture GEN9 of OMemC is
  signal we_vec : std_logic_vector(3 downto 0);
begin

  MEM_in : BRAM_SINGLE_MACRO
    generic map (          -- memory initialization
      BRAM_SIZE => "36Kb", -- Target BRAM, "18Kb" or "36Kb"
      DEVICE => "7SERIES", -- Target Device: "VIRTEX5", "7SERIES", "VIRTEX6, "SPARTAN6"
      WRITE_WIDTH => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      READ_WIDTH  => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      -- Initialize memory predefined data
      INIT_00 => X"000000000000000000000000000000000F0E0D0C0B0A09080706050403020100",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      CLK   => clk,         -- Clock
      ADDR  => addr,        -- 10-bit Address Input, width defined by read/write port depth
      DI    => dataIN,      -- 32-bit Data Input, width defined by WRITE_WIDTH parameter
      DO    => dataOUT,     -- 32-bit Data Output, width defined by READ_WIDTH parameter
      EN    => '1',         -- 1-bit RAM Enable Input
      WE    => we_vec,      -- Write Enable Input, width defined by write port depth
      REGCE => '0',         -- 1-bit Input, output register enable
      RST   => '0'          -- 1-bit Input reset
      );

  we_vec <= we & we & we & we;

end GEN9;

-- C[ 0][ 0]=    44323 ReLU(0xAD23) =     44323
-- C[ 1][ 0]=   -25962 ReLU(0x9A96) =         0
-- C[ 2][ 0]=    15818 ReLU(0x3DCA) =     15818
-- C[ 3][ 0]=    40755 ReLU(0x9F33) =     40755
-- C[ 4][ 0]=    19152 ReLU(0x4AD0) =     19152
-- C[ 5][ 0]=   -18959 ReLU(0xB5F1) =         0
-- C[ 6][ 0]=     7383 ReLU(0x1CD7) =      7383
-- C[ 7][ 0]=     5046 ReLU(0x13B6) =      5046
-- C[ 8][ 0]=    12140 ReLU(0x2F6C) =     12140
-- C[ 9][ 0]=     9869 ReLU(0x268D) =      9869
-- C[10][ 0]=   -26242 ReLU(0x997E) =         0
-- C[11][ 0]=    24945 ReLU(0x6171) =     24945
-- C[12][ 0]=    67616 ReLU(0x0820) =      2080
-- C[13][ 0]=   -22331 ReLU(0xA8C5) =         0
-- C[14][ 0]=   -18990 ReLU(0xB5D2) =         0
-- C[15][ 0]=     7744 ReLU(0x1E40) =      7744


