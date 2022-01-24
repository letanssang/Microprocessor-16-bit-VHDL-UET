library ieee;
use ieee.std_logic_1164.all;
use work.Sys_Definition.all;
entity Controller_tb is
end Controller_tb;
architecture Controller_tb of Controller_tb is
	constant clk_period : TIME := 20 ns;
	signal clk : std_logic := '0';
	signal reset,ALUz,PCclr,PCinc,PCld,IRld,Mre,Mwe,RFwe,Opr1e,Opr2e : std_logic ;
	signal IRout : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal Ms,RFs,ALUs : std_logic_vector (1 downto 0);
	signal RFwa,Opr1a,Opr2a : std_logic_vector (3 downto 0);
begin
	clk <= not clk after clk_period/2;
testController : Controller
	port map(
	clk => clk,
	reset => reset,
	Irout => IRout,
	ALUz => ALUz,
	PCclr => PCclr,
	PCinc => PCinc,
	PCld => PCld,
	IRld => IRld,
	Ms => Ms,
	Mre => Mre,
	Mwe => Mwe,
	RFs => RFs,
	RFwa => RFwa,
	RFwe => RFwe,
	Opr1a => Opr1a,
	Opr1e => Opr1e,
	Opr2a => Opr2a,
	Opr2e => Opr2e,
	ALUs => ALUs);
test : process 
begin
	reset <= '1';
	wait for 20 ns;
	reset <= '0';
	wait for 20 ns;
	IRout <= "0000000100000001"; -- MOV1 R1,0001
	wait for 20 ns;
	IRout <= "0001001000000001"; --MOV2 0001, R2
        wait for 20 ns;
	IRout <= "0010001100100000"; --MOV3 @R3,R2
	wait for 20 ns;
	IRout <= "0011010000000001";--MOV4 R4,#1
	wait for 20 ns;
	IRout <= "0100000100100000";-- ADD R1, R2
	wait for 20 ns;
	IRout <= "0101001101000000";--SUB R3,R4
	wait for 20 ns;
	IRout <= "0110000000001111";--JZ R0, 0000 1111
	wait for 20 ns;
	IRout <= "0111111011110000";--OR R14, R15
	wait for 20 ns;
	IRout <= "1000000000010000";--AND R0,R1
	wait for 20 ns;
	IRout <= "1001000000000011";--JMP 0000 0011
	wait for 20 ns;
end process test;
end Controller_tb;
