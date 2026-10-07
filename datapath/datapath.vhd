library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
    port (
    VALUE : in  std_logic_vector (14 downto 0);
    ALU_SEL : in std_logic_vector (1 downto 0);
    en_accum, rst, en_r1, en_r2, display_sel : in  std_logic;
    clk : in  std_logic;
    overflow_flag : out std_logic;
    RESULT : out std_logic_vector (14 downto 0)
    );

end datapath;

architecture behavioral of datapath is
    signal REG1, REG2 : std_logic_vector (14 downto 0);
    signal ALU_RES : std_logic_vector (14 downto 0);


begin
    alu15 : entity work.alu
        generic map (
            N => 15
        )
        port map (
            OPERAND1 => REG1,
            OPERAND2 => VALUE,
            ALU_SEL  => ALU_SEL,
            ALU_RES  => ALU_RES,
            ofl      => overflow_flag
        );

    process (clk)
    begin
        if clk'event and clk = '1' then

            if en_r1 = '1' then
                -- MUX top
                if en_accum = '0' then
                    REG1 <= VALUE;
                else
                    REG1 <= REG2;
                end if;
            end if;

            if en_r2 = '1' then
                REG2 <= ALU_RES;
            end if;

            if rst = '1' then
                REG2 <= (others => '0');
                REG1 <= (others => '0');
            end if;

        end if;
    end process;

    -- MUX top
    --REG1 <= VALUE when (en_accum = '0') else REG2;

    -- MUX bottom
    -- 1 => res | 0 => val
    RESULT <= REG2 when (display_sel = '1') else VALUE;

end behavioral;
