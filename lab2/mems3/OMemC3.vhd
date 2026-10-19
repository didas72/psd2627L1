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


entity OMemC is
  port (
    clk     : in  std_logic;
    addr    : in  std_logic_vector(9 downto 0);
    we      : in  std_logic;
    dataIN  : in  std_logic_vector(31 downto 0);
    dataOUT : out std_logic_vector(31 downto 0)
    );
end OMemC;


architecture GEN3 of OMemC is
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

end GEN3;

-- C[ 0][ 0]=    -5445 ReLU(0xEABB) =         0
-- C[ 1][ 0]=    30465 ReLU(0x7701) =     30465
-- C[ 2][ 0]=   -34714 ReLU(0x7866) =         0
-- C[ 3][ 0]=     7159 ReLU(0x1BF7) =      7159
-- C[ 4][ 0]=     1103 ReLU(0x044F) =      1103
-- C[ 5][ 0]=     6666 ReLU(0x1A0A) =      6666
-- C[ 6][ 0]=    -5314 ReLU(0xEB3E) =         0
-- C[ 7][ 0]=    13468 ReLU(0x349C) =     13468
-- C[ 8][ 0]=   -43911 ReLU(0x5479) =         0
-- C[ 9][ 0]=   -40112 ReLU(0x6350) =         0
-- C[10][ 0]=   -68077 ReLU(0xF613) =         0
-- C[11][ 0]=   -24158 ReLU(0xA1A2) =         0
-- C[12][ 0]=    51436 ReLU(0xC8EC) =     51436
-- C[13][ 0]=    55398 ReLU(0xD866) =     55398
-- C[14][ 0]=   -42984 ReLU(0x5818) =         0
-- C[15][ 0]=     5627 ReLU(0x15FB) =      5627


