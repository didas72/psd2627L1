library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.multi_number.all;

entity circuito is
  port (
    clk        : in  std_logic;
    rst        : in  std_logic;
    done       : out std_logic; 
    img        : in  std_logic_vector(3 downto 0);
    start      : in  std_logic;
    hOut       : out std_logic_vector(22-1 downto 0);
    hValid     : out std_logic;
    hAddr      : out std_logic_vector(6 downto 0);
    result     : out std_logic_vector(3 downto 0)
  );
end circuito;

architecture Behavioral of circuito is

  signal weight1_bus     : std_logic_vector(79 downto 0);
  signal weight0_bus     : std_logic_vector((WEIGHT0_WIDTH*MULT_COUNT)-1 downto 0);
  signal input_bus       : std_logic_vector((INPUT_WIDTH*MULT_COUNT)-1 downto 0);
  signal IM_address_out  : std_logic_vector(6 downto 0);
  signal WM0_address_out : std_logic_vector(9 downto 0);
  signal WM1_address_out : std_logic_vector(6 downto 0);

  -- Placeholder control signals until wired to control_unit
  signal en_i_reg        : std_logic;
  signal en_w0_reg       : std_logic;
  signal en_w1_reg       : std_logic;
  signal en_reg_i_buff   : std_logic;
  signal en_reg_w0_buff  : std_logic;
  signal en_reg_w1_buff  : std_logic;
  signal en_reg_la0_stN  : std_logic_vector(8-1 downto 0);
  signal en_reg_la0_acc  : std_logic;
  signal en_reg_h        : std_logic;
  signal en_reg_la1_stN  : std_logic_vector(2-1 downto 0);
  signal en_reg_o        : std_logic;

  component control_unit is
    port (
      IM_address_out  : out std_logic_vector(6 downto 0);
      WM0_address_out : out std_logic_vector(9 downto 0);
      WM1_address_out : out std_logic_vector(6 downto 0);
      img             : in  std_logic_vector(3 downto 0);
      hAddress_out    : out std_logic_vector(6 downto 0);
      hValid_out      : out std_logic;
      done            : out std_logic;
      reset           : in  std_logic;
      start           : in  std_logic;
      clk             : in  std_logic
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
      clk            : in  std_logic;
      rst            : in  std_logic;
      en_i_reg       : in  std_logic;
      en_w0_reg      : in  std_logic;
      en_w1_reg      : in  std_logic;
      en_reg_i_buff  : in  std_logic;
      en_reg_w0_buff : in  std_logic;
      en_reg_w1_buff : in  std_logic;
      en_reg_la0_stN : in  std_logic_vector(8-1 downto 0);
      en_reg_la0_acc : in  std_logic;
      en_reg_h       : in  std_logic;
      en_reg_la1_stN : in  std_logic_vector(2-1 downto 0);
      en_reg_o       : in  std_logic;
      input_bus      : in  std_logic_vector((INPUT_WIDTH*MULT_COUNT)-1 downto 0);
      weight0_bus    : in  std_logic_vector((WEIGHT0_WIDTH*MULT_COUNT)-1 downto 0);
      weight1_bus    : in  std_logic_vector(79 downto 0);
      h_out          : out std_logic_vector(22-1 downto 0);
      result         : out std_logic_vector(3 downto 0)
    );
  end component;

begin

  inst_control : control_unit
    port map (
      IM_address_out  => IM_address_out,
      WM0_address_out => WM0_address_out,
      WM1_address_out => WM1_address_out,
      img             => img,
      hAddress_out    => hAddr,
      hValid_out      => hValid,
      done            => done,
      reset           => rst,
      start           => start,
      clk             => clk
    );

  inst_imem : IMem
    port map (
      clk  => clk,
      addr => IM_address_out,
      data => input_bus
    );

  inst_wmem0 : WMem0
    port map (
      clk  => clk,
      addr => WM0_address_out,
      data => weight0_bus
    );

  inst_wmem1 : WMem1
    port map (
      clk   => clk,
      addr  => WM1_address_out,
      data0 => weight1_bus(7 downto 0),
      data1 => weight1_bus(15 downto 8),
      data2 => weight1_bus(23 downto 16),
      data3 => weight1_bus(31 downto 24),
      data4 => weight1_bus(39 downto 32),
      data5 => weight1_bus(47 downto 40),
      data6 => weight1_bus(55 downto 48),
      data7 => weight1_bus(63 downto 56),
      data8 => weight1_bus(71 downto 64),
      data9 => weight1_bus(79 downto 72)
    );

  inst_datapath : datapath
    port map (
      clk            => clk,
      rst            => rst,
      en_i_reg       => en_i_reg,
      en_w0_reg      => en_w0_reg,
      en_w1_reg      => en_w1_reg,
      en_reg_i_buff  => en_reg_i_buff,
      en_reg_w0_buff => en_reg_w0_buff,
      en_reg_w1_buff => en_reg_w1_buff,
      en_reg_la0_stN => en_reg_la0_stN,
      en_reg_la0_acc => en_reg_la0_acc,
      en_reg_h       => en_reg_h,
      en_reg_la1_stN => en_reg_la1_stN,
      en_reg_o       => en_reg_o,
      input_bus      => input_bus,
      weight0_bus    => weight0_bus,
      weight1_bus    => weight1_bus,
      h_out          => hOut,
      result         => result
    );

end Behavioral;