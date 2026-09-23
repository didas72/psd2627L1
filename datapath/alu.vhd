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
    if OPERAND1(OPERAND1'LEFT) xor OPERAND2(OPERAND2'LEFT) then -- if the operand's signs are different, no overflow can occur
        sum_ofl <= 0;
    elsif RESULT(RESULT'LEFT) xor OPERAND1(OPERAND1'LEFT) then -- if signs are the same but the result's sign is different
        sum_ofl <= 1; 
    else
        sum_ofl <= 0;   -- signs are the same and the result's sign is also the same
    end if;
    -- MUL
    res_mul <= OPERAND1 * OPERAND2;
    mul_ofl <=
    -- OR
    res_or <= OPERAND1 or OPERAND2;
    -- SRA
    sign_bit <= OPERAND1(OPERAND1'LEFT); -- using 'LEFT gets the MSB of OPERAND1 regardless of its size
    res_shift <= sign_bit & OPERAND1(OPERAND1'LEFT - 1 downto 1); -- "OPERAND1'LEFT - 1" = Second MSB

    -- Set RESULT according to chosen operation
    case OPER is
        when 0 =>
            RESULT <= res_sum(N-1 downto 0);
            ofl <= sum_ofl;
        when 1 =>
            RESULT <= res_mul;
            ofl <= mul_ofl;
        when 2 =>
            RESULT <= res_or;
            ofl = 0;
        when others =>
            RESULT <= res_shift;
            ofl = 0;

    
    --with OPER select
    --    RESULT <= res_sum when 0,
    --              res_mul when 1,
    --              res_or when 2,
    --              res_shift when others;
    
    --with OPER select     
    --    ofl <= sum_ofl when 0,
    --           mul_ofl when 1,
    --           0 when others;

    
end archi;