library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity ExtensionSigne is
  generic (N : integer:= 16);
  port 
  (
    E : in std_logic_vector (N - 1 downto 0);
    S : out std_logic_vector (31 downto 0)
  );
end entity;

architecture behavior_ExtensionSigne of ExtensionSigne is
begin
  
  S <= SXT(E, 32);
    
end architecture;
