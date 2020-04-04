library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_UGI is
end entity;

architecture behav of TB_UGI is
  signal TOffset : std_logic_vector(23 downto 0);
  signal TnPCsel : std_logic;
  signal Treset, TCLK : std_logic;
  signal Tinstruction : std_logic_vector(31 downto 0);
  
  begin
    
  test_UGI : entity work.UGI
  port map (Offset => TOffset, nPCsel => TnPCsel, reset => Treset, CLK => TCLK, instruction => Tinstruction);
    
  process
  begin
    TCLK <= '0';
    wait for 1 ns;
    TCLK <= '1';
    wait for 1 ns;
  end process;
  
  process
  begin
    Treset <= '1';
    TnPCsel <= '0';
    TOffset <= X"000215";
    
    wait for 1 ns;
    
    Treset <= '0';
    
    wait for 10 ns;
    
    TnPCsel <= '1';
    
    wait for 2 ns;
    
    TnPCsel <= '0';
    
    wait for 10 ns;
    
    wait;
  end process;
  
end architecture;
    