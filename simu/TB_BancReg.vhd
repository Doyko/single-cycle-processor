library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_BancReg is
end entity;

architecture behav of TB_BancReg is
  signal TCLK : std_logic;
  signal TReset : std_logic;
  signal TA, TB, TW : std_logic_vector(31 downto 0);
  signal TRA, TRB, TRW : std_logic_vector(3 downto 0);
  signal TWE : std_logic;
  signal TOP : std_logic_vector(1 downto 0);
  signal TN : std_logic;

begin
  
  Banc : entity work.BancReg(behavior_BancReg)
  port map (CLK => TCLK, Reset => TReset, W => TW, RA => TRA, RB => TRB, RW => TRW, WE => TWE, A => TA, B => TB);
  alu : entity work.UAL(behavior_UAL)
  port map (OP => TOP, A => TA, B => TB, Y => TW, N => TN);
    
  process
  begin
    TCLK <= '1';
    wait for 1 ns;
    TCLK <= '0';
    wait for 1 ns;
  end process;
  
  process
  begin
    TReset <= '1';
    TWE <= '0';
    TOP <= "00";
    TRA <= "0000";
    TRB <= "0000";
    TRW <= "0000";
    
    wait for 1 ns;
    
    TReset <= '0';
    TRA <= X"F";
    TOP <= "11";
    TWE <= '1';
    TRW <= X"1";
    
    wait for 2 ns;
    
    TRA <= X"1";
    TRB <= X"F";
    TOP <= "00";
    TRW <= X"1";
    
    wait for 2 ns;
    
    TRW <= X"2";
    
    wait for 2 ns;
    
    TOP <= "10";
    TRW <= X"3";
    
    wait for 2 ns;
    
    TRA <= X"7";
    TRW <= X"5";
    
    wait for 2 ns;
    
    wait;
  end process;
  
end architecture; 