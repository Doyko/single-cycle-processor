library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_UAL is
end entity;

architecture behav of TB_UAL is

signal TOP : std_logic_vector(1 downto 0);
signal TA, TB, TY : std_logic_vector(31 downto 0);
signal TN : std_logic;

begin
  
  test : entity work.UAL(behavior_UAL)
  port map (OP => TOP, A => TA, B => TB, Y => TY, N => TN);
    
  stimuli : process
  begin
    
    TOP <= "00";
    TA <= (others => '0');
    TB <= (others => '0');
    wait for 10 ns;
    TA <= std_logic_vector(to_signed(17, 32));
    wait for 10 ns;
    TB <= std_logic_vector(to_signed(31, 32));
    wait for 10 ns;
    TOP <= "01";
    wait for 10 ns;
    TOP <= "10";
    wait for 10 ns;
    TOP <= "11";
    wait for 10 ns;
    
    wait;
    
  end process;
end architecture;