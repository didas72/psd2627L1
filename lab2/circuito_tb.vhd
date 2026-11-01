library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuito_tb is
end circuito_tb;

architecture behavior of circuito_tb is

  component circuito
    port (
      clk     : in  std_logic;
      rst     : in  std_logic;
      done    : out std_logic;
      we      : out std_logic;
      DataOut : out std_logic_vector(31 downto 0)
    );
  end component;

  -- Inputs
  signal clk : std_logic := '0';
  signal rst : std_logic := '0';

  -- Outputs
  signal done    : std_logic;
  signal we      : std_logic;
  signal DataOut : std_logic_vector(31 downto 0);

  -- Sinal para atrasar a leitura em 1 ciclo de relogio
  signal we_d1   : std_logic := '0';

  constant clk_period : time := 10 ns;
---- Mem 0
--  type expected_array is array (0 to 15) of std_logic_vector(31 downto 0);
--  constant EXPECTED_C : expected_array := (
--    0  => x"00000000", -- C[0]  = 0
--    1  => x"0000D7E6", -- C[1]  = 55270
--    2  => x"00000000", -- C[2]  = 0
--    3  => x"00000000", -- C[3]  = 0
--    4  => x"00000000", -- C[4]  = 0
--    5  => x"00000000", -- C[5]  = 0
--    6  => x"00000000", -- C[6]  = 0
--    7  => x"00002A50", -- C[7]  = 10832
--    8  => x"00000000", -- C[8]  = 0
--    9  => x"00000000", -- C[9]  = 0
--    10 => x"00000000", -- C[10] = 0
--    11 => x"00005C99", -- C[11] = 23705
--    12 => x"00000000", -- C[12] = 0
--    13 => x"00000000", -- C[13] = 0
--    14 => x"0001441B", -- C[14] = 82971
--    15 => x"00008B49"  -- C[15] = 35657
--  );
  
--   --Mem 1 
--  type expected_array is array (0 to 15) of std_logic_vector(31 downto 0);
--  constant EXPECTED_C : expected_array := (
--     0 => x"0000226A", -- C[0]  = 8810
--     1 => x"00000000", -- C[1]  = 0
--     2 => x"00000000", -- C[2]  = 0
--     3 => x"00000000", -- C[3]  = 0
--     4 => x"0000BE55", -- C[4]  = 48725
--     5 => x"0000F0E5", -- C[5]  = 61669
--     6 => x"00006AE9", -- C[6]  = 27369
--     7 => x"00000000", -- C[7]  = 0
--     8 => x"000044D8", -- C[8]  = 17624
--     9 => x"00000000", -- C[9]  = 0
--    10 => x"00002A5C", -- C[10] = 10844
--    11 => x"00001662", -- C[11] = 5730
--    12 => x"0000B5DA", -- C[12] = 46554
--    13 => x"00006E21", -- C[13] = 28193
--    14 => x"00006847", -- C[14] = 26695
--    15 => x"00000000"  -- C[15] = 0
--  );

--  --Mem 2 
--  type expected_array is array (0 to 15) of std_logic_vector(31 downto 0);
--  constant EXPECTED_C : expected_array := (
--     0 => x"000001A7", -- C[0]  = 423
--     1 => x"00000000", -- C[1]  = 0
--     2 => x"00000000", -- C[2]  = 0
--     3 => x"0000C47A", -- C[3]  = 50298
--     4 => x"00000000", -- C[4]  = 0
--     5 => x"00000000", -- C[5]  = 0
--     6 => x"0000E6FD", -- C[6]  = 59133
--     7 => x"000041CE", -- C[7]  = 16846
--     8 => x"00000000", -- C[8]  = 0
--     9 => x"00000000", -- C[9]  = 0
--    10 => x"00000000", -- C[10] = 0
--    11 => x"00000000", -- C[11] = 0
--    12 => x"00000000", -- C[12] = 0
--    13 => x"00001CEE", -- C[13] = 7406
--    14 => x"00000000", -- C[14] = 0
--    15 => x"00000000"  -- C[15] = 0
--  );

--  --Mem 3 
--  type expected_array is array (0 to 15) of std_logic_vector(31 downto 0);
--  constant EXPECTED_C : expected_array := (
--     0 => x"00000000", -- C[0]  = 0
--     1 => x"00007701", -- C[1]  = 30465
--     2 => x"00000000", -- C[2]  = 0
--     3 => x"00001BF7", -- C[3]  = 7159
--     4 => x"0000044F", -- C[4]  = 1103
--     5 => x"00001A0A", -- C[5]  = 6666
--     6 => x"00000000", -- C[6]  = 0
--     7 => x"0000349C", -- C[7]  = 13468
--     8 => x"00000000", -- C[8]  = 0
--     9 => x"00000000", -- C[9]  = 0
--    10 => x"00000000", -- C[10] = 0
--    11 => x"00000000", -- C[11] = 0
--    12 => x"0000C8EC", -- C[12] = 51436
--    13 => x"0000D866", -- C[13] = 55398
--    14 => x"00000000", -- C[14] = 0
--    15 => x"000015FB"  -- C[15] = 5627
--  );

-- --Mem 4 (
--  type expected_array is array (0 to 15) of std_logic_vector(31 downto 0);
--  constant EXPECTED_C : expected_array := (
--     0 => x"0000367C", -- C[0]  = 13948
--     1 => x"00003CAC", -- C[1]  = 15532
--     2 => x"0000687E", -- C[2]  = 26750
--     3 => x"00000000", -- C[3]  = 0
--     4 => x"00005A9D", -- C[4]  = 23197
--     5 => x"00005790", -- C[5]  = 22416
--     6 => x"00000000", -- C[6]  = 0
--     7 => x"0000057D", -- C[7]  = 1405
--     8 => x"00003040", -- C[8]  = 12352
--     9 => x"00000000", -- C[9]  = 0
--    10 => x"00000000", -- C[10] = 0
--    11 => x"000049AC", -- C[11] = 18860
--    12 => x"00000000", -- C[12] = 0
--    13 => x"00008E1F", -- C[13] = 36383
--    14 => x"00000000", -- C[14] = 0
--    15 => x"00000000"  -- C[15] = 0
--  );

---- Mem 5 
--  type expected_array is array (0 to 15) of std_logic_vector(31 downto 0);
--  constant EXPECTED_C : expected_array := (
--     0 => x"00000000", -- C[0]  = 0
--     1 => x"00000AF2", -- C[1]  = 2802
--     2 => x"00007794", -- C[2]  = 30612
--     3 => x"00000000", -- C[3]  = 0
--     4 => x"00000000", -- C[4]  = 0
--     5 => x"0000DAAB", -- C[5]  = 55979
--     6 => x"00002FE5", -- C[6]  = 12261
--     7 => x"0000BFB4", -- C[7]  = 49076
--     8 => x"000003FE", -- C[8]  = 1022
--     9 => x"00000000", -- C[9]  = 0
--    10 => x"00000000", -- C[10] = 0
--    11 => x"00002722", -- C[11] = 10018
--    12 => x"00000353", -- C[12] = 851
--    13 => x"00000000", -- C[13] = 0
--    14 => x"0000B6F5", -- C[14] = 46837
--    15 => x"00000000"  -- C[15] = 0
--  );

---- Mem 6 
--  type expected_array is array (0 to 15) of std_logic_vector(31 downto 0);
--  constant EXPECTED_C : expected_array := (
--     0 => x"00005A16", -- C[0]  = 23062
--     1 => x"00000000", -- C[1]  = 0
--     2 => x"00000000", -- C[2]  = 0
--     3 => x"0000CF34", -- C[3]  = 53044
--     4 => x"00000000", -- C[4]  = 0
--     5 => x"00000000", -- C[5]  = 0
--     6 => x"00000000", -- C[6]  = 0
--     7 => x"00006106", -- C[7]  = 24838
--     8 => x"00003A71", -- C[8]  = 14961
--     9 => x"0000A281", -- C[9]  = 41601
--    10 => x"00000000", -- C[10] = 0
--    11 => x"00004753", -- C[11] = 18259
--    12 => x"00000000", -- C[12] = 0
--    13 => x"00000000", -- C[13] = 0
--    14 => x"000058E1", -- C[14] = 22753
--    15 => x"000047AD"  -- C[15] = 18349
--  );

---- Mem 8 
--  type expected_array is array (0 to 15) of std_logic_vector(31 downto 0);
--  constant EXPECTED_C : expected_array := (
--     0 => x"00000000", -- C[0]  = 0
--     1 => x"000018B4", -- C[1]  = 6324
--     2 => x"00007412", -- C[2]  = 29714
--     3 => x"00000000", -- C[3]  = 0
--     4 => x"0000400A", -- C[4]  = 16394
--     5 => x"00000000", -- C[5]  = 0
--     6 => x"0000CE67", -- C[6]  = 52839
--     7 => x"00000000", -- C[7]  = 0
--     8 => x"00000000", -- C[8]  = 0
--     9 => x"000001F4", -- C[9]  = 500
--    10 => x"00004D0D", -- C[10] = 19725
--    11 => x"000007F8", -- C[11] = 2040
--    12 => x"000038BB", -- C[12] = 14523
--    13 => x"00000000", -- C[13] = 0
--    14 => x"0000A284", -- C[14] = 41604
--    15 => x"000012A8"  -- C[15] = 4776
--  );

-- Mem 9 
  type expected_array is array (0 to 15) of std_logic_vector(31 downto 0);
  constant EXPECTED_C : expected_array := (
     0 => x"0000AD23", -- C[0]  = 44323
     1 => x"00000000", -- C[1]  = 0
     2 => x"00003DCA", -- C[2]  = 15818
     3 => x"00009F33", -- C[3]  = 40755
     4 => x"00004AD0", -- C[4]  = 19152
     5 => x"00000000", -- C[5]  = 0
     6 => x"00001CD7", -- C[6]  = 7383
     7 => x"000013B6", -- C[7]  = 5046
     8 => x"00002F6C", -- C[8]  = 12140
     9 => x"0000268D", -- C[9]  = 9869
    10 => x"00000000", -- C[10] = 0
    11 => x"00006171", -- C[11] = 24945
    12 => x"00000820", -- C[12] = 2080 
    13 => x"00000000", -- C[13] = 0
    14 => x"00000000", -- C[14] = 0
    15 => x"00001E40"  -- C[15] = 7744
  );
  
  signal out_idx : integer range 0 to 15 := 0;

begin

  uut: circuito
    port map (
      clk     => clk,
      rst     => rst,
      done    => done,
      we      => we,
      DataOut => DataOut
    );

  clk <= not clk after clk_period/2;

  -- Stimulus process
  stim_proc: process
  begin
    rst <= '1';
    wait for 100 ns;

    rst <= '0';
    wait until done = '1';
    report "--- First execution completed ---" severity note;

    wait for 200 ns;

    rst <= '1';
    wait for 50 ns;
    rst <= '0';

    wait until done = '1';
    report "--- Second execution completed ---" severity note;
    wait for 100 ns;

    wait;
  end process;

  -- Synchronous output checking process
  check_proc: process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        out_idx <= 0;
        we_d1   <= '0'; 
      else
        we_d1 <= we;

       
        if we_d1 = '1' then
          assert DataOut = EXPECTED_C(out_idx)
            report "ERROR C[" & integer'image(out_idx) & "]: " &
                   "Result = " & integer'image(to_integer(unsigned(DataOut))) & 
                   ", Expected = " & integer'image(to_integer(unsigned(EXPECTED_C(out_idx))))
            severity error;

          if DataOut = EXPECTED_C(out_idx) then
            report "SUCCESS: C[" & integer'image(out_idx) & "] = " & 
                   integer'image(to_integer(unsigned(DataOut))) & " (Correct)"
              severity note;
          end if;

          if out_idx < 15 then
            out_idx <= out_idx + 1;
          else
            out_idx <= 0;
          end if;
        end if;
      end if;
    end if;
  end process;

end behavior;