library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Memoire is
  port
  (
    CLK : in std_logic;
    DataIn : in std_logic_vector(31 downto 0);
    Addr : in std_logic_vector(5 downto 0);
    WrEn : in std_logic;
    DataOut : out std_logic_vector(31 downto 0)
  );
end entity;

architecture behavior_Memoire of Memoire is

--Declaration type tableau mamoire
type table is array(63 downto 0) of std_logic_vector(31 downto 0);

--Fonction d'initialisation du banc de registres
function init_Mem return table is variable result : table;
begin
  
  for i in 63 downto 0 loop
    result(i) := std_logic_vector(to_unsigned(i,32)); 
  end loop;
  
  
  return result; 
end init_Mem;

signal Mem : table:=init_Mem;

begin
  
  DataOut <= Mem(to_integer(unsigned(Addr)));
  
  process(CLK)
  begin
    if rising_edge(CLK) then
      if WrEn = '1' then
        Mem(to_integer(unsigned(Addr))) <= DataIn;          
      end if;
    end if;
  end process;        
  
end architecture;

