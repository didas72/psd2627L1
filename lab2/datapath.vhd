library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
    port (
    en_accum, reset, en_r1, en_r2, reset_accum : in  std_logic;
    clk : in  std_logic;
    input_select : in std_logic;
    A0, A2, B0, B2, A1, A3, B1, B3 : in std_logic_vector (7 downto 0);
    C : out std_logic_vector (31 downto 0) --? Vai ser mesmo este o tamanho?
    );

end datapath;

architecture behavioral of datapath is
    signal REG1, REG2 : std_logic_vector (15 downto 0); -- 16 bits (multiplication of two 8 bit numbers)
    signal REG_ACCUM : std_logic_vector (21 downto 0); -- 22 bits
    signal MUL1_IN1, MUL1_IN2, MUL2_IN1, MUL2_IN2 : std_logic_vector (7 downto 0);
    signal MUL1_OUT, MUL2_OUT : std_logic_vector (15 downto 0); -- 16 bits (multiplication of two 8 bit numbers)
    signal ADD_OUT : std_logic_vector (21 downto 0); -- 22 bits

begin

    -- multiplexers that control the multipliers' inputs
    MUL1_IN1 <= A0 when (input_select = '1') else A2;
    MUL1_IN2 <= B0 when (input_select = '1') else B2;
    MUL2_IN1 <= A1 when (input_select = '1') else A3;
    MUL2_IN2 <= B1 when (input_select = '1') else B3;

    --? Check overflow?
    -- multiplier 1
    MUL1_OUT <= std_logic_vector(signed(MUL1_IN1) * signed(MUL1_IN2));    

    -- multiplier 2
    MUL2_OUT <= std_logic_vector(signed(MUL2_IN1) * signed(MUL2_IN2));    

    -- adder 1
    ADD_OUT <= std_logic_vector(resize(signed(REG1), 22) + resize(signed(REG2), 22) + signed(REG_ACCUM));

    -- activation function
    C <= (others => '0') when (REG_ACCUM(REG_ACCUM'LEFT) = '1') else "0000000000" & REG_ACCUM;

    process (clk)
    begin
        if clk'event and clk = '1' then -- positive edge

            if en_r1 = '1' then     -- store in REG1
                REG1 <= MUL1_OUT;
            end if;

            if en_r2 = '1' then     -- store in REG2
                REG2 <= MUL2_OUT;
            end if;

            if en_accum = '1' then  -- store in REG_ACCUM
                REG_ACCUM <= ADD_OUT;
            end if;

            if reset = '1' then
                REG1 <= (others => '0');
                REG2 <= (others => '0');
                REG_ACCUM <= (others => '0');
            end if;

            if reset_accum = '1' then
                REG_ACCUM <= (others => '0');
            end if;

        end if;
    end process;


end behavioral;
