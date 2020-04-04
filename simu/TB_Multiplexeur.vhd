library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_Miplexeur is
  
generic (N : integer:= 32);

end entity;

architecture behav of TB_Miplexeur is

signal TA, TB : std_logic_vector(N - 1 downto 0);
signal TCOM : std_logic;
signal TS : std_logic_vector(N - 1 downto 0);

begin
  
  test : entity work.Multiplexeur(behavior_Multiplexeur)
  port map (A => TA, B => TB, COM => TCOM, S => TS);
    
  stimuli : process
  begin
    
    TCOM <= '0';
    TA <= (others => '0');
    TB <= (others => '1');
    wait for 10 ns;
    TCOM <= '1';
    wait for 10 ns;
    wait;
  end process;
end architecture;