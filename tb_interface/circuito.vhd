library ieee;
use ieee.std_logic_1164.all;

entity circuito is
  port(
    clk      : in  std_logic;
    rst      : in  std_logic;
    equals   : in  std_logic;
    OPER     : in  std_logic_vector(1 downto 0);
    VALUE    : in  std_logic_vector(14 downto 0);
    overflow : out std_logic;
    REG1     : out std_logic_vector(14 downto 0);
    RESULT   : out std_logic_vector(14 downto 0)
  );
end circuito;


architecture stub of circuito is
begin
  -- Mantém todas as saídas desativadas/zeradas permanentemente
  overflow <= '0';
  REG1     <= (others => '0');
  RESULT   <= (others => '0');
end stub;