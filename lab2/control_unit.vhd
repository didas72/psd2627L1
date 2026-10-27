library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity control_unit is
    port (
        -- Reset signal
        rst : in std_logic;

        -- Clock signal
        clk : in std_logic;

        -- Register write control (passed to Datapath)
        -- Active high
        en_accum, en_r1, en_r2 : out std_logic;

        -- Reset accumulator to zero (passed to Datapath)
        -- Active high
        reset_accum : out std_logic;

        -- Multiplier input selector (passed to Datapath)
        --   LOW - Uses A0 * B0 and A2 * B2
        --   HIGH - Uses A1 * B1 and A3 * B3
        input_select : out std_logic;

        -- Memory address buses
        input_addr : out std_logic_vector(3 downto 0); -- log2(64 / 4) = 4
        weight_addr : out std_logic_vector(7 downto 0); -- log2(1024 / 4) = 8
        output_addr : out std_logic_vector(3 downto 0); -- log2(64 / 4) = 4

        -- Set high after the last word is written
        done : out std_logic;

        -- Write enable for memory C
        -- active high
        we : out std_logic
    );
end control_unit;

architecture behavioral of control_unit is

    -- for (int m = 0; m < M; ++m) { // m is output neuron (aka output index)
    --     acc = 0;
    --     for (int k = 0; k < K; k += 4) { // k is input value (aka input index)
    --         acc = acc; p0 = A[m][k] * B[k]; p1 = A[m][k+1] * B[k+1];
    --         acc = acc + (p0 + p1); p0 = A[m][k+2] * B[k+2]; p1 = A[m][k+3] * B[k+3];
    --         acc = acc + (p0 + p1);
    --     }
    --     C[m] = acc < 0 ? 0 : acc;
    -- }
    --
    -- Assume A0 <= A[r_w*4+0]; A1 <= A[r_w*4+1]; ... B0 <= B[r_i*4+0]; B1 <= B[r_i*4+1]; ... C <= C[r_o]
    --
    -- (rst)  r_i = 0 || r_w = 0 || r_o = 0
    --        l1:
    --          l2:
    -- (l2_0)     p0 = A0 * B0 || p1 = A2 * B2
    -- (l2_1)     acc = acc + p0 + p1 || p0 = A1 * B1 || p1 = A3 * B3 || r_i += 1 || r_w += 1
    -- (l2_2)     acc = acc + p0 + p1 || if (r_i != 0 (!=16)) goto l2 (l2_0)
    -- (l1_0)   C = acc || acc = 0 || r_i = 0 || r_o += 1 || if (r_o != 16-1) goto l1 (l2_0)
    -- (done) NOP

    type fsm_state is (
        s_l2_0, -- Also initial state
        s_l2_1,
        s_l2_2,
        s_l1_0,
        s_done -- All operations complete
    );
    signal state : fsm_state;
    signal next_state : fsm_state;
    signal reg_input_addr : unsigned(3 downto 0); -- 16 x 4 = 64
    signal reg_weight_addr : unsigned(7 downto 0); -- 256 x 4 = 1024
    signal reg_output_addr : unsigned(3 downto 0); -- 16 x 1 = 16
begin

    input_addr <= std_logic_vector(reg_input_addr);
    weight_addr <= std_logic_vector(reg_weight_addr);
    output_addr <= std_logic_vector(reg_output_addr);
    done <= '1' when state = s_done else '0';

    -- Registers
    process (clk)
    begin
        if clk'event and clk = '1' then -- Rising edge
            if rst = '1' then
                state <= s_l2_0;
                reg_input_addr <= (others => '0');
                reg_weight_addr <= (others => '0');
                reg_output_addr <= (others => '0');
            else
                state <= next_state;
                case state is
                    when s_l2_1 =>
                        reg_input_addr <= reg_input_addr + 1;
                        reg_weight_addr <= reg_weight_addr + 1;
                    when s_l1_0 =>
                        reg_input_addr <= (others => '0');
                        reg_output_addr <= reg_output_addr + 1;
                    when others => null;
                end case;
            end if;
        end if;
    end process;

    -- Next state logic
    process (state, reg_input_addr, reg_output_addr)
    begin
        case state is
            when s_l2_0 =>                    next_state <= s_l2_1;
            when s_l2_1 =>                    next_state <= s_l2_2;
            when s_l2_2 =>
                if reg_input_addr /= 15 then   next_state <= s_l2_0;
                else                          next_state <= s_l1_0; end if;
            when s_l1_0 =>
                if reg_output_addr /= 15 then next_state <= s_l2_0;
                else                          next_state <= s_done; end if;
            when s_done =>                    next_state <= s_done;
        end case;
    end process;

    -- Control signals
    process (state)
    begin
        -- Default state is nop
        reset_accum <= '0';
        en_accum <= '0';
        input_select <= '0';
        en_r1 <= '0';
        en_r2 <= '0';
        we <= '0';

        case state is
            when s_l2_0 =>
                -- p0 = A0 * B0 || p1 = A1 * B1
                input_select <= '0';
                en_r1 <= '1';
                en_r2 <= '1';
            when s_l2_1 =>
                -- acc = acc + p0 + p1
                en_accum <= '1';
                -- p0 = A2 * B2 || p1 = A3 * B3
                input_select <= '1';
                en_r1 <= '1';
                en_r2 <= '1';
            when s_l2_2 =>
                -- acc = acc + p0 + p1
                en_accum <= '1';
                -- (done in state machine) if (r_w != 16) goto l2 (l2_0)
            when s_l1_0 =>
                -- C = acc
                we <= '1';
                -- acc = 0
                reset_accum <= '1';
                -- (done in state machine) if (r_o != 16-1) goto l1 (l2_0)
            when s_done => null;
        end case;
    end process;

end behavioral;
