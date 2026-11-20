library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.multi_number.all;

entity circuito is
  port (
    clk        : in  std_logic;
    rst        : in  std_logic;
    done       : out std_logic;
    we         : out std_logic;
    addr_omemc : out std_logic_vector(9 downto 0);
    DataOut    : out std_logic_vector(31 downto 0)
  );
end circuito;

architecture Behavioral of circuito is


  signal A0, A1, A2, A3              : std_logic_vector(7 downto 0);
  signal B0, B1, B2, B3              : std_logic_vector(7 downto 0);
  signal weight_addr                 : std_logic_vector(7 downto 0);




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
    -- Global controls
    clk          : in std_logic;
    rst          : in std_logic;
    
    -- Control inputs
    en_i_reg     : in std_logic; -- increments input address if set to 1
    en_w0_reg    : in std_logic; -- increments weight0 address if set to 1
    en_w1_reg    : in std_logic; -- increments weight1 address if set to 1
        
    -- Data input buses
    input_bus    : in std_logic_vector((INPUT_WIDTH*MULT_COUNT)-1 downto 0);
    weight0_bus  : in std_logic_vector((WEIGHT0_WIDTH*MULT_COUNT)-1 downto 0);
    weight1_bus  : in std_logic_vector(79 downto 0);  
    input_addr   : out std_logic_vector(2 downto 0);
    weight0_addr : out std_logic_vector(2 downto 0);
    weight1_addr : out std_logic_vector(2 downto 0);  
     
    -- Result output
    result       : out std_logic_vector(3 downto 0)
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
    clk  =>;
    addr =>;
    data =>
    );

  -- Instantiation of WMemA
  inst_wmem0 : WMem0
    port map (
    clk  =>;
    addr =>;
    data =>
    );

  -- Instantiation of OMemC
  inst_wmem1 : WMem1
    port map (
    clk  =>;
    addr =>;
    data =>
    );

  -- Instantiation of Datapath
  inst_datapath : datapath
    port map (
    clk          =>;         
    rst          =>;
    en_i_reg     =>;
    en_w0_reg    =>;
    en_w1_reg    =>;
    input_bus    =>;
    weight0_bus  =>; 
    weight1_bus  =>; 
    input_addr   =>; 
    weight0_addr =>; 
    weight1_addr =>;
    result       =>
    );

end Behavioral;
