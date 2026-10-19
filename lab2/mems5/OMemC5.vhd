-----------------------------------------------------------------------------
-- Memory generated for 'Fully-Connected Layer with ReLU', PSD/DSD (2026/27)
-- Copyright (C) by Paulo Flores <paulo.flores@tecnico.ulisboa.pt>
-- Version: Ver. 1.0 2026-10-07
-- Command: dat2mem.pl -n -s 5
-- Seed: -s 5 ( dat2mem.pl -n -s 5 -s 5 )
-- Date: 2026-10-19T09:32:03 WEST
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


architecture GEN5 of OMemC is
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

end GEN5;

-- C[ 0][ 0]=   -40615 ReLU(0x6159) =         0
-- C[ 1][ 0]=     2802 ReLU(0x0AF2) =      2802
-- C[ 2][ 0]=    30612 ReLU(0x7794) =     30612
-- C[ 3][ 0]=   -26060 ReLU(0x9A34) =         0
-- C[ 4][ 0]=   -50699 ReLU(0x39F5) =         0
-- C[ 5][ 0]=    55979 ReLU(0xDAAB) =     55979
-- C[ 6][ 0]=    12261 ReLU(0x2FE5) =     12261
-- C[ 7][ 0]=    49076 ReLU(0xBFB4) =     49076
-- C[ 8][ 0]=     1022 ReLU(0x03FE) =      1022
-- C[ 9][ 0]=   -29925 ReLU(0x8B1B) =         0
-- C[10][ 0]=   -33960 ReLU(0x7B58) =         0
-- C[11][ 0]=    10018 ReLU(0x2722) =     10018
-- C[12][ 0]=      851 ReLU(0x0353) =       851
-- C[13][ 0]=   -43115 ReLU(0x5795) =         0
-- C[14][ 0]=    46837 ReLU(0xB6F5) =     46837
-- C[15][ 0]=    -6339 ReLU(0xE73D) =         0


