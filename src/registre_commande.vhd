library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registre_commande is
  port
  (
    CLK : in std_logic;
    DataIn : in std_logic;
    reset : in std_logic;
    WE : in std_logic;
    DataOut : out std_logic
  );
end entity;

architecture behavior_registre_commande of registre_commande is
  signal Data : std_logic;
  
  begin
    
  DataOut <= Data;
  
    process(CLK, reset)
    begin
      if(reset = '1') then
        Data <= '0';
      else
        if(rising_edge(CLK)) then
          if(WE = '1') then
            Data <= DataIn;
          end if;
        end if;
      end if;
    end process;
end architecture;