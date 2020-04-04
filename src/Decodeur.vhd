library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decodeur is
  port
  (
    Instruction : in std_logic_vector(31 downto 0);
    PSR : in std_logic;
    flag : in std_logic;
    nPCSel : out std_logic;
    RegWE : out std_logic;
    Rn, Rd, Rm : out std_logic_vector(3 downto 0);
    ReqSel : out std_logic;
    UALOP : out std_logic_vector(1 downto 0);
    UALSrc : out std_logic;
    PSREn : out std_logic;
    MemWr : out std_logic;
    WrSrc : out std_logic;
    Imm : out std_logic_vector(7 downto 0);
    Offset : out std_logic_vector(23 downto 0)
  );
end entity;

architecture behavior of Decodeur is
  
  type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT, ERR);
  signal instr_courante: enum_instruction;
  
begin
  
  process(Instruction)
  begin
     
    if Instruction(31 downto 28) = "1110" then
       
      if Instruction(27 downto 26) = "00" then
        
        if Instruction(24 downto 21) = "0100" then
          
          if Instruction(25) = '0' then
            
            instr_courante <= ADDr;
            
          else
            
            instr_courante <= ADDi;
            
          end if;
          
        elsif Instruction(24 downto 21) = "1101" then
          
          instr_courante <= MOV;
          
        elsif Instruction(24 downto 21) = "1010" then
          
          instr_courante <= CMP;
          
        else
          
          instr_courante <= ERR;
          
        end if;
         
      elsif Instruction(27 downto 26) = "01" then
        
        if Instruction(20) = '0' then
          
          instr_courante <= STR;
          
        else
          
          instr_courante <= LDR;
          
        end if;
       
      elsif Instruction(27 downto 26)  = "10" then
        
        instr_courante <= BAL;
        
      else
        
        instr_courante <= ERR;
        
      end if;
       
    elsif Instruction(31 downto 28) = "1011" then
      
      instr_courante <= BLT;
      
    else
      
      instr_courante <= ERR;
      
    end if;          
       
  end process;
  
  
  process(Instruction, instr_courante)
  begin
    
    case instr_courante is
      
    when MOV => nPCSel <= '0';
                RegWE <= '1';
                Rd <= Instruction(15 downto 12);
                ReqSel <= '0';
                UALOP <= "01";
                UALSrc <= '1';
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '0';
                Imm <= Instruction(7 downto 0);
                
    when ADDi => nPCSel <= '0';
                RegWE <= '1';
                Rn <= Instruction(19 downto 16);
                Rd <= Instruction(15 downto 12);
                ReqSel <= '0';
                UALOP <= "00";
                UALSrc <= '1';
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '0';
                Imm <= Instruction(7 downto 0);
                
    when ADDr => nPCSel <= '0';
                RegWE <= '1';
                Rn <= Instruction(19 downto 16);
                Rd <= Instruction(15 downto 12);
                Rm <= Instruction(3 downto 0);
                ReqSel <= '0';
                UALOP <= "00";
                UALSrc <= '0';
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '0';
                
    when CMP => nPCSel <= '0';
                RegWE <= '0';
                Rn <= Instruction(19 downto 16);
                ReqSel <= '0';
                UALOP <= "10";
                UALSrc <= '1';
                PSREn <= '1';
                MemWr <= '0';
                WrSrc <= '0';
                Imm <= Instruction(7 downto 0);
                
    when LDR => nPCSel <= '0';
                RegWE <= '1';
                Rn <= Instruction(19 downto 16);
                Rd <= instruction(15 downto 12);
                ReqSel <= '0';
                UALOP <= "00";
                UALSrc <= '1';
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '1';
                Imm <= Instruction(7 downto 0);
                
    when STR => nPCSel <= '0';
                RegWE <= '0';
                Rn <= Instruction(19 downto 16);
                Rd <= Instruction(15 downto 12);
                ReqSel <= '1';
                UALOP <= "00";
                UALSrc <= '1';
                PSREn <= '0';
                MemWr <= '1';
                Imm <= Instruction(7 downto 0);
                
    when BAL => nPCSel <= '1';
                RegWE <= '0';
                ReqSel <= '0';
                UALOP <= "00";
                UALSrc <='0';
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '0';
                Offset <= Instruction(23 downto 0);
                
    when BLT => nPCSel <= flag;
                RegWE <= '0';
                ReqSel <= '0';
                UALOP <= "00";
                PSREn <= '1';
                MemWr <= '0';
                WrSrc <= '0';
                Offset <= Instruction(23 downto 0);
                
    when others => nPCSel <= 'Z';
                RegWE <= 'Z'; 
                ReqSel <= 'Z';
                UALOP <= "ZZ";
                UALSrc <= 'Z';
                PSREn <= 'Z';
                MemWr <= 'Z';
                WrSrc <= 'Z';
      
    end case;
    
  end process;
end architecture;