library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;

entity alu is
    generic (N : integer := 8); -- alu operand width
    port (
        OPERAND1, OPERAND2 : in std_logic_vector(N-1 downto 0);  -- operands
        OPER : in std_logic_vector(1 downto 0);                  -- operation
        RESULT : out std_logic_vector(N-1 downto 0);             -- operation's result
        ofl : out std_logic                                      -- overflow flag
    );
end alu;

architecture archi of alu is 
    signal sign_bit, sum_ofl, mul_ofl: std_logic;
    signal res_sum, res_mul, res_or, res_shift : std_logic_vector(N-1 downto 0);
begin
    -- SUM
    res_sum <= OPERAND1 + OPERAND2;
    sum_ofl <=
    -- MUL
    res_mul <= OPERAND1 * OPERAND2;
    mul_ofl <=
    -- OR
    res_or <= OPERAND1 or OPERAND2;
    -- SRA
    sign_bit <= OPERAND1(OPERAND1'LEFT); -- using 'LEFT gets the MSB of OPERAND1 regardless of its size
    res_shift <= sign_bit & OPERAND1(OPERAND1'LEFT - 1 downto 1); -- "OPERAND1'LEFT - 1" = Second MSB

    -- Set RESULT according to chosen operation
    
    
end archi;