library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.multi_number.all;

entity circuito is
  port (
    clk        : in  std_logic;
    rst        : in  std_logic;
    img        : in  std_logic;
    start      : in  std_logic;
    hOut       : out std_logic_vector(22-1 downto 0);
    hValid     : out std_logic;
    hAddr      : out std_logic_vector(6 downto 0);
    result     : out std_logic_vector(3 downto 0)
  );
end circuito;

architecture Behavioral of circuito is


  signal weight1_bus: std_logic_vector(79 downto 0);
  signal weight0_bus: std_logic_vector((WEIGHT0_WIDTH*MULT_COUNT)-1 downto 0);
  signal input_bus: std_logic_vector((INPUT_WIDTH*MULT_COUNT)-1 downto 0);


  -- Component Declarations
  component control_unit is
    port (

    );
  end component;

  component IMem is
    port (
    clk  : in  std_logic;
    addr : in  std_logic_vector(6 downto 0);
    data : out std_logic_vector(447 downto 0)
    );
  end component;

  component WMem0 is
    port (
    clk  : in  std_logic;
    addr : in  std_logic_vector(9 downto 0);
    data : out std_logic_vector(895 downto 0)
    );
  end component;

  component WMem1 is
    port (
    clk   : in  std_logic;
    addr  : in  std_logic_vector(6 downto 0);
    data0 : out std_logic_vector(7 downto 0);
    data1 : out std_logic_vector(7 downto 0);
    data2 : out std_logic_vector(7 downto 0);
    data3 : out std_logic_vector(7 downto 0);
    data4 : out std_logic_vector(7 downto 0);
    data5 : out std_logic_vector(7 downto 0);
    data6 : out std_logic_vector(7 downto 0);
    data7 : out std_logic_vector(7 downto 0);
    data8 : out std_logic_vector(7 downto 0);
    data9 : out std_logic_vector(7 downto 0)
    );
  end component;

  component datapath is
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
        -- Output registers
        en_reg_o : in std_logic; -- save the result of the NN if set to 1

        -- === Data input buses ===
        input_bus : in std_logic_vector((INPUT_WIDTH*MULT_COUNT)-1 downto 0);
        weight0_bus : in std_logic_vector((WEIGHT0_WIDTH*MULT_COUNT)-1 downto 0);
        weight1_bus : in std_logic_vector(79 downto 0);

        -- === Address output buses ===
        --input_addr : out std_logic_vector(2 downto 0);
        --weight0_addr : out std_logic_vector(2 downto 0);
        --weight1_addr : out std_logic_vector(2 downto 0);

        -- === Result output buses ===
        h_out : out std_logic_vector(22-1 downto 0);

        -- === Result output ===
        result : out std_logic_vector(3 downto 0)
    );
  end component;

begin

    
    
  -- Instantiation of Control Unit
  inst_control : control_unit
    port map (

    );

  -- Instantiation of IMemB
  inst_imem : IMem
    port map (
    clk  => clk;
    addr =>;
    data => input_bus
    );

  -- Instantiation of WMemA
  inst_wmem0 : WMem0
    port map (
    clk  => clk;
    addr =>;
    data => weight0_bus
    );

  -- Instantiation of OMemC
  inst_wmem1 : WMem1
    port map (
    clk  => clk;
    addr =>;
    data0 : weight1_bus(7 downto 0);
    data1 : weight1_bus(15 downto 8);
    data2 : weight1_bus(23 downto 16);
    data3 : weight1_bus(31 downto 24);
    data4 : weight1_bus(39 downto 32);
    data5 : weight1_bus(47 downto 40);
    data6 : weight1_bus(55 downto 48);
    data7 : weight1_bus(63 downto 56);
    data8 : weight1_bus(71 downto 64);
    data9 : weight1_bus(79 downto 72)
    );

  -- Instantiation of Datapath
  inst_datapath : datapath
    port map (
        clk             =>clk;
        rst             =>rst;
        en_i_reg        =>;
        en_w0_reg       =>;
        en_w1_reg       =>;
        en_reg_i_buff   =>;
        en_reg_w0_buff  =>;
        en_reg_la0_stN  =>;              
        en_reg_w1_buff  => ;              
        en_reg_la0_acc  => ;              
        en_reg_h        => ;         
        en_reg_la1_stN  => ;               
        en_reg_o        => ;              
        input_bus       => input_bus;        
        weight0_bus     => weight0_bus;   
        weight1_bus     => weight1_bus;   
        --input_addr      => ;  
        --weight0_addr    => ;    
        --weight1_addr    => ;    
        h_out           => ;         
        result          =>          
    );

end Behavioral;
