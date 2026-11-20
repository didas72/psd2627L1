library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.multi_number.all;

entity datapath is
--    generic (
--        INPUT_WIDTH : integer := 4;
--        WEIGHT0_WIDTH : integer := 8;
--        MULT_COUNT : integer := 112
--    );
    port (
        -- Global controls
        clk : in std_logic;
        rst : in std_logic;
        
        -- Control inputs
        en_i_reg : in std_logic; -- increments input address if set to 1
        en_w0_reg : in std_logic; -- increments weight0 address if set to 1
        en_w1_reg : in std_logic; -- increments weight1 address if set to 1
        
        -- Data input buses
        input_bus : in std_logic_vector((INPUT_WIDTH*MULT_COUNT)-1 downto 0);
        weight0_bus : in std_logic_vector((WEIGHT0_WIDTH*MULT_COUNT)-1 downto 0);
        weight1_bus : in std_logic_vector(79 downto 0);
        
        -- Address output buses
        input_addr : out std_logic_vector(2 downto 0);
        weight0_addr : out std_logic_vector(2 downto 0);
        weight1_addr : out std_logic_vector(2 downto 0);
        
        -- Result output
        result : out std_logic_vector(3 downto 0)
    );
end;

-- REVIEW: No input registers for now, decided by not me.

architecture archi of datapath is
    type MULT_T is array(natural range <>) of std_logic_vector(INPUT_WIDTH+WEIGHT0_WIDTH-1 downto 0);
    -- Multipliers
    signal mul_result : MULT_T(MULT_COUNT-1 downto 0);
    -- Address registers
    signal reg_i_addr : signed(2 downto 0);
    signal reg_w0_addr : signed(2 downto 0);
    signal reg_w1_addr : signed(2 downto 0);
begin
    -- Address outputs
    input_addr <= std_logic_vector(reg_i_addr);
    weight0_addr <= std_logic_vector(reg_w0_addr);
    weight1_addr <= std_logic_vector(reg_w1_addr);

    gen_mul: for i in 0 to MULT_COUNT-1 generate
        mul_result(i) <= 
            std_logic_vector(
                signed(input_bus((i+1)*INPUT_WIDTH-1 downto i*INPUT_WIDTH)) * 
                signed(weight0_bus((i+1)*WEIGHT0_WIDTH-1 downto i*WEIGHT0_WIDTH)));
    end generate;
    
    process (clk, rst)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                reg_i_addr <= (others => '0');
                reg_w0_addr <= (others => '0');
                reg_w1_addr <= (others => '0');
            else
                if en_i_reg = '1' then
                    reg_i_addr <= reg_i_addr + 1;
                end if;
                if en_w0_reg = '1' then
                    reg_w0_addr <= reg_w0_addr + 1;
                end if;
                if en_w1_reg = '1' then
                    reg_w1_addr <= reg_w1_addr + 1;
                end if;
            end if;
        end if;
    end process;
end;
