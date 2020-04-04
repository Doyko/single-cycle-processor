vlib work
vcom -93 ../src/BancReg.vhd
vcom -93 ../src/instruction_memory.vhd
vcom -93 ../src/registre_commande.vhd
vcom -93 ../src/ExtensionSigne.vhd
vcom -93 ../src/Multiplexeur.vhd
vcom -93 ../src/UAL.vhd
vcom -93 ../src/Decodeur.vhd
vcom -93 ../src/Memoire.vhd
vcom -93 ../src/UGI.vhd
vcom -93 TB_BancReg.vhd
vcom -93 TB_Proco.vhd
vcom -93 TB_Unite_Traitement.vhd
vcom -93 TB_ExtensionSigne.vhd
vcom -93 TB_UAL.vhd
vcom -93 TB_registre_commande.vhd
vcom -93 TB_Multiplexeur.vhd  
vcom -93 TB_UGI.vhd
vcom -93 TB_Proco.vhd


vsim -novopt work.tb_proco

add wave  tb_proco/CLK
add wave  -radix hexadecimal tb_proco/PC
add wave  tb_proco/InstructionDecode/instr_courante
add wave  -radix hexadecimal tb_proco/BancReg/Banc
add wave  -radix hexadecimal tb_proco/DataMem/Mem
 

run -all
