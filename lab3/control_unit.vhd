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
    signal h_done, read_done, mul_done : std_logic;
    signal IM_address : std_logic_vector(6 downto 0);
    signal WM0_address : std_logic_vector(9 downto 0);
    signal WM1_address : std_logic_vector(6 downto 0);
    signal row : unsigned(2 downto 0) := 0; -- each image has 7 rows (784 pixels / 112) + 1 empty
    signal img : unsigned(3 downto 0); -- there are 16 images which can be selected through the switches
    signal m : unsigned(6 downto 0); -- each m value indexes a hidden neuron
    signal en_mul : std_logic;

begin
    process (clk)
    begin
        if rising_edge(clk) then
            -- Defaults
                ...

            -- Defining addresses
            IM_address <= std_logic_vector(8 * img + row); -- k/112 is converted into "row" since the pixels are processed 1 row at a time (112 pixels per row)
            WM0_address <= std_logic_vector(7 * m + row);
            read_done <= '1'; -- setting it now allows it to be read as done in the next cycle

            if read_done = '1' then
                en_mul <= '1';
                mul_done <= '1'; -- single-cycle latency
                row <= row+1;
            end if;
            
            if mul_done = '1' then
                en_sum1 <= '1';
                layer1_adders(0) <= '1';
            end if;

            if layer1_adders(0) = '1' then
                en_sum2 <= '1';
                layer1_adders <= shift_left(unsigned(layer1_adders), 1);
            end if; 

            if layer1_adders(1) = '1' then
                en_sum3 <= '1';
                layer1_adders <= shift_left(unsigned(layer1_adders), 1);
            end if;

            if layer1_adders(2) = '1' then
                en_sum4 <= '1';
                layer1_adders <= shift_left(unsigned(layer1_adders), 1);
            end if;

            if layer1_adders(3) = '1' then
                en_sum5 <= '1';
                layer1_adders <= shift_left(unsigned(layer1_adders), 1);
            end if;

            if layer1_adders(4) = '1' then
                en_sum6 <= '1';
                layer1_adders <= shift_left(unsigned(layer1_adders), 1);
            end if;

            if layer1_adders(5) = '1' then
                en_accum_reg <= '1';
                en_accum_adder <= '1';
            
                if row = 6 then
                    h_done <= '1';
                end if;

            end if;

        end if;
    end process;

end behavioral;