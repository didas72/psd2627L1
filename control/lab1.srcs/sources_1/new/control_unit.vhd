library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity control_unit is
    port (
        -- Reset signal
        rst : in std_logic;

        -- Clock signal
        clk : in std_logic;

        -- Equals pressed (provided by Interface)
        -- Set high for one clk pulse to signal equals button was pressed
        equals : in std_logic;

        -- Oper was changed (provided by Interface)
        -- Set high for one clk pulse to signal an operation button was pressed
        oper_avail : in std_logic;

        -- Operation selector (provided by Interface)
        -- Can be:
        --   00 - ADD
        --   01 - MUL
        --   10 - OR
        --   11 - SRA
        OPER : in std_logic_vector (1 downto 0);

        -- ALU operation MUX selector (passed to Datapath)
        ALU_SEL : out std_logic_vector(1 downto 0);

        -- Register write control (passed to Datapath)
        en_r1, en_r2 : out std_logic;

        -- Display output selector (passed to Datapath)
        -- Can be:
        --   LOW - Display shows VALUE
        --   HIGH - Display shows ALU_RES
        display_sel : out std_logic;
        );
end control_unit;


architecture behavioral of control_unit is
    -- 000 STwait1
    -- 001 STadd
    -- 010 STmul
    -- 011 STor
    -- 100 STsra_pt1
    -- 101 STdone
    --
    -- 6 (valid) states, 3 bits
    signal STATE : std_logic_vector (2 downto 0);

    constant OPERadd : std_logic_vector (1 downto 0) := "00";
    constant OPERmul : std_logic_vector (1 downto 0) := "01";
    constant OPERor :  std_logic_vector (1 downto 0) := "10";
    constant OPERsra : std_logic_vector (1 downto 0) := "11";

    constant ALU_SELadd : std_logic_vector (1 downto 0) := "00";
    constant ALU_SELmul : std_logic_vector (1 downto 0) := "01";
    constant ALU_SELor :  std_logic_vector (1 downto 0) := "10";
    constant ALU_SELsra : std_logic_vector (1 downto 0) := "11";

    constant STwait1 :   std_logic_vector (2 downto 0) := "000";
    constant STadd :     std_logic_vector (2 downto 0) := "001";
    constant STmul :     std_logic_vector (2 downto 0) := "010";
    constant STor :      std_logic_vector (2 downto 0) := "011";
    constant STsra_pt1 : std_logic_vector (2 downto 0) := "100";
    constant STdone :    std_logic_vector (2 downto 0) := "101";

begin

    -- state register
    process (clk)
    begin
        if clk'event and clk = '1' then
            if rst = '1' then
                STATE <= STinit;
            end if;
        end if;
    end process;

    -- output calculations
    process (STATE)
    begin
    end process;

end behavioral;
