library ieee;
use ieee.std_logic_1164.all;
use work.Sys_Definition.all;
entity RF_tb is
end RF_tb;
architecture RF_tb of RF_tb is
	constant clk_period: TIME := 20 ns;
	signal reset: std_logic := '1';
	signal clk: std_logic := '0';
	signal Opr1e,Opr2e,RFwe : std_logic;
	signal RFin,Opr1,Opr2 : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal Opr1a,Opr2a,RFwa : std_logic_vector (3 downto 0);
begin
	clk <= not clk after clk_period/2;
testRF : RF
	port map(
	nReset => reset,
	clk => clk,
	RFwe => RFwe,
	Opr1e => Opr1e,
	Opr2e => Opr2e,
	RFin => RFin,
	RFwa => RFwa,
	Opr1a => Opr1a,
	Opr2a => Opr2a,
	Opr1 => Opr1,
	Opr2 => Opr2);
test : process 
begin
	wait for 20 ns;
	reset <= '0';
	RFin <= "0000000000000001";
	RFwa <= "1110";
	RFwe <= '1';
	wait for 10 ns; --R14 = 1;
	RFwe <= '0';
	wait for 20 ns;
	RFin <= "0000000000001110";
	RFwa <= "1111";
	RFwe <= '1';
	wait for 10 ns;
	RFwe <= '0';
	wait for 20 ns; --R15 = 14;
	Opr1a <= "1110";
	Opr1e <= '1';
	wait for 10 ns;
	Opr1e <= '0';
	wait for 20 ns; --Opr1 = R14;
	Opr2a <= "1111";
	Opr2e <= '1'; 
	wait for 10 ns;
	Opr2e <= '0';
	wait for 20 ns; --Opr2 = R15;
	reset <= '1';
	wait;
end process test;
end RF_tb;
	
	
	
	
