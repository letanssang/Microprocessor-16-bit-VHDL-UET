library ieee;
use ieee.std_logic_1164.all;
use work.Sys_Definition.all;
entity mux4to1_tb is
end mux4to1_tb;
architecture mux4to1_tb of mux4to1_tb is
 	signal A,B,C,D,Z : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal SEL : std_logic_vector(1 downto 0);
begin	
testmux4to1 : mux4to1
	port map (
	A => A,
	B => B,
	C => C,
	D => D,
	SEL => SEL,
	Z => Z);
test : process
	begin
	A <= "1100110011001100";
	B <= "0000000011111111";
	C <= "1111000011110000";
	D <= "0000111100001111";
	wait for 20 ns;
	SEL <= "00";
	wait for 20 ns;
	SEL <= "01";
	wait for 20 ns;
	SEL <= "10";
	wait for 20 ns;
	SEL <= "11";
	wait;
end process test;
end mux4to1_tb;

