library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.Sys_Definition.all;
entity ALU is 
	port( 	Opr1, Opr2 : in std_logic_vector(DATA_WIDTH -1 downto 0);
		ALUs : in std_logic_vector(1 downto 0);
		ALUz : out std_logic; 
		ALUr : out std_logic_vector(DATA_WIDTH-1 downto 0) 
	);
end ALU;
architecture ALU of ALU is
	signal final : std_logic_vector (DATA_WIDTH-1 downto 0);
begin
	process(ALUs,Opr1,Opr2)
	begin 
	if 	ALUs = "00" then final <= Opr1 + Opr2;
	elsif 	ALUs = "01" then final <= Opr1 - Opr2;
	elsif 	ALUs = "10" then final <= Opr1 or Opr2;
	else 	final <= Opr1 and Opr2;
	end if;
	end process;
	ALUr <= final;
	ALUz <= '1' when Opr1 = x"0000" else '0';
end ALU;
	
