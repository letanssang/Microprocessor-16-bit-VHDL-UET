library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.sys_definition.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use std.textio.all;
 
entity control_unit_tb is

end control_unit_tb;

architecture control_unit_tb of control_unit_tb is
	Constant clk_period	: time      := 20 ns;
	signal reset, clk, RFwe, OPR1e, OPR2e, ALUz, Mre, Mwe : std_logic;
	signal IRout_datapath, OPr2, ADDR, Data_out : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal RFs, ALUs : std_logic_vector(1 downto 0);
	signal RFwa, OPR1a, OPR2a : std_logic_vector(3 downto 0);
	
	
begin
clk <= not clk after clk_period/2;
testcontrol_unit: control_unit
	port map(
	clk => clk,
	reset => reset,
	IRout_datapath => IRout_datapath,
	RFs => RFs,
	RFwa => RFwa,
	RFwe => RFwe,
	OPR1a => OPR1a,
	OPR2a => OPR2a,
	OPR1e => OPR1e,
	OPR2e => OPR2e,
	ALUs => ALUs,
	ALUz => ALUz,
	OPr2 =>OPR2,
	ADDR => ADDR,
	Data_out => Data_out,
	Mre => Mre,
	Mwe => Mwe
);
sangquang :  process
Begin
	-- Test with jz 0000 0001 (0110 0000 0001 0011)
	Data_out 	<= "0110000100010011";

	wait for 50 ns;
	Data_out 	<= "0110001101010100";

	wait for 50 ns;
	Data_out 	<= "0010001101010101";

	wait for 50 ns;

end process sangquang;
end control_unit_tb;

