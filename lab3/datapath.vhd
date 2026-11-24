library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.multi_number.all;

entity datapath is
    port (
        -- === Global controls ===
        clk : in std_logic;
        rst : in std_logic;

        -- === Control inputs ===
        -- Address registers
        en_i_reg : in std_logic; -- increment input address if set to 1
        en_w0_reg : in std_logic; -- increment weight0 address if set to 1
        en_w1_reg : in std_logic; -- increment weight1 address if set to 1
        -- Buffer registers
        en_reg_i_buff : in std_logic; -- buffer input values if set to 1
        en_reg_w0_buff : in std_logic; -- buffer weight0 values if set to 1
        en_reg_w1_buff : in std_logic; -- buffer weight1 values if set to 1
        -- Data registers (L0 enables)
        en_reg_la0_stN : in std_logic_vector(8-1 downto 0); -- save result of layer 0 stage N+1 if bit N is set to 1
        en_reg_la0_acc : in std_logic; -- add en_reg_la0_st8 to the accumulator if set to 1
        -- Intermediate register
        en_reg_h : in std_logic; -- save the ReLu result if set to 1
        -- Data registers (L1 enables)
        en_reg_la1_stN : in std_logic_vector(2-1 downto 0); -- save result of layer 1 stage N+1 if bit N is set to 1

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

architecture archi of datapath is
    type LA0_STAGE1_T is array(natural range <>) of std_logic_vector(12-1 downto 0);
    type LA0_STAGE2_T is array(natural range <>) of std_logic_vector(13-1 downto 0);
    type LA0_STAGE3_T is array(natural range <>) of std_logic_vector(14-1 downto 0);
    type LA0_STAGE4_T is array(natural range <>) of std_logic_vector(15-1 downto 0);
    type LA0_STAGE5_T is array(natural range <>) of std_logic_vector(16-1 downto 0);
    type LA0_STAGE6_T is array(natural range <>) of std_logic_vector(17-1 downto 0);
    type LA0_STAGE7_T is array(natural range <>) of std_logic_vector(18-1 downto 0);

    type LA1_STAGE1_T is array(natural range <>) of std_logic_vector(30-1 downto 0);
    type LA1_STAGE2_T is array(natural range <>) of std_logic_vector(32-1 downto 0);
    -- === Data registers ===
    -- Input buffers
    signal input_buff : std_logic_vector((INPUT_WIDTH*MULT_COUNT)-1 downto 0);
    signal weight0_buff : std_logic_vector((WEIGHT0_WIDTH*MULT_COUNT)-1 downto 0);
    signal weight1_buff : std_logic_vector(79 downto 0);
    -- Layer 0
    signal reg_la0_st1 : LA0_STAGE1_T(112-1 downto 0);
    signal reg_la0_st2 : LA0_STAGE2_T(56-1 downto 0);
    signal reg_la0_st3 : LA0_STAGE3_T(28-1 downto 0);
    signal reg_la0_st4 : LA0_STAGE4_T(14-1 downto 0);
    signal reg_la0_st5 : LA0_STAGE5_T(7-1 downto 0);
    signal reg_la0_st6 : LA0_STAGE6_T(4-1 downto 0); -- Rounded up
    signal reg_la0_st7 : LA0_STAGE7_T(2-1 downto 0);
    signal reg_la0_st8 : std_logic_vector(19-1 downto 0);
    signal reg_la0_acc : std_logic_vector(22-1 downto 0);
    -- Intermediate register
    signal reg_h : std_logic_vector(22-1 downto 0);
    -- Layer 1
    signal reg_la1_st1 : LA1_STAGE1_T(10-1 downto 0);
    signal reg_la1_st2 : LA1_STAGE2_T(10-1 downto 0);

    -- === Address registers ===
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
                -- Address registers
                reg_i_addr <= (others => '0');
                reg_w0_addr <= (others => '0');
                reg_w1_addr <= (others => '0');
                -- Input buffers
                input_buff <= (others => '0');
                weight0_buff <= (others => '0');
                weight1_buff <= (others => '0');
                -- Reset layer 0
                rst_la0_st1: for i in 0 to 112-1 loop -- This is still parallel
                    reg_la0_st1(i) <= (others => '0');
                end loop;
                rst_la0_st2: for i in 0 to 56-1 loop -- This is still parallel
                    reg_la0_st2(i) <= (others => '0');
                end loop;
                rst_la0_st3: for i in 0 to 28-1 loop -- This is still parallel
                    reg_la0_st3(i) <= (others => '0');
                end loop;
                rst_la0_st4: for i in 0 to 14-1 loop -- This is still parallel
                    reg_la0_st4(i) <= (others => '0');
                end loop;
                rst_la0_st5: for i in 0 to 7-1 loop -- This is still parallel
                    reg_la0_st5(i) <= (others => '0');
                end loop;
                rst_la0_st6: for i in 0 to 4-1 loop -- This is still parallel
                    reg_la0_st6(i) <= (others => '0');
                end loop;
                rst_la0_st7: for i in 0 to 2-1 loop -- This is still parallel
                    reg_la0_st7(i) <= (others => '0');
                end loop;
                reg_la0_st8 <= (others => '0');
                reg_la0_acc <= (others => '0');
                -- Reset intermediate result
                reg_h <= (others => '0');
                -- Reset layer 1
                rst_la1_st1: for i in 0 to 10-1 loop -- This is still parallel
                    reg_la1_st1(i) <= (others => '0');
                end loop;
                rst_la1_st2: for i in 0 to 10-1 loop -- This is still parallel
                    reg_la1_st2(i) <= (others => '0');
                end loop;
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

    process (clk, rst)
    begin
        if rising_edge(clk) and rst = '0' then
            -- === Input buffers ===
            if en_reg_i_buff = '1' then
                input_buff <= input_bus;
            end if;
            if en_reg_w0_buff = '1' then
                weight0_buff <= weight0_bus;
            end if;
            if en_reg_w1_buff = '1' then
                weight1_buff <= weight1_bus;
            end if;
            -- === Layer 0 tree ===
            if en_reg_la0_stN(0) = '1' then
                -- Layer 0, stage 1, 112 multipliers
                gen_la0_st1: for i in 0 to 112-1 loop -- This is still parallel
                    reg_la0_st1(i) <=
                        std_logic_vector(
                            signed(input_buff((i+1)*INPUT_WIDTH-1 downto i*INPUT_WIDTH)) *
                            signed(weight0_buff((i+1)*WEIGHT0_WIDTH-1 downto i*WEIGHT0_WIDTH))
                        );
                end loop;
            end if;

            if en_reg_la0_stN(1) = '1' then
                -- Layer 0, stage 2, 56 adders
                gen_la0_st2: for i in 0 to 56-1 loop -- This is still parallel
                    reg_la0_st2(i) <=
                        std_logic_vector(
                            signed(reg_la0_st1(i*2)) +
                            signed(reg_la0_st1(i*2+1))
                        );
                end loop;
            end if;

            if en_reg_la0_stN(2) = '1' then
                -- Layer 0, stage 3, 28 adders
                gen_la0_st3: for i in 0 to 28-1 loop -- This is still parallel
                    reg_la0_st3(i) <=
                        std_logic_vector(
                            signed(reg_la0_st2(i*2)) +
                            signed(reg_la0_st2(i*2+1))
                        );
                end loop;
            end if;

            if en_reg_la0_stN(3) = '1' then
                -- Layer 0, stage 4, 14 adders
                gen_la0_st4: for i in 0 to 14-1 loop -- This is still parallel
                    reg_la0_st4(i) <=
                        std_logic_vector(
                            signed(reg_la0_st3(i*2)) +
                            signed(reg_la0_st3(i*2+1))
                        );
                end loop;
            end if;

            if en_reg_la0_stN(4) = '1' then
                -- Layer 0, stage 5, 7 adders
                gen_la0_st5: for i in 0 to 7-1 loop -- This is still parallel
                    reg_la0_st5(i) <=
                        std_logic_vector(
                            signed(reg_la0_st4(i*2)) +
                            signed(reg_la0_st4(i*2+1))
                        );
                end loop;
            end if;

            if en_reg_la0_stN(5) = '1' then
                -- Layer 0, stage 6, 4 adders
                -- 3 done in generate, the last one is different
                gen_la0_st6: for i in 0 to 3-1 loop -- This is still parallel
                    reg_la0_st6(i) <=
                        std_logic_vector(
                            signed(reg_la0_st5(i*2)) +
                            signed(reg_la0_st5(i*2+1))
                        );
                end loop;
                -- the different one
                reg_la0_st6(3) <= reg_la0_st5(7);
            end if;

            if en_reg_la0_stN(6) = '1' then
                -- Layer 0, stage 7, 2 adders
                gen_la0_st7: for i in 0 to 2-1 loop -- This is still parallel
                    reg_la0_st7(i) <=
                        std_logic_vector(
                            signed(reg_la0_st6(i*2)) +
                            signed(reg_la0_st6(i*2+1))
                        );
                end loop;
            end if;

            if en_reg_la0_stN(7) = '1' then
                -- Layer 0, stage 8, 1 adder
                reg_la0_st8 <= std_logic_vector(
                        signed(reg_la0_st7(0)) +
                        signed(reg_la0_st7(1))
                    );
            end if;

            -- === Layer 0 accumulator ===
            if en_reg_la0_acc = '1' then
                reg_la0_acc <= std_logic_vector(
                    signed(reg_la0_acc) +
                    signed(reg_la0_st8)
                );
            end if;

            -- === Intermediate result ===
            if en_reg_h = '1' then
                if reg_la0_acc(reg_la0_acc'LEFT) = '0' then
                    reg_h <= reg_la0_acc;
                else
                    reg_h <= (others => '0');
                end if;
            end if;

            -- === Layer 1 ===
            if en_reg_la1_stN(0) = '1' then
                -- Layer 1, stage 1, 10 adders
                gen_la1_st1: for i in 0 to 10-1 loop -- This is still parallel
                    reg_la1_st1(i) <=
                        std_logic_vector(
                            resize(
                                shift_right(
                                    signed(reg_h) *
                                    signed(weight1_buff((i+1)*8-1 downto i*8)),
                                5),
                            32)
                        );
                end loop;
            end if;

            if en_reg_la1_stN(1) = '1' then
                -- Layer 1, stage 2, 10 adders
                gen_la1_st2: for i in 0 to 10-1 loop -- This is still parallel
                    reg_la1_st2(i) <=
                        std_logic_vector(
                            signed(reg_la1_st2(i)) +
                            signed(reg_la1_st1(i))
                        );
                end loop;
            end if;

            -- TODO: Save result?
            -- TODO: Argmax
        end if;
    end process;
end;
