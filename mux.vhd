library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;

entity mux is
    generic (N : integer := 8); -- mux input width
    port(
        a : in std_logic_vector(N-1 downto 0);
        b : in std_logic_vector(N-1 downto 0);
        sel : in std_logic;
        y : out std_logic_vector(N-1 downto 0)
    );
end mux;

architecture archi of mux is 
begin
    y <= a when (s="0")
        else b;
end archi;