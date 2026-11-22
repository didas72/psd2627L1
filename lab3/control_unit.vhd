library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity control_unit is
    port (

    );
end control_unit;

architecture behavioral of control_unit is

    type fsm_state is ();

    signal current_state, next_state : fsm_state;

    signal layer1_adders : std_logic_vector(5 downto 0) := (others => '0'); -- 6 layers of adders
    signal h_done, read_done, mul0_done, mul1_done : std_logic;
    signal IM_address : std_logic_vector(6 downto 0);
    signal WM0_address : std_logic_vector(9 downto 0);
    signal WM1_address : std_logic_vector(6 downto 0);
    signal row : unsigned(2 downto 0) := 0; -- each image has 7 rows (784 pixels / 112) + 1 empty
    signal img : unsigned(3 downto 0); -- there are 16 images which can be selected through the switches
    signal m : unsigned(6 downto 0); -- each m value indexes a hidden neuron
    signal en_mul0, en_mul1 : std_logic;

begin

    Layers : process (clk)
    begin
        if rising_edge(clk) then            
            -- Defaults
            h_done <= '0';
            en_mul0 <= '0';
            en_sum1 <= '0';
            en_sum2 <= '0';
            en_sum3 <= '0';
            en_sum4 <= '0';
            en_sum5 <= '0';
            en_sum6 <= '0';
            en_accum_reg <= '0';
            en_accum_adder <= '0';

            -- Defining addresses
            IM_address <= std_logic_vector(8 * img + row); -- k/112 is converted into "row" since the pixels are processed 1 row at a time (112 pixels per row)
            WM0_address <= std_logic_vector(7 * m + row);
            read_done <= '1'; -- setting it now allows it to be read as done in the next cycle
            row_old <= row;
            m_old <= m;

            --* --------------------------------------------------------
            --* Layer 0
            if read_done = '1' then
                en_mul0 <= '1';
                mul0_done <= '1'; -- single-cycle latency
                row <= row+1;
            end if;
            
            -- Adder tree control
            layer1_adders <= layer1_adders(4 downto 0) & mul0_done;
            en_sum1 <= mul0_done;
            en_sum2 <= layer1_adders(0);
            en_sum3 <= layer1_adders(1);
            en_sum4 <= layer1_adders(2);
            en_sum5 <= layer1_adders(3);
            en_sum6 <= layer1_adders(4);

            if layer1_adders(5) = '1' then
                en_accum_reg <= '1';
                en_accum_adder <= '1';
            
                if row_old = 6 then -- after processing all 7 rows, h[m] is ready (0-6)
                    h_done <= '1';
                    -- add adder tree final reg control?
                    m <= m+1;
                    row <= 0;
                end if;

            end if;


            --* --------------------------------------------------------
            --* Layer 1
            if h_done = '1' then
                en_mul1 <= '1';
                mul1_done <= '1'; -- mul will be done in the next cycle and ready for use
            else
                buffer_reg_en <= '0'; -- avoid overwriting h
            end if;

            --implement layer 1 calculations

        end if;
    end process;

end behavioral;