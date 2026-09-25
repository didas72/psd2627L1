library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;

entity alu is
    generic (N : integer := 15); -- alu operand width
    port (
        OPERAND1, OPERAND2 : in std_logic_vector(N-1 downto 0);  -- operands
        OPER : in std_logic_vector(1 downto 0);                  -- operation
        ALU_RES : out std_logic_vector(N-1 downto 0);             -- operation's result
        ofl : out std_logic                                      -- overflow flag
    );
end alu;

architecture archi of alu is 
    signal sign_bit, sum_ofl, mul_ofl : std_logic;
    signal res_sum, res_or, res_shift : std_logic_vector(N-1 downto 0);
    signal res_mul : std_logic_vector(2*N-1 downto 0);
    signal zeros_vector, ones_vector : std_logic_vector(N-1 downto 0);
begin
    zeros_vector <= (others => '0');
    ones_vector <= (others => '1');

    -- SUM
    res_sum <= OPERAND1 + OPERAND2;
    if OPERAND1(OPERAND1'LEFT) xor OPERAND2(OPERAND2'LEFT) then -- if the operand's signs are different, no overflow can occur
        sum_ofl <= '0';
    elsif ALU_RES(ALU_RES'LEFT) xor OPERAND1(OPERAND1'LEFT) then -- if signs are the same but the result's sign is different
        sum_ofl <= '1'; 
    else
        sum_ofl <= '0';   -- signs are the same and the result's sign is also the same
    end if;

    -- MUL
    res_mul <= OPERAND1 * OPERAND2;
    if OPERAND1 = '0' or OPERAND2 = '0' then
        mul_ofl = '0';
    elsif res_mul(N-1) = '0' then -- if sign extension bits are all equal to the result's MSB, there's no overflow
        mul_ofl <= '0' when res_mul(res_mul'LEFT downto N) = zeros_vector else '1';     -- positive number
    else
        mul_ofl <= '0' when res_mul(res_mul'LEFT downto N) = ones_vector else '1';      -- negative number

    -- OR
    res_or <= OPERAND1 or OPERAND2;

    -- SRA
    sign_bit <= OPERAND1(OPERAND1'LEFT); -- using 'LEFT gets the MSB of OPERAND1 regardless of its size
    res_shift <= sign_bit & OPERAND1(OPERAND1'LEFT - 1 downto 1); -- "OPERAND1'LEFT - 1" = Second MSB

    -- Set ALU_RES according to chosen operation
    case OPER is
        when '0' =>
            ALU_RES <= res_sum;
            ofl <= sum_ofl;
        when '1' =>
            ALU_RES <= res_mul(N-1 downto '0');
            ofl <= mul_ofl;
        when '2' =>
            ALU_RES <= res_or;
            ofl = '0';
        when others =>
            ALU_RES <= res_shift;
            ofl = '0';
    
end archi;