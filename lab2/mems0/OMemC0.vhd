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


entity OMemC is
  port (
    clk     : in  std_logic;
    addr    : in  std_logic_vector(9 downto 0);
    we      : in  std_logic;
    dataIN  : in  std_logic_vector(31 downto 0);
    dataOUT : out std_logic_vector(31 downto 0)
    );
end OMemC;


architecture GEN0 of OMemC is
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

end GEN0;

-- C[ 0][ 0]=   -42066 ReLU(0x5BAE) =         0
-- C[ 1][ 0]=    55270 ReLU(0xD7E6) =     55270
-- C[ 2][ 0]=     -830 ReLU(0xFCC2) =         0
-- C[ 3][ 0]=   -32324 ReLU(0x81BC) =         0
-- C[ 4][ 0]=   -26804 ReLU(0x974C) =         0
-- C[ 5][ 0]=   -61449 ReLU(0x0FF7) =         0
-- C[ 6][ 0]=   -22193 ReLU(0xA94F) =         0
-- C[ 7][ 0]=    10832 ReLU(0x2A50) =     10832
-- C[ 8][ 0]=   -74408 ReLU(0xDD58) =         0
-- C[ 9][ 0]=   -20816 ReLU(0xAEB0) =         0
-- C[10][ 0]=   -35892 ReLU(0x73CC) =         0
-- C[11][ 0]=    23705 ReLU(0x5C99) =     23705
-- C[12][ 0]=   -38278 ReLU(0x6A7A) =         0
-- C[13][ 0]=    -3712 ReLU(0xF180) =         0
-- C[14][ 0]=    82971 ReLU(0x441B) =     17435
-- C[15][ 0]=    35657 ReLU(0x8B49) =     35657


