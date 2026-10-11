library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;

entity alu is
    generic (N : integer := 15); -- alu operand width
    port (
        OPERAND1, OPERAND2 : in std_logic_vector(N-1 downto 0);  -- operands
        ALU_SEL : in std_logic_vector(1 downto 0);               -- operation select
        ALU_RES : out std_logic_vector(N-1 downto 0);            -- operation's result
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
    res_sum <= std_logic_vector(signed(OPERAND1) + signed(OPERAND2));
    sum_ofl <= (not (OPERAND1(OPERAND1'LEFT) xor OPERAND2(OPERAND2'LEFT))) and (res_sum(res_sum'LEFT) xor OPERAND1(OPERAND1'LEFT));

    -- MUL
    res_mul <= std_logic_vector(signed(OPERAND1) * signed(OPERAND2));
    mul_ofl <= '1' when (res_mul(N-1) = '0' and res_mul(res_mul'LEFT downto N) /= zeros_vector)
                or
                (res_mul(N-1) = '1' and res_mul(res_mul'LEFT downto N) /= ones_vector)
                else '0';

    -- OR
    res_or <= OPERAND1 or OPERAND2;

    -- SRA
    sign_bit <= OPERAND1(OPERAND1'LEFT); -- using 'LEFT gets the MSB of the operand regardless of its size
    res_shift <= sign_bit & OPERAND1(OPERAND1'LEFT downto 1); -- Get bits 14-1, shift them right and add the sign bit as MSB

    -- Set ALU_RES according to chosen operation
    process (ALU_SEL, res_sum, res_mul, res_or, res_shift, sum_ofl, mul_ofl)
    begin
        case ALU_SEL is
            when "00" =>
                ALU_RES <= res_sum;
                ofl <= sum_ofl;
            when "01" =>
                ALU_RES <= res_mul(N-1 downto 0);
                ofl <= mul_ofl;
            when "10" =>
                ALU_RES <= res_or;
                ofl <= '0';
            when others =>
                ALU_RES <= res_shift;
                ofl <= '0';
        end case;
    end process;    
end archi;