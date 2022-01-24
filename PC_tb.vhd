library ieee;
use ieee.std_logic_1164.all;
use work.Sys_Definition.all;
entity PC_tb is
end PC_tb;
architecture PC_tb of PC_tb is
	constant clk_period : TIME := 20 ns;
	signal clk : std_logic := '0';
	signal PCclr,PCld,PCinc : std_logic;
	signal PCin,PCout : std_logic_vector (DATA_WIDTH-1 downto 0);
begin
	clk <= not clk after clk_period/2;
testPC : PC
	port map (
	clk => clk,
	PCclr => PCclr,
	PCinc => PCinc,
	PCld => PCld,
	PCin => PCin,
	Pcout => PCout);
test : process
begin 
	PCin <= "0000000000000001";
	wait for 20 ns;
	PCld <= '1';
	wait for 20 ns;
	PCld <= '0';
	wait for 20 ns;
	PCinc <= '1';
	wait for 20 ns;
	PCinc <= '0';
	wait for 20 ns;
	PCinc <= '1';
	wait for 20 ns;
	PCclr <= '1';
end process test;
end PC_tb;
	
	
	
 