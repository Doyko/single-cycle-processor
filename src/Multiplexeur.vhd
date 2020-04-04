library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multiplexeur is
  generic (N : integer:= 32);
  port 
  (
    A, B : in std_logic_vector (N - 1 downto 0);
    COM : in std_logic;
    S : out std_logic_vector (N - 1 downto 0)
  );
end entity;

architecture behavior_Multiplexeur of Multiplexeur is
begin
  
  S <= A when (COM = '0') else
       B when (COM = '1');
    
end architecture;