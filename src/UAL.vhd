library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UAL is
  port 
  (
    OP : in std_logic_vector (1 downto 0);
    A, B : in std_logic_vector (31 downto 0);
    Y : out std_logic_vector (31 downto 0);
    N : out std_logic
  );
end entity;
  
architecture behavior_UAL of UAL is
Signal res : std_logic_vector(31 downto 0);
begin
  
  res <= std_logic_vector(signed(A) + signed(B)) when (OP = "00") else
       B when (OP = "01") else
       std_logic_vector(signed(A) - signed(B)) when (OP = "10") else
       A when (OP = "11");
       
  N <= res(31);
  Y <= res;
    
end architecture;