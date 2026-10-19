-----------------------------------------------------------------------------
-- Memory generated for 'Fully-Connected Layer with ReLU', PSD/DSD (2026/27)
-- Copyright (C) by Paulo Flores <paulo.flores@tecnico.ulisboa.pt>
-- Version: Ver. 1.0 2026-10-07
-- Command: dat2mem.pl -n -s 4
-- Seed: -s 4 ( dat2mem.pl -n -s 4 -s 4 )
-- Date: 2026-10-19T09:32:01 WEST
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


architecture GEN4 of OMemC is
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

end GEN4;

-- C[ 0][ 0]=    13948 ReLU(0x367C) =     13948
-- C[ 1][ 0]=    15532 ReLU(0x3CAC) =     15532
-- C[ 2][ 0]=    26750 ReLU(0x687E) =     26750
-- C[ 3][ 0]=    -9510 ReLU(0xDADA) =         0
-- C[ 4][ 0]=    23197 ReLU(0x5A9D) =     23197
-- C[ 5][ 0]=    22416 ReLU(0x5790) =     22416
-- C[ 6][ 0]=   -50179 ReLU(0x3BFD) =         0
-- C[ 7][ 0]=     1405 ReLU(0x057D) =      1405
-- C[ 8][ 0]=    12352 ReLU(0x3040) =     12352
-- C[ 9][ 0]=   -19108 ReLU(0xB55C) =         0
-- C[10][ 0]=   -16875 ReLU(0xBE15) =         0
-- C[11][ 0]=    18860 ReLU(0x49AC) =     18860
-- C[12][ 0]=   -14276 ReLU(0xC83C) =         0
-- C[13][ 0]=    36383 ReLU(0x8E1F) =     36383
-- C[14][ 0]=   -22964 ReLU(0xA64C) =         0
-- C[15][ 0]=   -24735 ReLU(0x9F61) =         0


