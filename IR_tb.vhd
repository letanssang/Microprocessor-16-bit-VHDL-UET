library ieee;
use ieee.std_logic_1164.all;
use work.Sys_Definition.all;
entity IR_tb is 
end IR_tb;
architecture IR_tb of IR_tb is
	constant clk_period: TIME := 20 ns;
	signal clk: std_logic := '0';
	signal IRld: std_logic := '0';
	signal IRin,IRout: std_logic_vector (DATA_WIDTH-1 downto 0);
begin
	clk <= not clk after clk_period/2;
testIR : IR 
	port map (
	clk => clk,
	IRld => IRld,
	IRin => IRin,
	IRout => IRout);
test : process
begin
	
	IRin <= "1111111111111111";
	wait for 20 ns;
	IRld <= '1';
	wait;
	
end process test;
end IR_tb;
