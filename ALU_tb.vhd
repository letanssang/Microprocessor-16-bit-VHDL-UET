library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.Sys_Definition.all;
entity ALU_tb is
end ALU_tb;
architecture ALU_tb of ALU_tb is
	signal Opr1,Opr2,ALUr : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal ALUz : std_logic := '0' ;
	signal ALUs : std_logic_vector (1 downto 0);
begin
testALU : ALU
	port map (
	Opr1 => Opr1,
	Opr2 => Opr2,
	ALUs => ALUs,
	ALUr => ALUr,
	ALUz => ALUz);
test : process 
begin	
	Opr1 <= "1111000011110000";
	OPr2 <= "0000000011111111";
	wait for 20 ns;
	ALUs <= "00";
	wait for 20 ns ;
	ALUs <= "01";
	wait for 20 ns;
	ALUs <= "10";
	wait for 20 ns;
	ALUs <= "11";
	wait for 20 ns;
	Opr1 <= X"0000";
	wait for 20 ns;
end process test;
end ALU_tb;
	

	
