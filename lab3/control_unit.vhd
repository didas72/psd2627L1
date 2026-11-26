library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity control_unit is
    port (
        IM_address_out  : out std_logic_vector(6 downto 0);
        WM0_address_out : out std_logic_vector(9 downto 0);
        WM1_address_out : out std_logic_vector(6 downto 0);
        img         : in unsigned(3 downto 0); -- there are 16 images which can be selected through the switches
        hAddress_out    : out unsigned(6 downto 0) := (others => '0'); -- each m value indexes a hidden neuron
        hValid_out      : out std_logic;
        done        : out std_logic;
        reset       : in std_logic;
        start       : in std_logic;
        clk         : in std_logic 
    );
end control_unit;

architecture behavioral of control_unit is

    type fsm_state is (s_init, s_pipelineFill, s_pipelineRun, s_pipelineFlush, s_getResult);

    signal current_state, next_state : fsm_state;
    signal layer0_counter : unsigned(3 downto 0) := "1"; -- 7 layers of adders + 1 multiplier
    signal read_done : std_logic;
    signal row : unsigned(2 downto 0) := (others => '0'); -- each image has 7 rows (784 pixels / 112) + 1 empty
    signal en_reg_la0 : std_logic_vector(7 downto 0) := (others => '0'); -- enables of all stages of layer 0
    signal en_reg_acc, en_reg_h : std_logic;
    signal en_reg_la1_st1, en_reg_la1_st2, en_reg_la1_out : std_logic;
    signal IM_address : std_logic_vector(6 downto 0);
    signal WM0_address : std_logic_vector(9 downto 0);
    signal WM1_address : std_logic_vector(6 downto 0);
    signal hValid : std_logic;
    signal hAddress, hAddress_old : unsigned(6 downto 0);
    signal reset_accum : std_logic;

begin

    process (next_state)
    begin
        current_state <= next_state;
    end process;


    process (clk)
    begin
        if rising_edge(clk) then

            case current_state is

                --* s_pipelineFill --------------------------------------------------
                when s_pipelineFill =>
                    -- Defining addresses
                    IM_address <= std_logic_vector(8 * img + row); -- k/112 is converted into "row" since the pixels are processed 1 row at a time (112 pixels per row)
                    WM0_address <= std_logic_vector(7 * hAddress + row);
                    WM1_address <= std_logic_vector(hAddress);
                    
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
                        en_reg_acc <= '1';
                    end if;

                    --! REVER, tenho de ficar neste estado até os stages estarem todos cheios. Só a partir daí é que a cada ciclo, chega um valor novo ao accumulator.
                    if layer0_counter = 7 then
                        next_state <= s_pipelineRun; --* pipeline filled, go to "run" state
                    end if;



                --* s_pipelineRun ---------------------------------------------------
                when s_pipelineRun =>
                    -- Defining addresses
                    IM_address <= std_logic_vector(8 * img + row); -- k/112 is converted into "row" since the pixels are processed 1 row at a time (112 pixels per row)
                    WM0_address <= std_logic_vector(7 * hAddress + row);
                    WM1_address <= std_logic_vector(hAddress);
                    
                    -- Defaults
                    hValid <= '0';
                    en_reg_h <= '0';
                    en_reg_acc <= '1';
                    row <= row+1;

                    --* Layer 0
                    en_reg_la0 <= (others => '1');

                    if row = 7 then -- if all rows have been processed, store the value+address of h and reset the counter
                        if hAddress = 128 then  -- Check hAddress == 128
                            next_state <= s_pipelineFlush;  --* Change state
                        end if;
                        en_reg_h <= '1';
                        hValid <= '1';
                        hAddress_old <= hAddress;
                        hAddress <= hAddress+1;
                        reset_accum <= '1';
                        row <= "0";
                    end if;


                    --* Layer 1
                    if hValid = '1' then
                        en_reg_la1_st1 <= '1';
                    else
                        en_reg_la1_st1 <= '0';
                    end if;

                    if en_reg_la1_st1 = '1' then
                        en_reg_la1_st2 <= '1';
                    else
                        en_reg_la1_st2 <= '0';
                    end if;

                    if en_reg_la1_st2 <= '1' then
                        en_reg_la1_out <= '1';
                    else
                        en_reg_la1_out <= '0';
                    end if;


                
                --* s_pipelineFlush -------------------------------------------------
                when s_pipelineFlush =>
                    -- Defining addresses
                    IM_address <= std_logic_vector(8 * img + row); -- k/112 is converted into "row" since the pixels are processed 1 row at a time (112 pixels per row)
                    WM0_address <= std_logic_vector(7 * hAddress + row);
                    WM1_address <= std_logic_vector(hAddress);

                    --* Layer 0
                    en_reg_la0 <= (others => '1');

                    if row = 7 then -- if all rows have been processed, store the value+address of h and reset the counter
                        en_reg_h <= '1';
                        hValid <= '1';
                        hAddress_old <= hAddress;
                    end if;

                    --* Layer 1
                    if hValid = '1' then
                        en_reg_la1_st1 <= '1';
                    else
                        en_reg_la1_st1 <= '0';
                    end if;

                    if en_reg_la1_st1 = '1' then
                        en_reg_la1_st2 <= '1';
                    else
                        en_reg_la1_st2 <= '0';
                    end if;

                    if en_reg_la1_st2 <= '1' then
                        en_reg_la1_out <= '1';
                        
                        next_state <= s_getResult;  --* Change state
                    else
                        en_reg_la1_out <= '0';
                    end if;



                    --* s_getResult -------------------------------------------------
                    --when s_getResult =>
                        --! Finish this
                        
            end case;
        end if;
    end process;
    
    IM_address_out <= IM_address;
    WM0_address_out <= WM0_address;
    WM1_address_out <= WM1_address;
    hAddress_out <= hAddress; 
    hValid_out <= hValid;

end behavioral;