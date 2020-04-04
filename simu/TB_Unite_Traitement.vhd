library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_unite_Traitement is
end entity;

architecture behav of TB_unite_Traitement is
  signal TCLK : std_logic;
  signal TReset : std_logic;
  signal TA, TB, TW, TALUout, TDataout, TExtout, TMuxout : std_logic_vector(31 downto 0);
  signal TRA, TRB, TRW : std_logic_vector(3 downto 0);
  signal TWE, TWrEn : std_logic;
  signal TOP : std_logic_vector(1 downto 0);
  signal TN : std_logic;
  signal TImm : std_logic_vector(15 downto 0);
  signal TComReg, TComMem : std_logic;

begin
  
  Banc : entity work.BancReg(behavior_BancReg)
  port map (CLK => TCLK, Reset => TReset, W => TW, RA => TRA, RB => TRB, RW => TRW, WE => TWE, A => TA, B => TB);
  alu : entity work.UAL(behavior_UAL)
  port map (OP => TOP, A => TA, B => TMuxout, Y => TALUout, N => TN);
  DataMem : entity work.Memoire
  port map (CLK => TCLK, DataIn => TB, Addr => TALUout(5 downto 0) , WrEn => TWrEn, DataOut => TDataout);
  Extender : entity work.ExtensionSigne
  port map (E => TImm, S => TExtout);
  MuxReg : entity work.Multiplexeur
  port map (A => TB, B => TExtout, COM => TComReg, S => TMuxout);
  MuxMem : entity work.Multiplexeur
  port map (A => TALUout, B => TDataout, COM => TComMem, S => TW);
  
    
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
    
    wait for 1 ns;
    
    TReset <= '0';
    
    wait for 2 ns;
    
    TImm <= X"0012";
    TComReg <= '1';
    TComMem <='0';
    TOP <= "00";
    TRA <= X"F";
    TWE <= '1';
    TRW <= X"0";
    
    wait for 2 ns;
    
    TOP <= "10";
    TRW <= X"1";
    
    wait for 2 ns;
    
    TCOMReg <= '0';
    TOP <= "00";
    TRA <= X"0";
    TRB <= X"1";
    TRW <= X"1";
    
    wait for 2 ns;
    
    TOP <= "10";
    TRW <= X"2";
    
    wait for 2 ns;
    
    TOP <= "11";
    TRW <= X"3";
    
    wait for 2 ns;
    
    TWE <='0';
    TImm <= X"000C";
    TComReg <= '1';
    TOP <= "01";
    TWrEn <= '1';
    
    wait for 2 ns;
    
    TComMem <= '1';
    TWrEn <= '0';
    TRW <= X"4";
    TWE <= '1';
    
    wait for 2 ns;
    
    wait;
  end process;   
      
end architecture;
