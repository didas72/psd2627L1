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


entity OMemC is
  port (
    clk     : in  std_logic;
    addr    : in  std_logic_vector(9 downto 0);
    we      : in  std_logic;
    dataIN  : in  std_logic_vector(31 downto 0);
    dataOUT : out std_logic_vector(31 downto 0)
    );
end OMemC;


architecture GEN2 of OMemC is
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

end GEN2;

-- C[ 0][ 0]=      423 ReLU(0x01A7) =       423
-- C[ 1][ 0]=   -20591 ReLU(0xAF91) =         0
-- C[ 2][ 0]=   -11880 ReLU(0xD198) =         0
-- C[ 3][ 0]=    50298 ReLU(0xC47A) =     50298
-- C[ 4][ 0]=   -19643 ReLU(0xB345) =         0
-- C[ 5][ 0]=   -23988 ReLU(0xA24C) =         0
-- C[ 6][ 0]=    59133 ReLU(0xE6FD) =     59133
-- C[ 7][ 0]=    16846 ReLU(0x41CE) =     16846
-- C[ 8][ 0]=   -32772 ReLU(0x7FFC) =         0
-- C[ 9][ 0]=   -30312 ReLU(0x8998) =         0
-- C[10][ 0]=   -21576 ReLU(0xABB8) =         0
-- C[11][ 0]=    -1772 ReLU(0xF914) =         0
-- C[12][ 0]=   -32074 ReLU(0x82B6) =         0
-- C[13][ 0]=     7406 ReLU(0x1CEE) =      7406
-- C[14][ 0]=   -15212 ReLU(0xC494) =         0
-- C[15][ 0]=   -49188 ReLU(0x3FDC) =         0


