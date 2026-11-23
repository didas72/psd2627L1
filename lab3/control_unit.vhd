library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity control_unit is
    port (
        -- Add start signal
    );
end control_unit;

architecture behavioral of control_unit is

    type fsm_state is (s_init, s_pipelineFill, s_pipelineRun, s_pipelineFlush, s_getResult);

    signal current_state, next_state : fsm_state;

    signal layer0_counter : unsigned(3 downto 0) := 1; -- 7 layers of adders + 1 multiplier
    signal hValid, read_done, mul0_done, mul1_done : std_logic;
    signal IM_address : std_logic_vector(6 downto 0);
    signal WM0_address : std_logic_vector(9 downto 0);
    signal WM1_address : std_logic_vector(6 downto 0);
    signal row : unsigned(2 downto 0) := (others => '0'); -- each image has 7 rows (784 pixels / 112) + 1 empty
    signal img : unsigned(3 downto 0); -- there are 16 images which can be selected through the switches
    signal hAddress : unsigned(6 downto 0) := (others => '0'); -- each m value indexes a hidden neuron
    --signal en_reg_la0_st1, en_reg_la0_st2, en_reg_la0_st3, en_reg_la0_st4, en_reg_la0_st5, en_reg_la0_st6, en_reg_la0_st7, en_reg_la0_st8 : std_logic;
    signal en_reg_la0 : std_logic_vector(7 downto 0) := (others => '0'); -- enables of all stages of layer 0
    signal en_reg_acc, en_reg_h : std_logic;
    signal en_reg_la1_st1, en_reg_la1_st2, en_reg_la1_out : std_logic;

begin

    process (clk)
    begin
        if rising_edge(clk) then            
            
            --! Add case statement to select state

            --* s_pipelineFill --------------------------------------------------
            -- Defining addresses
            IM_address <= std_logic_vector(8 * img + row); -- k/112 is converted into "row" since the pixels are processed 1 row at a time (112 pixels per row)
            WM0_address <= std_logic_vector(7 * hAddress + row);
            
            -- Defaults
            hValid <= '0';
            en_reg_la0 <= (others => '0');
            row <= row+1;

            if start = '1' then
                read_done <= '1'; -- setting it now allows it to be read as done in the next cycle
            end if;

            --* Layer 0
            if read_done = '1' then -- first data is ready, operation can begin
                layer0_counter <= layer0_counter+1;
                en_reg_la0 <= (others => '1');
                en_reg_acc <= 1;
            end if;

            --! REVER, tenho de ficar neste estado até os stages estarem todos cheios. Só a partir daí é que a cada ciclo, chega um valor novo ao accumulator.
            if layer0_counter = 7 then
                next_state = s_pipelineRun; -- pipeline filled, go to "run" state   --! Isto devia ir para outro processo que define as transições do estado
            end if;



            --* s_pipelineRun -------------------------------------------
            -- Defining addresses
            IM_address <= std_logic_vector(8 * img + row); -- k/112 is converted into "row" since the pixels are processed 1 row at a time (112 pixels per row)
            WM0_address <= std_logic_vector(7 * hAddress + row);
            --! MISSING WM1_address
            
            -- Defaults
            hValid <= '0';
            en_reg_h <= '0';
            en_reg_acc <= '1';
            row <= row+1;

            --* Layer 0
            en_reg_la0 <= (others => '1');

            if row = 7 then -- if all rows have been processed, store the value+address of h and reset the counter
                en_reg_h <= '1';
                h_valid <= '1';
                hAddress_old <= hAddress;
                hAddress <= hAddress+1;
                reset_accum <= '1';
                row <= 0;
            end if;


            --* Layer 1
            if hValid = '1' then
                en_reg_la1_st1 <= '1';
            else
                en_reg_la1_st1 <= '0';
            end if;

            if en_reg_la1_st1 = '1' then
                en_reg_la0_st2 <= '1';
            else
                en_reg_la1_st2 <= '0';
            end if;

            if en_reg_la1_st2 <= '1' then
                en_reg_la1_out <= '1';
            else
                en_reg_la1_out <= '0';
            end if;



        end if;
    end process;

end behavioral;