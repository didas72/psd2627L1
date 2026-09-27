library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity control_unit is
    port (
        -- Reset signal
        rst  : in std_logic;

        -- Clock signal
        clk  : in std_logic;

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
        );
end control_unit;


architecture behavioral of control_unit is
    -- 000 STinit   100 STshift
    -- 001 STadd1   101 STadd2
    -- 010 STmul1   110 STmul2
    -- 011 STlogic1 111 STlogic2
    -- 8 states, 3 bits
    -- First bit is ready to calculate result
    signal STATE : std_logic_vector (2 downto 0);

    constant OPERadd : std_logic_vector (1 downto 0) := "00";
    constant OPERmul : std_logic_vector (1 downto 0) := "01";
    constant OPERor : std_logic_vector (1 downto 0) := "10";
    constant OPERsra : std_logic_vector (1 downto 0) := "11";

    constant ALU_SELadd : std_logic_vector (1 downto 0) := "00";
    constant ALU_SELmul : std_logic_vector (1 downto 0) := "01";
    constant ALU_SELor : std_logic_vector (1 downto 0) := "10";
    constant ALU_SELsra : std_logic_vector (1 downto 0) := "11";

    constant STinit : std_logic_vector (2 downto 0) := "000";
    constant STadd1 : std_logic_vector (2 downto 0) := "001";
    constant STmul1 : std_logic_vector (2 downto 0) := "010";
    constant STor1 : std_logic_vector (2 downto 0) := "011";
    constant STsra : std_logic_vector (2 downto 0) := "100";
    constant STadd2 : std_logic_vector (2 downto 0) := "101";
    constant STmul2 : std_logic_vector (2 downto 0) := "110";
    constant STor2 : std_logic_vector (2 downto 0) := "111";
begin

    -- state register
    process (clk)
    begin
        if clk'event and clk = '1' then
            if rst = '1' then
                STATE <= STinit;
            elsif STATE = STinit then
                if OPER = OPERadd then
                    STATE <= STadd1;
                elsif OPER = OPERmul then
                    STATE <= STmul1;
                elsif OPER = OPERor then
                    STATE <= STor1;
                else -- OPERsra
                    STATE <= STsra;
                end if;
            elsif STATE = STadd1 then
                STATE <= STadd2;
            elsif STATE = STadd2 then
                STATE <= STinit;
            elsif STATE = STmul1 then
                STATE <= STmul2;
            elsif STATE = STmul2 then
                STATE <= STinit;
            elsif STATE = STor1 then
                STATE <= STor2;
            elsif STATE = STor2 then
                STATE <= STinit;
            else --STsra
                STATE <= STinit;
            end if;
        end if;
    end process;

end behavioral;
