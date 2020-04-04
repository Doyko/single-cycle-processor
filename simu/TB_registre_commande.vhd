library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_registre_commande is
end entity;

architecture behav of TB_registre_commande is
  signal TCLK, Treset, TWE : std_logic;
  signal TDataIn : std_logic;
  signal TDataOut : std_logic;
  
  begin
    test : entity work.registre_commande
    port map(CLK => TCLK, reset => Treset, WE => TWE, DataIn => TDataIn, DataOut => TDataOut);
      
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
    TDataIn <= '0';
    TWE <= '0';
    wait for 2 ns;
    TReset <= '0';
    wait for 10 ns;
    TWE <= '1';
    wait for 2 ns;
    TWE <= '0';
    wait for 2 ns;
    TDataIn <= '1';
    wait for 10 ns;
    
    wait;
  end process;
end architecture;