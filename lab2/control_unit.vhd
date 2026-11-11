library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity control_unit is
    port (
        rst          : in  std_logic;
        clk          : in  std_logic;
        en_accum     : out std_logic;
        en_r1        : out std_logic;
        en_r2        : out std_logic;
        reset_accum  : out std_logic;
        input_select : out std_logic;
        input_addr   : out std_logic_vector(3 downto 0);
        weight_addr  : out std_logic_vector(7 downto 0);
        output_addr  : out std_logic_vector(3 downto 0);
        done         : out std_logic;
        we           : out std_logic
    );
end control_unit;

architecture behavioral of control_unit is

    -- States with dedicated stages to give the BRAM time to respond
    type fsm_state is (
        s_l2_0_addr,  -- Present address for A0/B0 and A2/B2
        s_l2_0_latch, -- BRAM responded -> Store in REG1 and REG2
        s_l2_1_addr,  -- Present address for A1/B1 and A3/B3 + Accumulate pair 0
        s_l2_1_latch, -- BRAM responded -> Store in REG1 and REG2
        s_l2_2_accum, -- Accumulate pair 1 and increment counters
        s_l1_0,       -- Write C and reset accumulator
        s_done
    );

    signal state : fsm_state;

    signal reg_input_addr  : unsigned(3 downto 0) := (others => '0');
    signal reg_weight_addr : unsigned(7 downto 0) := (others => '0');
    signal reg_output_addr : unsigned(3 downto 0) := (others => '0');

begin

    input_addr  <= std_logic_vector(reg_input_addr);
    weight_addr <= std_logic_vector(reg_weight_addr);
    output_addr <= std_logic_vector(reg_output_addr);
    done        <= '1' when state = s_done else '0';

    process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state           <= s_l2_0_addr;
                reg_input_addr  <= (others => '0');
                reg_weight_addr <= (others => '0');
                reg_output_addr <= (others => '0');

                en_accum     <= '0';
                en_r1        <= '0';
                en_r2        <= '0';
                reset_accum  <= '1';
                input_select <= '0';
                we           <= '0';
            else
                -- Default assignments on each clock cycle
                en_accum    <= '0';
                en_r1       <= '0';
                en_r2       <= '0';
                reset_accum <= '0';
                we          <= '0';

                case state is

                    -- --- PAIR 0 (A0*B0 and A2*B2) ---
                    when s_l2_0_addr =>
                        input_select <= '0';
                        state        <= s_l2_0_latch;

                    when s_l2_0_latch =>
                        -- BRAM has provided the new data, now we can store it
                        en_r1 <= '1';
                        en_r2 <= '1';
                        state <= s_l2_1_addr;

                    -- --- PAIR 1 (A1*B1 and A3*B3) ---
                    when s_l2_1_addr =>
                        -- Accumulate pair 0 that was just multiplied
                        en_accum     <= '1';
                        input_select <= '1';
                        state        <= s_l2_1_latch;

                    when s_l2_1_latch =>
                        -- BRAM has provided the new data for pair 1
                        en_r1 <= '1';
                        en_r2 <= '1';
                        state <= s_l2_2_accum;

                    when s_l2_2_accum =>
                        -- Accumulate pair 1
                        en_accum <= '1';
                        
                        -- Increment addresses for the next iteration of k
                        reg_input_addr  <= reg_input_addr + 1;
                        reg_weight_addr <= reg_weight_addr + 1;

                        if (reg_input_addr + 1) /= 0 then
                            state <= s_l2_0_addr;
                        else
                            state <= s_l1_0;
                        end if;

                    -- --- WRITE OUTPUT C ---
                    when s_l1_0 =>
                        we              <= '1';
                        reset_accum     <= '1';
                        reg_input_addr  <= (others => '0');
                        reg_output_addr <= reg_output_addr + 1;

                        if (reg_output_addr + 1) /= 0 then
                            state <= s_l2_0_addr;
                        else
                            state <= s_done;
                        end if;

                    when s_done =>
                        state <= s_done;

                end case;
            end if;
        end if;
    end process;

end behavioral;