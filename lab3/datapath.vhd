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
        -- === Global controls ===
        clk : in std_logic;
        rst : in std_logic;

        -- === Control inputs ===
        -- Address registers
        en_i_reg : in std_logic; -- increment input address if set to 1
        en_w0_reg : in std_logic; -- increment weight0 address if set to 1
        en_w1_reg : in std_logic; -- increment weight1 address if set to 1
        -- Data registers
        en_reg_la0_st0 : in std_logic; -- save the operation result if set to 1
        en_reg_la0_st1 : in std_logic; -- save the operation result if set to 1
        en_reg_la0_st2 : in std_logic; -- save the operation result if set to 1
        en_reg_la0_st3 : in std_logic; -- save the operation result if set to 1
        en_reg_la0_st4 : in std_logic; -- save the operation result if set to 1
        en_reg_la0_st5 : in std_logic; -- save the operation result if set to 1
        en_reg_la0_st6 : in std_logic; -- save the operation result if set to 1
        en_reg_la0_st7 : in std_logic; -- save the operation result if set to 1

        -- === Data input buses ===
        input_bus : in std_logic_vector((INPUT_WIDTH*MULT_COUNT)-1 downto 0);
        weight0_bus : in std_logic_vector((WEIGHT0_WIDTH*MULT_COUNT)-1 downto 0);
        weight1_bus : in std_logic_vector(79 downto 0);

        -- === Address output buses ===
        input_addr : out std_logic_vector(2 downto 0);
        weight0_addr : out std_logic_vector(2 downto 0);
        weight1_addr : out std_logic_vector(2 downto 0);

        -- === Result output ===
        result : out std_logic_vector(3 downto 0)
    );
end;

-- REVIEW: No input registers for now, decided by not me.

architecture archi of datapath is
    type STAGE1_T is array(natural range <>) of std_logic_vector(13-1 downto 0);
    type STAGE2_T is array(natural range <>) of std_logic_vector(14-1 downto 0);
    type STAGE3_T is array(natural range <>) of std_logic_vector(15-1 downto 0);
    type STAGE4_T is array(natural range <>) of std_logic_vector(16-1 downto 0);
    type STAGE5_T is array(natural range <>) of std_logic_vector(17-1 downto 0);
    type STAGE6_T is array(natural range <>) of std_logic_vector(18-1 downto 0);
    type STAGE7_T is array(natural range <>) of std_logic_vector(19-1 downto 0);
    -- Data registers
    signal reg_la0_st1 : STAGE1_T(112-1 downto 0);
    signal reg_la0_st2 : STAGE2_T(56-1 downto 0);
    signal reg_la0_st3 : STAGE3_T(28-1 downto 0);
    signal reg_la0_st4 : STAGE4_T(14-1 downto 0);
    signal reg_la0_st5 : STAGE4_T(7-1 downto 0);
    signal reg_la0_st6 : STAGE4_T(4-1 downto 0); -- Rounded up
    signal reg_la0_st7 : STAGE4_T(2-1 downto 0);
    signal reg_la0_st8 : std_logic_vector(20-1 downto 0);
    -- Address registers
    signal reg_i_addr : signed(2 downto 0);
    signal reg_w0_addr : signed(2 downto 0);
    signal reg_w1_addr : signed(2 downto 0);
begin
    -- Address outputs
    input_addr <= std_logic_vector(reg_i_addr);
    weight0_addr <= std_logic_vector(reg_w0_addr);
    weight1_addr <= std_logic_vector(reg_w1_addr);

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

    process (clk)
    begin
        if rising_edge(clk) then
            -- === Layer 0 ===
            if en_reg_la0_st0 = '1' then
                -- Layer 0, stage 1, 112 multipliers
                gen_mul: for i in 0 to 112-1 generate
                    reg_la0_st1(i) <=
                        std_logic_vector(
                            signed(input_bus((i+1)*INPUT_WIDTH-1 downto i*INPUT_WIDTH)) *
                            signed(weight0_bus((i+1)*WEIGHT0_WIDTH-1 downto i*WEIGHT0_WIDTH))
                        );
                end generate;
            end if;

            if en_reg_la0_st1 = '1' then
                -- Layer 0, stage 2, 56 adders
                gen_mul: for i in 0 to 56-1 generate
                    reg_la0_st2(i) <=
                        std_logic_vector(
                            signed(reg_la0_st1(i*2)) +
                            signed(reg_la0_st1(i*2+1))
                        );
                end generate;
            end if;

            if en_reg_la0_st2 = '1' then
                -- Layer 0, stage 3, 28 adders
                gen_mul: for i in 0 to 28-1 generate
                    reg_la0_st3(i) <=
                        std_logic_vector(
                            signed(reg_la0_st2(i*2)) +
                            signed(reg_la0_st2(i*2+1))
                        );
                end generate;
            end if;

            if en_reg_la0_st3 = '1' then
                -- Layer 0, stage 4, 14 adders
                gen_mul: for i in 0 to 14-1 generate
                    reg_la0_st4(i) <=
                        std_logic_vector(
                            signed(reg_la0_st3(i*2)) +
                            signed(reg_la0_st3(i*2+1))
                        );
                end generate;
            end if;

            if en_reg_la0_st4 = '1' then
                -- Layer 0, stage 5, 7 adders
                gen_mul: for i in 0 to 7-1 generate
                    reg_la0_st5(i) <=
                        std_logic_vector(
                            signed(reg_la0_st4(i*2)) +
                            signed(reg_la0_st4(i*2+1))
                        );
                end generate;
            end if;

            if en_reg_la0_st5 = '1' then
                -- Layer 0, stage 6, 4 adders
                -- 3 done in generate, the last one is different
                gen_mul: for i in 0 to 3-1 generate
                    reg_la0_st6(i) <=
                        std_logic_vector(
                            signed(reg_la0_st5(i*2)) +
                            signed(reg_la0_st5(i*2+1))
                        );
                end generate;
                -- the different one
                reg_la0_st6(i) <= reg_la0_st5(7);
            end if;

            if en_reg_la0_st6 = '1' then
                -- Layer 0, stage 7, 2 adders
                gen_mul: for i in 0 to 2-1 generate
                    reg_la0_st7(i) <=
                        std_logic_vector(
                            signed(reg_la0_st6(i*2)) +
                            signed(reg_la0_st6(i*2+1))
                        );
                end generate;
            end if;

            if en_reg_la0_st7 = '1' then
                -- Layer 0, stage 8, 1 adder
                reg_la0_st8(i) <= std_logic_vector(
                        signed(reg_la0_st7(0)) +
                        signed(reg_la0_st7(1))
                    );
            end if;
        end if;
    end process;
end;
