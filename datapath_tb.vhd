library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.Sys_Definition.all;
use std.textio.all;
entity datapath_tb is

end datapath_tb;
architecture datapath_tb of datapath_tb is
	constant clk_period   : time      := 20 ns;
	signal clk : std_logic := '0';
	signal reset,Opr1e,Opr2e,RFwe,ALUz : std_logic;
	signal data1_in,data2_in,Opr1,Opr2 : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal RFs,ALUs : std_logic_vector (1 downto 0);
	signal Opr1a,Opr2a,RFwa : std_logic_vector (3 downto 0);
begin 
	clk <= not clk after clk_period/2;
datapath1: datapath
	port map (
	reset => reset,
	clk => clk,
	data1_in => data1_in,
	data2_in => data2_in,
	RFs => RFs,
	Opr1e => Opr1e,
	Opr2e => Opr2e,
	RFwe => RFwe,
	Opr1a => Opr1a,
	Opr2a => Opr2a,
	RFwa => RFwa,
	ALUs => ALUs,
	ALUz => ALUz,
	Opr1_out => Opr1,
	Opr2_out => Opr2);
testdatapath : process
begin
	reset <= '0';
	data1_in <= "0000000000000011";
	data2_in <= "0000000000001001";
	wait for 20 ns;
	RFwa <= "1110";
	RFwe <= '1';
	RFs <= "01"; --R14 = data1_in
	wait for 20 ns;
	RFwe <= '0';
	wait for 20 ns;
	RFwa <= "1111"; 
	RFwe <= '1';
	RFs <= "10"; -- R15 = data2_in
	wait for 20 ns;
	RFwe <= '0';
	--Opr1 = R14, Opr2 = R15
	wait for 20 ns;
	Opr1a <= "1110";
	Opr2a <= "1111";
	wait for 20 ns;
	Opr1e <= '1';
	Opr2e <= '1';
	wait for 20 ns;
	ALUs <= "10"; --Opr1 = Opr1 or Opr2
	wait for 20 ns;
	RFs <= "00";
	RFwa <= "0010"; -- R2 = Opr1
	RFwe <= '1';
	wait for 20 ns;
	data1_in <= X"0000";
	RFs <= "01";
	RFwe <= '1';
	RFwa <= "0000";
	wait for 20 ns;
	Opr1e <= '1';
	Opr1a <= "0000";
	-- Reset
	wait for 20 ns;
	reset <= '1';
	wait for 20 ns;
end process testdatapath;
end datapath_tb; 
	
	
	
	
	