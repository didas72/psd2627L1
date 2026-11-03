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

    -- Estados com etapas dedicadas para dar tempo a BRAM responder
    type fsm_state is (
        s_l2_0_addr,  -- Apresenta endereco A0/B0 e A2/B2
        s_l2_0_latch, -- BRAM respondeu -> Guarda em REG1 e REG2
        s_l2_1_addr,  -- Apresenta endereco A1/B1 e A3/B3 + Acumula par 0
        s_l2_1_latch, -- BRAM respondeu -> Guarda em REG1 e REG2
        s_l2_2_accum, -- Acumula par 1 e incrementa contadores
        s_l1_0,       -- Escreve C e faz reset ao acumulador
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
                -- Atribuicoes padrao a cada ciclo
                en_accum    <= '0';
                en_r1       <= '0';
                en_r2       <= '0';
                reset_accum <= '0';
                we          <= '0';

                case state is

                    -- --- PAR 0 (A0*B0 e A2*B2) ---
                    when s_l2_0_addr =>
                        input_select <= '0';
                        state        <= s_l2_0_latch;

                    when s_l2_0_latch =>
                        -- A BRAM ja disponibilizou os dados novos, agora podemos guardar
                        en_r1 <= '1';
                        en_r2 <= '1';
                        state <= s_l2_1_addr;

                    -- --- PAR 1 (A1*B1 e A3*B3) ---
                    when s_l2_1_addr =>
                        -- Acumula o par 0 que acabou de ser multiplicado
                        en_accum     <= '1';
                        input_select <= '1';
                        state        <= s_l2_1_latch;

                    when s_l2_1_latch =>
                        -- A BRAM ja disponibilizou os dados novos do par 1
                        en_r1 <= '1';
                        en_r2 <= '1';
                        state <= s_l2_2_accum;

                    when s_l2_2_accum =>
                        -- Acumula o par 1
                        en_accum <= '1';
                        
                        -- Incrementa enderecos para a proxima iteracao do k
                        reg_input_addr  <= reg_input_addr + 1;
                        reg_weight_addr <= reg_weight_addr + 1;

                        if (reg_input_addr + 1) /= 0 then
                            state <= s_l2_0_addr;
                        else
                            state <= s_l1_0;
                        end if;

                    -- --- ESCRITA DA SAIDA C ---
                    when s_l1_0 =>
                        we              <= '1';
                        reset_accum     <= '1';
                        reg_input_addr  <= (others => '0');
                        reg_output_addr <= reg_output_addr + 1;

                        if (reg_output_addr + 1) /= 16 then
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