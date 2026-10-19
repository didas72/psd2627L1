-----------------------------------------------------------------------------
-- Memory generated for 'Fully-Connected Layer with ReLU', PSD/DSD (2026/27)
-- Copyright (C) by Paulo Flores <paulo.flores@tecnico.ulisboa.pt>
-- Version: Ver. 1.0 2026-10-07
-- Command: dat2mem.pl -n -s 6
-- Seed: -s 6 ( dat2mem.pl -n -s 6 -s 6 )
-- Date: 2026-10-19T09:32:04 WEST
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


architecture GEN6 of OMemC is
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

end GEN6;

-- C[ 0][ 0]=    23062 ReLU(0x5A16) =     23062
-- C[ 1][ 0]=    -8104 ReLU(0xE058) =         0
-- C[ 2][ 0]=   -45459 ReLU(0x4E6D) =         0
-- C[ 3][ 0]=    53044 ReLU(0xCF34) =     53044
-- C[ 4][ 0]=   -27715 ReLU(0x93BD) =         0
-- C[ 5][ 0]=   -15803 ReLU(0xC245) =         0
-- C[ 6][ 0]=   -10973 ReLU(0xD523) =         0
-- C[ 7][ 0]=    24838 ReLU(0x6106) =     24838
-- C[ 8][ 0]=    14961 ReLU(0x3A71) =     14961
-- C[ 9][ 0]=    41601 ReLU(0xA281) =     41601
-- C[10][ 0]=    -7880 ReLU(0xE138) =         0
-- C[11][ 0]=    18259 ReLU(0x4753) =     18259
-- C[12][ 0]=   -28798 ReLU(0x8F82) =         0
-- C[13][ 0]=   -25943 ReLU(0x9AA9) =         0
-- C[14][ 0]=    22753 ReLU(0x58E1) =     22753
-- C[15][ 0]=    18349 ReLU(0x47AD) =     18349


