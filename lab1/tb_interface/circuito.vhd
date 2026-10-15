library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity circuito is
  port (
    clk           : in  std_logic;
    rst           : in  std_logic; 
    equals        : in  std_logic;
    OPER          : in  std_logic_vector(1 downto 0);
    oper_avail    : in  std_logic;
    VALUE         : in  std_logic_vector(14 downto 0);
    overflow_flag : out std_logic;
    RESULT        : out std_logic_vector(14 downto 0)
  );
end circuito;

architecture Behavioral of circuito is

  -- Component Declarations
  component control_unit is
    port (
      rst         : in  std_logic;
      clk         : in  std_logic;
      equals      : in  std_logic;
      oper_avail  : in  std_logic;
      OPER        : in  std_logic_vector(1 downto 0);
      ALU_SEL     : out std_logic_vector(1 downto 0);
      en_r1, en_r2: out std_logic;
      en_accum    : out std_logic;
      display_sel : out std_logic
    );
  end component;

  component datapath is 
    port (
      VALUE        : in  std_logic_vector(14 downto 0);
      ALU_SEL      : in  std_logic_vector(1 downto 0);
      en_accum     : in  std_logic;
      rst          : in  std_logic;
      en_r1        : in  std_logic;
      en_r2        : in  std_logic;
      display_sel  : in  std_logic;
      clk          : in  std_logic;
      overflow_flag: out std_logic;
      RESULT       : out std_logic_vector(14 downto 0)
    );
  end component;

  -- Internal Interconnect Signals
  signal ALU_SEL     : std_logic_vector(1 downto 0);
  signal en_r1       : std_logic;
  signal en_r2       : std_logic;
  signal en_accum    : std_logic;
  signal display_sel : std_logic;

begin

  -- Instantiation of Control Unit
  inst_control : control_unit
    port map (
      rst         => rst,
      clk         => clk,
      equals      => equals,
      oper_avail  => oper_avail,
      OPER        => OPER,
      ALU_SEL     => ALU_SEL,
      en_r1       => en_r1,
      en_r2       => en_r2,
      en_accum    => en_accum,
      display_sel => display_sel
    );

  -- Instantiation of Datapath
  inst_datapath : datapath
    port map (
      VALUE         => VALUE,
      ALU_SEL       => ALU_SEL,
      en_accum      => en_accum,
      rst           => rst,
      en_r1         => en_r1,
      en_r2         => en_r2,
      display_sel   => display_sel,
      clk           => clk,
      overflow_flag => overflow_flag,
      RESULT        => RESULT
    );

end Behavioral;