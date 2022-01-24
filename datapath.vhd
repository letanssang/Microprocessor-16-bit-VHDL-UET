library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Sys_Definition.all;
entity datapath is
port (
	reset : in std_logic;
	clk : in std_logic;
	data1_in : in std_logic_vector(DATA_WIDTH-1 downto 0);
	data2_in : in std_logic_vector(DATA_WIDTH-1 downto 0);
	RFs : in std_logic_vector(1 downto 0);
	Opr1e, Opr2e : in std_logic;
	RFwe: in std_logic;
	Opr1a, Opr2a : in std_logic_vector(3 downto 0);
	RFwa : in std_logic_vector(3 downto 0);
	ALUs : in std_logic_vector(1 downto 0);
	Opr1_out : out std_logic_vector (DATA_WIDTH-1 downto 0);
	Opr2_out : out std_logic_vector (DATA_WIDTH-1 downto 0);
	ALUz : out std_logic);
end datapath;
architecture datapath of datapath is
	signal data0_in,data3_in : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal RFin : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal Opr1 : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal Opr2 : std_logic_vector(DATA_WIDTH-1 downto 0);
begin 
MUX1 : MUX4TO1
	port map (
	A => data0_in,
	B => data1_in,
	C => data2_in,
	D => data3_in,
	SEL => RFs,
	Z => RFin);
RF1 : RF
	port map (
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
	Opr1_out <= Opr1;
	Opr2_out <= Opr2;
ALU1 : ALU
	port map (
	Opr1 => Opr1,
	Opr2 => Opr2,
	ALUs => ALUs,
	ALUz => ALUz,
	ALUr => data0_in);
end datapath;