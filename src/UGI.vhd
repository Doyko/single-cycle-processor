library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UGI is
  port
  (
    Offset : in std_logic_vector(23 downto 0);
    nPCsel : in std_logic;
    reset, CLK : in std_logic;
    instruction : out std_logic_vector(31 downto 0);
    PCout : out std_logic_vector(31 downto 0)
  );
end entity;

architecture behavior_UGI of UGI is

signal PC, PC1, PCoff, MuxOut, ExtOut : std_logic_vector(31 downto 0);

begin

  mem : entity work.Memoire
  port map (CLK => CLK, DataIn => (others => '0'), Addr => PC(5 downto 0), WrEn => '0', DataOut => instruction);
  mux : entity work.Multiplexeur
  port map (A => PC1, B => PCoff, COM => nPCsel, S => MuxOut);
  Ext : entity work.ExtensionSigne
  generic map (N => 24)
  port map (E => Offset, S => ExtOut);

  PCout <= PC;
  PC1 <= std_logic_vector(unsigned(PC) + 1);
  PCoff <= std_logic_vector(to_unsigned(to_integer(signed(Extout)) + to_integer(unsigned(PC1)),32));

  process(CLK, reset)
  begin

    if reset = '1' then
      PC <= (others => '0');
    else
      if rising_edge(CLK) then
        PC <= MuxOut;
      end if;
    end if;
  end process;
end architecture;
