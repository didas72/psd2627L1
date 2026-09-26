library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;

entity datapath is 
    port (
    VALUE : in  std_logic_vector (15 downto 0);
    OPER : in std_logic_vector (1 downto 0);
    en_accum, rst_calculation, en_r1 : in  std_logic;
    clk : in  std_logic;
    overflow_flag : out std_logic;
    RESULT : out std_logic_vector (15 downto 0)
    );
    
end datapath;

architecture behavioral of datapath is
    signal REG1, REG2 : std_logic_vector (15 downto 0);
    signal OPERAND1, OPERAND2, ALU_RES : std_logic_vector (15 downto 0);
    signal OPER : std_logic_vector (1 downto 0);

    alu15: alu generic map (N => 15) 
        port map (OPERAND1 => OPERAND1, OPERAND2 => OPERAND2, ALU_RES => ALU_RES, ofl => overflow_flag);

begin
    -- accumulator
    process (clk)
    begin
        if clk'event and clk = '1' then
            if rst_calculation = '1' then
                REG2 <= X"00";
                REG1 <= X"00";
            elsif en_accum = '1' then
                REG2 <= ALU_RES;
            end if;
        end if;
    end process;

  -- register 1
    process (clk)
    begin
        if clk'event and clk = '1' then
            if en_r1 = '1' then
                REG1 <= VALUE;
            end if;
        end if;
    end process;

    -- output
    process (clk)
    begin
        if clk'event and clk = '1' then
            if equals_pressed = '1' then
                RESULT <= REG2;
            else
                RESULT <= VALUE;
            end if;
        end if;
    end process;
  
end behavioral;
