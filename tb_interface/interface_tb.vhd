library ieee;
use ieee.std_logic_1164.all;

entity interface_tb is
end interface_tb;

architecture behavior of interface_tb is


  component interface
    port (
      clk                          : in  std_logic;
      btnC, btnU, btnL, btnR, btnD : in  std_logic;
      sw                           : in  std_logic_vector(15 downto 0);
      led                          : out std_logic_vector(15 downto 0);
      an                           : out std_logic_vector(3 downto 0);
      seg                          : out std_logic_vector(6 downto 0);
      dp                           : out std_logic
    );
  end component;

  signal clk  : std_logic := '0';
  signal btnC : std_logic := '0';
  signal btnU : std_logic := '0';
  signal btnL : std_logic := '0';
  signal btnR : std_logic := '0';
  signal btnD : std_logic := '0';
  signal sw   : std_logic_vector(15 downto 0) := (others => '0');


  signal led : std_logic_vector(15 downto 0);
  signal an  : std_logic_vector(3 downto 0);
  signal seg : std_logic_vector(6 downto 0);
  signal dp  : std_logic;

  constant clk_period : time := 10 ns;

begin

  
  uut: interface port map (
    clk  => clk,
    btnC => btnC,
    btnU => btnU,
    btnL => btnL,
    btnR => btnR,
    btnD => btnD,
    sw   => sw,
    led  => led,
    an   => an,
    seg  => seg,
    dp   => dp
  );


  clk <= not clk after clk_period/2;


  stim_proc: process
  begin
    wait for 100 ns;


    sw(15) <= '0';
    btnL   <= '1';
    wait for 100 ns;
    btnL   <= '0';
    wait for 200 ns;

    sw(15) <= '1';
    wait for 200 ns;

    btnU <= '1';
    wait for 100 ns;
    btnU <= '0';
    wait for 200 ns;

    sw(15) <= '0';
    wait for 100 ns;

    wait for 100 ns;
    btnR <= '1';
    wait for 100 ns;
    btnR <= '0';

    wait for 200 ns;
    


    wait;
  end process;

end behavior;