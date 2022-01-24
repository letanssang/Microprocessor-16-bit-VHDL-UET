library ieee;
use ieee.std_logic_1164.all;
use work.Sys_Definition.all;
entity CPU is
port (	
	nReset : in std_logic;
	clk : in std_logic;
	ADDR : out std_logic_vector(DATA_WIDTH-1 downto 0);
	IRin : in std_logic_vector(DATA_WIDTH-1 downto 0);
	Mre : out std_logic;
	Mwe : out std_logic;
	Datapath_out : out std_logic_vector(DATA_WIDTH-1 downto 0));
end CPU;
architecture CPU of CPU is
	signal data1_in,Opr2 : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal RFs,ALUs: std_logic_vector (1 downto 0);
	signal Opr1a,Opr2a,RFwa : std_logic_vector (3 downto 0);
	signal ALUz,Opr1e,Opr2e,RFwe : std_logic;
begin
datapath1 : datapath
	port map (
	clk => clk,
	reset => nReset,
	data1_in => data1_in,
	data2_in => IRin,
	RFs => RFs,
	Opr1e => Opr1e,
	Opr2e => Opr2e,
	RFwe => RFwe,
	Opr1a =>Opr1a,
	Opr2a => Opr2a,
	RFwa => RFwa,
	ALUs => ALUs,
	Opr1_out => Datapath_out,
	Opr2_out => Opr2,
	ALUz => ALUz);
	
control_unit1 : control_unit
	port map (
	clk => clk,
	reset => nReset,
	IRout_datapath => data1_in,
	RFs => RFs,
	RFwa => RFwa,
	RFwe => RFwe,
	Opr1a => Opr1a,
	Opr1e => Opr1e,
	Opr2a => Opr2a,
	Opr2e => Opr2e,
	ALUs => ALUs,
	ALUz => ALUz,
	Opr2 => Opr2,
	ADDR => ADDR,
	Data_out => IRin,
	Mre => Mre,
	Mwe => Mwe);
end CPU;
	

	
	
	
	
	
	

