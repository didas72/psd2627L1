library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;

entity mux is
    generic (N : integer := 8); -- mux input width
    port(
        A : in std_logic_vector(N-1 downto 0);
        B : in std_logic_vector(N-1 downto 0);
        sel : in std_logic;
        Y : out std_logic_vector(N-1 downto 0)
    );
end mux;

architecture archi of mux is 
begin
    Y <= A when (sel="0")
        else B;
end archi;