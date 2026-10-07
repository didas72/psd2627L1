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

        -- REG1 input MUX
        -- Can be:
        --    LOW - VALUE is used
        --    HIGH - REG2 is used
        en_accum : out std_logic;

        -- Display output selector (passed to Datapath)
        -- Can be:
        --   LOW - Display shows VALUE
        --   HIGH - Display shows REG2
        display_sel : out std_logic
    );
end control_unit;


architecture behavioral of control_unit is
    -- 000 STinit
    -- 001 STadd
    -- 010 STmul
    -- 011 STor
    -- 100 STsra_pt2
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

    constant STinit :    std_logic_vector (2 downto 0) := "000";
    constant STadd :     std_logic_vector (2 downto 0) := "001";
    constant STmul :     std_logic_vector (2 downto 0) := "010";
    constant STor :      std_logic_vector (2 downto 0) := "011";
    constant STsra_pt2 : std_logic_vector (2 downto 0) := "100";
    constant STdone :    std_logic_vector (2 downto 0) := "101";

begin

    -- state register
    state_reg : process (clk)
    begin
        if clk'event and clk = '1' then
            if rst = '1' then
                STATE <= STinit;
            elsif STATE = STsra_pt2 then
                STATE <= STdone;
            elsif equals = '1' then
                if STATE = STadd or
                  STATE = STmul or
                  STATE = STor then
                    STATE <= STdone;
                end if;
            elsif oper_avail = '1' and (STATE = STinit or STATE = STdone) then
                if OPER = OPERadd then
                    STATE <= STadd;
                elsif OPER = OPERmul then
                    STATE <= STmul;
                elsif OPER = OPERor then
                    STATE <= STor;
                else -- OPERsra
                    STATE <= STsra_pt2;
                end if;
            end if;
        end if;
    end process;

    -- output calculations
    output_values : process (STATE)
    begin
        if STATE = STinit then
            -- Used to input the first value
            en_accum <= '0';
            ALU_SEL <= ALU_SELadd; -- Anything goes
            en_r1 <= '1'; -- Continuously hold high
            en_r2 <= '0';
            display_sel <= '0';
        elsif STATE = STadd then
            -- Used to input the second value for an add
            en_accum <= '0';
            ALU_SEL <= ALU_SELadd;
            en_r1 <= '0';
            en_r2 <= '1'; -- Continuously hold high
            display_sel <= '0';
        elsif STATE = STmul then
            -- Used to input the second value for a mul
            en_accum <= '0';
            ALU_SEL <= ALU_SELmul;
            en_r1 <= '0';
            en_r2 <= '1'; -- Continuously hold high
            display_sel <= '0';
        elsif STATE = STor then
            -- Used to input the second value for an or
            en_accum <= '0';
            ALU_SEL <= ALU_SELor;
            en_r1 <= '0';
            en_r2 <= '1'; -- Continuously hold high
            display_sel <= '0';
        elsif STATE = STsra_pt2 then
            -- Used to perform the second step of sra, the actual shift
            en_accum <= '0';
            ALU_SEL <= ALU_SELsra;
            en_r1 <= '0';
            en_r2 <= '1';
            display_sel <= '0';
        else -- STdone
            -- Used to input the second value for an add
            en_accum <= '1';
            ALU_SEL <= ALU_SELadd; -- Anything goes
            en_r1 <= '1';  -- Continuously hold high (reads from R2)
            en_r2 <= '0';
            display_sel <= '1';
        end if;
    end process;

end behavioral;
