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


entity OMemC is
  port (
    clk     : in  std_logic;
    addr    : in  std_logic_vector(9 downto 0);
    we      : in  std_logic;
    dataIN  : in  std_logic_vector(31 downto 0);
    dataOUT : out std_logic_vector(31 downto 0)
    );
end OMemC;


architecture GEN8 of OMemC is
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

end GEN8;

-- C[ 0][ 0]=   -17511 ReLU(0xBB99) =         0
-- C[ 1][ 0]=     6324 ReLU(0x18B4) =      6324
-- C[ 2][ 0]=    29714 ReLU(0x7412) =     29714
-- C[ 3][ 0]=   -79074 ReLU(0xCB1E) =         0
-- C[ 4][ 0]=    16394 ReLU(0x400A) =     16394
-- C[ 5][ 0]=   -32075 ReLU(0x82B5) =         0
-- C[ 6][ 0]=    52839 ReLU(0xCE67) =     52839
-- C[ 7][ 0]=   -27476 ReLU(0x94AC) =         0
-- C[ 8][ 0]=   -41199 ReLU(0x5F11) =         0
-- C[ 9][ 0]=      500 ReLU(0x01F4) =       500
-- C[10][ 0]=    19725 ReLU(0x4D0D) =     19725
-- C[11][ 0]=     2040 ReLU(0x07F8) =      2040
-- C[12][ 0]=    14523 ReLU(0x38BB) =     14523
-- C[13][ 0]=    -6407 ReLU(0xE6F9) =         0
-- C[14][ 0]=    41604 ReLU(0xA284) =     41604
-- C[15][ 0]=     4776 ReLU(0x12A8) =      4776


