library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_Proco is
end entity;

architecture behav of TB_Proco is
    signal CLK, Reset : std_logic;
    signal PC, Instruction : std_logic_vector(31 downto 0);
    signal PSR : std_logic;
    signal nPCSel : std_logic;
    signal RegWE : std_logic;
    signal Rn, Rd, Rm, Rb : std_logic_vector(3 downto 0);
    signal RegSel : std_logic;
    signal UALOP : std_logic_vector(1 downto 0);
    signal UALSrc : std_logic;
    signal PSREn : std_logic;
    signal MemWr : std_logic;
    signal WrSrc : std_logic;
    signal Imm : std_logic_vector(7 downto 0);
    signal Offset : std_logic_vector(23 downto 0);
    signal BusA, BusB, BusW, UALout, DataOut, Extout, Muxout : std_logic_vector(31 downto 0);
    signal flag : std_logic;
  
begin
    
    BancReg : entity work.BancReg(behavior_BancReg)
    port map (CLK => CLK, Reset =>Reset, W => BusW, RA => Rn, RB => Rb, RW => Rd, WE => RegWE, A => BusA, B => BusB);
    
    ALU : entity work.UAL(behavior_UAL)
    port map (OP => UALOP, A => BusA, B => Muxout, Y => UALout, N => flag);
    
    DataMem : entity work.Memoire
    port map (CLK => CLK, DataIn => BusB, Addr => UALout(5 downto 0) , WrEn => MemWr, DataOut => Dataout);
    
    Extender : entity work.ExtensionSigne
    generic map (N => 8)
    port map (E => Imm, S => Extout);
    
    MuxUAL : entity work.Multiplexeur
    port map (A => BusB, B => Extout, COM => UALSrc, S => Muxout);
    
    MuxWrSrc : entity work.Multiplexeur
    port map (A => UALout, B => Dataout, COM => WrSrc, S => BusW);
      
    MuxRegSel : entity work.Multiplexeur
    generic map (N => 4)
    port map (A => rm, B => Rd, COM => RegSel, S => Rb);
      
    UGI: entity work.UGI
    port map (Offset => Offset, nPCsel => nPCsel, reset => reset, CLK => CLK, PCout => PC);
      
    InstructionDecode : entity work.Decodeur
    port map (Instruction => Instruction,
              PSR => PSR,
              flag => flag,
              nPCSel => nPCSel,
              RegWE => RegWE,
              Rn => Rn, Rd => Rd, Rm => Rm,
              ReqSel => RegSel, 
              UALOP => UALOP,
              UALSrc => UALSrc,
              PSREn => PSREn,
              MemWr => MemWr,
              WrSrc => WrSrc,
              Imm => Imm,
              Offset => Offset);
              
    InstrucMem : entity work.instruction_memory
    port map (PC => PC, Instruction => Instruction);
      
    ProcessorStateRegister : entity work.registre_commande
    port map (CLK => CLK, DataIn => flag, reset => reset, WE => PSREn, DataOut => PSR);
      
      
    Process
    begin
      CLK <= '1';
      wait for 1 ns;
      CLK <= '0';
      wait for 1 ns;
    end process;
    
    Process
    begin
      reset <= '1';
      wait for 1 ns;
      reset <= '0';
      wait;
      
    end process; 
      
end architecture;
    