library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_ExtensionSigne is
  
generic (N : integer:= 16);

end entity;

architecture behav of TB_ExtensionSigne is

signal TE : std_logic_vector(N - 1 downto 0);
signal TS : std_logic_vector(31 downto 0);

begin
  
  test : entity work.ExtensionSigne(behavior_ExtensionSigne)
  port map (E => TE, S => TS);
    
  stimuli : process
  begin
    
    TE <= (others => '0');
    wait for 10 ns;
    TE <= (others => '1');
    wait for 10 ns;
    wait;
  end process;
end architecture;