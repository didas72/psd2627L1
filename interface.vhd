----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 09/13/2016 07:01:44 PM
-- Design Name:
-- Module Name: interface - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity interface is
  port (
    clk : in  std_logic;  -- 100MHz clock
    btnC, btnU, btnL, btnR, btnD : in  std_logic;  -- buttons
    sw  : in  std_logic_vector(15 downto 0);  -- switches
    led : out std_logic_vector(15 downto 0);  -- leds
    an  : out std_logic_vector(3 downto 0);  -- display selectors
    seg : out std_logic_vector(6 downto 0);  -- display 7-segments
    dp  : out std_logic   -- display point
    );
end interface;

architecture Behavioral of interface is
  -- signal dd3, dd2, dd1, dd0 : std_logic_vector(6 downto 0);
  signal RESULT, REG1     : std_logic_vector(14 downto 0);
  signal overflow         : std_logic;
  signal dact          : std_logic_vector(3 downto 0);
  -- signal btnRinstr : std_logic_vector(3 downto 0);
  -- signal clk10hz, clk_disp : std_logic;
  signal btn, btnDeBnc : std_logic_vector(4 downto 0);
  -- registered input buttons
  signal btnCreg, btnUreg, btnLreg, btnRreg, btnDreg : std_logic;
  -- registered input switches
  signal sw_reg : std_logic_vector(15 downto 0);
  -- signal to choose the button to be used as input for the circuit 0 if BTNL, 1 if BTNU
  signal btn_sel : std_logic;
  -- signal to light the decimal point of the display when the circuit overflows
  signal dp_overflow : std_logic;

  component disp7
    port (
      digit3, digit2, digit1, digit0 : in  std_logic_vector(3 downto 0);
      dp3, dp2, dp1, dp0             : in  std_logic;
      clk                            : in  std_logic;
      dactive                        : in  std_logic_vector(3 downto 0);
      en_disp_l                      : out std_logic_vector(3 downto 0);
      segm_l                         : out std_logic_vector(6 downto 0);
      dp_l                           : out std_logic);
  end component;

  component debouncer
    generic (
      DEBNC_CLOCKS : integer;
      PORT_WIDTH   : integer);
    port (
      signal_i : in  std_logic_vector(4 downto 0);
      clk_i    : in  std_logic;
      signal_o : out std_logic_vector(4 downto 0));
  end component;

  component circuito
    port(
      clk     : in  std_logic;
      rst     : in  std_logic;
      equals  : in  std_logic;
      OPER    : in  std_logic_vector(1 downto 0);
      VALUE   : in  std_logic_vector(14 downto 0);
      overflow: out  std_logic;
      REG1    : out std_logic_vector(14 downto 0);
      RESULT  : out std_logic_vector(14 downto 0)
      );
  end component;

begin
  led <= sw_reg;

  dact <= "1111";

  inst_disp7 : disp7 port map(
    digit3    => RESULT(14 downto 12),
    digit2    => RESULT(11 downto 8 ),
    digit1    => RESULT(7  downto 4 ),
    digit0    => RESULT(3  downto 0 ),
    dp3       => dp_overflow, 
    dp2       => dp_overflow, 
    dp1       => dp_overflow, 
    dp0       => dp_overflow,
    clk       => clk,
    dactive   => dact,
    en_disp_l => an,
    segm_l    => seg,
    dp_l      => dp);

  inst_circuito : circuito port map(
    clk     => clk,
    rst     => btnCreg,
    equals  => btnRreg,
    OPER    => sw_reg(15) & btn_sel,
    VALUE   => sw_reg(14 downto 0),
    REG1    => REG1, 
    RESULT  => RESULT,
    overflow => overflow);

  -- Debounces btn signals
  btn <= btnC & btnU & btnL & btnR & btnD;
  Inst_btn_debounce : debouncer
    generic map (
      DEBNC_CLOCKS => (2**20),
      PORT_WIDTH   => 5)
    port map (
      signal_i => btn,
      clk_i    => clk,
      signal_o => btnDeBnc);

  process (clk)
  begin
    if rising_edge(clk) then
      btnCreg <= btnDeBnc(4);
      btnUreg <= btnDeBnc(3);
      btnLreg <= btnDeBnc(2);
      btnRreg <= btnDeBnc(1);
      btnDreg <= btnDeBnc(0);
      sw_reg  <= sw;

      if btnLreg = '1' then
        btn_sel <= '0';
      elsif btnUreg = '1' then
        btn_sel <= '1';
      end if;
      if overflow = '1' then
        dp_overflow <= '1';
      else
        dp_overflow <= '0';
      end if;
    end if;
  end process;

end Behavioral;
