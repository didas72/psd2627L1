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


entity OMemC is
  port (
    clk     : in  std_logic;
    addr    : in  std_logic_vector(9 downto 0);
    we      : in  std_logic;
    dataIN  : in  std_logic_vector(31 downto 0);
    dataOUT : out std_logic_vector(31 downto 0)
    );
end OMemC;


architecture GEN1 of OMemC is
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

end GEN1;

-- C[ 0][ 0]=     8810 ReLU(0x226A) =      8810
-- C[ 1][ 0]=   -10999 ReLU(0xD509) =         0
-- C[ 2][ 0]=   -20437 ReLU(0xB02B) =         0
-- C[ 3][ 0]=   -38287 ReLU(0x6A71) =         0
-- C[ 4][ 0]=    48725 ReLU(0xBE55) =     48725
-- C[ 5][ 0]=    61669 ReLU(0xF0E5) =     61669
-- C[ 6][ 0]=    27369 ReLU(0x6AE9) =     27369
-- C[ 7][ 0]=   -17038 ReLU(0xBD72) =         0
-- C[ 8][ 0]=    17624 ReLU(0x44D8) =     17624
-- C[ 9][ 0]=   -54951 ReLU(0x2959) =         0
-- C[10][ 0]=    10844 ReLU(0x2A5C) =     10844
-- C[11][ 0]=     5730 ReLU(0x1662) =      5730
-- C[12][ 0]=    46554 ReLU(0xB5DA) =     46554
-- C[13][ 0]=    28193 ReLU(0x6E21) =     28193
-- C[14][ 0]=    26695 ReLU(0x6847) =     26695
-- C[15][ 0]=    -3653 ReLU(0xF1BB) =         0


