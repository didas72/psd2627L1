library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity control_unit is
    port (
        OPER : in std_logic_vector (1 downto 0);
        Rst  : in std_logic;
        Clk  : in std_logic);
end control_unit;


architecture behavioral of control_unit is 
    -- 000 STinit   100 STshift
    -- 001 STadd1   101 STadd2
    -- 010 STmul1   110 STmul2
    -- 011 STlogic1 111 STlogic2
    -- 8 states, 3 bits
    -- First bit is ready to calculate result
    signal state : std_logic_vector (2 downto 0);
    
    constant OPERadd : std_logic_vector (1 downto 0) := "00";
    constant OPERmul : std_logic_vector (1 downto 0) := "01";
    constant OPERor : std_logic_vector (1 downto 0) := "10";
    constant OPERsra : std_logic_vector (1 downto 0) := "11";
    
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
            if Rst = '1' then
                state <= STinit;
            elsif state = STinit then
                if OPER = OPERadd then
                    state <= STadd1;
                elsif OPER = OPERmul then
                    state <= STmul1;
                elsif OPER = OPERor then
                    state <= STor1;
                else -- OPERsra
                    state <= STsra;
                end if;
            elsif state = STadd1 then
                state <= STadd2;
            elsif state = STadd2 then
                state <= STinit;
            elsif state = STmul1 then
                state <= STmul2;
            elsif state = STmul2 then
                state <= STinit;
            elsif state = STor1 then
                state <= STor2;
            elsif state = STor2 then
                state <= STinit;
            else --STsra
                state <= STinit;
            end if;
        end if;
    end process;

end behavioral;