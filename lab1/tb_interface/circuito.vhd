library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity circuito is
  port (
    clk           : in  std_logic;
    rst           : in  std_logic;
    done          : out std_logic;
    we            : out std_logic;
    DataOut       : out std_logic_vector(31 downto 0) 
  );
end circuito;

architecture Behavioral of circuito is


  signal A0, A1, A2, A3              : std_logic_vector(7 downto 0);
  signal B0, B1, B2, B3              : std_logic_vector(7 downto 0);
  signal weight_addr                 : std_logic_vector(7 downto 0);
  signal output_addr                 : std_logic_vector(3 downto 0); 
  signal input_addr                  : std_logic_vector(3 downto 0);
  signal aux_input_addr              : std_logic_vector(9 downto 0);
  signal aux_output_addr             : std_logic_vector(9 downto 0);
  signal aux_weight_addr             : std_logic_vector(9 downto 0);
  signal en_accum, reset_accum       : std_logic;
  signal en_r1, en_r2                : std_logic;
  signal input_select                : std_logic;
  signal C                           : std_logic_vector(31 downto 0);
  signal aux_we                      : std_logic;
  
  
  
  -- Component Declarations
  component control_unit is
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
  end component;

  component IMemB is
    port (
      clk   : in  std_logic;
      addr  : in  std_logic_vector(9 downto 0);
      data0 : out std_logic_vector(7 downto 0);
      data1 : out std_logic_vector(7 downto 0);
      data2 : out std_logic_vector(7 downto 0);
      data3 : out std_logic_vector(7 downto 0)
    );
  end component;

  component WMemA is
    port (
      clk   : in  std_logic;
      addr  : in  std_logic_vector(9 downto 0);
      data0 : out std_logic_vector(7 downto 0);
      data1 : out std_logic_vector(7 downto 0);
      data2 : out std_logic_vector(7 downto 0);
      data3 : out std_logic_vector(7 downto 0)
    );
  end component;

  component OMemC is
    port (
      clk     : in  std_logic;
      addr    : in  std_logic_vector(9 downto 0);
      we      : in  std_logic;
      dataIN  : in  std_logic_vector(31 downto 0);
      dataOUT : out std_logic_vector(31 downto 0)
    );
  end component;

  component datapath is
    port (
      en_accum     : in  std_logic;
      reset        : in  std_logic;
      en_r1        : in  std_logic;
      en_r2        : in  std_logic;
      reset_accum  : in  std_logic;
      clk          : in  std_logic;
      input_select : in  std_logic;
      A0, A2, B0   : in std_logic_vector(7 downto 0);
      B2, A1, A3   : in std_logic_vector(7 downto 0);
      B1, B3       : in std_logic_vector(7 downto 0);
      C            : out std_logic_vector(31 downto 0)
    );
  end component;

begin

  -- Instantiation of Control Unit
  inst_control : control_unit
    port map (
      clk          => clk,
      rst          => rst,
      en_accum     => en_accum,
      en_r1        => en_r1,
      en_r2        => en_r2,
      reset_accum  => reset_accum,
      input_select => input_select,
      input_addr   => input_addr,
      weight_addr  => weight_addr,
      output_addr  => output_addr,
      done         => done,
      we           => aux_we   -- write enable
    );

  -- Instantiation of IMemB
  inst_imemb : IMemB
    port map (
      clk   => clk,
      addr  => aux_input_addr,
      data0 => B0,
      data1 => B1,
      data2 => B2,
      data3 => B3
    );

  -- Instantiation of WMemA
  inst_wmema : WMemA
    port map (
      clk   => clk,
      addr  => aux_weight_addr,
      data0 => A0,
      data1 => A1,
      data2 => A2,
      data3 => A3
    );

  -- Instantiation of OMemC
  inst_omemc : OMemC
    port map (
      clk     => clk,
      addr    => aux_output_addr,
      we      => aux_we,
      dataIN  => C,
      dataOUT => dataOUT 
    );

  -- Instantiation of Datapath
  inst_datapath : datapath
    port map (
      clk          => clk,
      reset        => rst,
      en_accum     => en_accum,
      en_r1        => en_r1,
      en_r2        => en_r2,
      reset_accum  => reset_accum,
      input_select => input_select,
      A0           => A0,
      A2           => A2,
      B0           => B0,
      B2           => B2,
      A1           => A1,
      A3           => A3,
      B1           => B1,
      B3           => B3,
      C            => C
    );
    
    we <= aux_we;
    aux_input_addr   <= "000000" & input_addr;
    aux_output_addr  <= "000000" & output_addr;
    aux_weight_addr  <= "00" & weight_addr;
    
end Behavioral;