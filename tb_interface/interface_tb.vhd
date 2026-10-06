library ieee;
use ieee.std_logic_1164.all;

entity interface_tb is
end interface_tb;

architecture behavior of interface_tb is


  component interface
    port (
      clk                          : in  std_logic;
      btnC, btnU, btnL, btnR, btnD : in  std_logic;
      sw                           : in  std_logic_vector(15 downto 0);
      led                          : out std_logic_vector(15 downto 0);
      an                           : out std_logic_vector(3 downto 0);
      seg                          : out std_logic_vector(6 downto 0);
      dp                           : out std_logic
    );
  end component;

  signal clk  : std_logic := '0';
  signal btnC : std_logic := '0';
  signal btnU : std_logic := '0';
  signal btnL : std_logic := '0';
  signal btnR : std_logic := '0';
  signal btnD : std_logic := '0';
  signal sw   : std_logic_vector(15 downto 0) := (others => '0');


  signal led : std_logic_vector(15 downto 0);
  signal an  : std_logic_vector(3 downto 0);
  signal seg : std_logic_vector(6 downto 0);
  signal dp  : std_logic;

  constant clk_period : time := 10 ns;
  constant btn_press_time : time := 11 ms;

begin

  
  uut: interface port map (
    clk  => clk,
    btnC => btnC,
    btnU => btnU,
    btnL => btnL,
    btnR => btnR,
    btnD => btnD,
    sw   => sw,
    led  => led,
    an   => an,
    seg  => seg,
    dp   => dp
  );


  clk <= not clk after clk_period/2;


  stim_proc: process
  begin
    wait for 100 ns;


    -- SUM

    -- Initial reset
    btnC <= '1';
    wait for btn_press_time;
    btnC <= '0';
    wait for btn_press_time;

    -- first number
    sw <= "0" & "000000000000001"; 
    wait for 100 ns;

    -- Pressiona BTNL for SUM operantion 
    btnL <= '1';
    wait for btn_press_time;
    btnL <= '0';
    wait for btn_press_time;

    -- Define second number
    sw(14 downto 0) <= "000000000000010";
    wait for 100 ns;

    -- Press equals
    btnR <= '1';
    wait for btn_press_time;
    btnR <= '0';
    wait for btn_press_time;
    
    -- MUL
    -- reset
    btnC <= '1';
    wait for btn_press_time;
    btnC <= '0';
    wait for btn_press_time;
    
    -- first number
    sw <= "0" & "000000000000001"; 
    wait for 100 ns;
    
    -- Pressiona BTNU for MUL operantion 
    btnU <= '1';
    wait for btn_press_time;
    btnU <= '0';
    wait for btn_press_time;
    
    -- Define second number
    sw(14 downto 0) <= "000000000000100";
    wait for 100 ns;
    
    
    -- Press equals
    btnR <= '1';
    wait for btn_press_time;
    btnR <= '0';
    wait for btn_press_time;
    
    
    
    
    -- OR
    -- reset
    btnC <= '1';
    wait for btn_press_time;
    btnC <= '0';
    wait for btn_press_time;
    
    -- first number
    sw <= "1" & "000000000000011"; 
    wait for 100 ns;
    
    -- Pressiona BTNU for MUL operantion 
    btnL <= '1';
    wait for btn_press_time;
    btnL <= '0';
    wait for btn_press_time;
    
    -- Define second number
    sw(14 downto 0) <= "000000000000110";
    wait for 100 ns;
    
    
    -- Press equals
    btnR <= '1';
    wait for btn_press_time;
    btnR <= '0';
    wait for btn_press_time;
    
    
    
    -- SHIFT    
    -- reset
    btnC <= '1';
    wait for btn_press_time;
    btnC <= '0';
    wait for btn_press_time;
    
    -- first number
    sw <= "1" & "000000000000001"; 
    wait for 100 ns;
    
    -- Pressiona BTNU for MUL operantion 
    btnU <= '1';
    wait for btn_press_time;
    btnU <= '0';
    wait for btn_press_time;
    
    
        -- SHIFT    
    -- reset
    btnC <= '1';
    wait for btn_press_time;
    btnC <= '0';
    wait for btn_press_time;
    
    -- first number
    sw <= "1" & "000000000000010"; 
    wait for 100 ns;
    
    -- Pressiona BTNU for MUL operantion 
    btnU <= '1';
    wait for btn_press_time;
    btnU <= '0';
    wait for btn_press_time;
    
        -- SHIFT    
    -- reset
    btnC <= '1';
    wait for btn_press_time;
    btnC <= '0';
    wait for btn_press_time;
    
    -- first number
    sw <= "1" & "000000000000100"; 
    wait for 100 ns;
    
    -- Pressiona BTNU for MUL operantion 
    btnU <= '1';
    wait for btn_press_time;
    btnU <= '0';
    wait for btn_press_time;
    
        -- SHIFT    
    -- reset
    btnC <= '1';
    wait for btn_press_time;
    btnC <= '0';
    wait for btn_press_time;
    
    -- first number
    sw <= "1" & "000000000000111"; 
    wait for 100 ns;
    
    -- Pressiona BTNU for MUL operantion 
    btnU <= '1';
    wait for btn_press_time;
    btnU <= '0';
    wait for btn_press_time;

    wait;
  end process;

end behavior;