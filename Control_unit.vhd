library ieee;
use ieee.std_logic_1164.all;
use work.Sys_Definition.all;
entity control_unit is
port (
	clk : in std_logic;
	reset : in std_logic;
	IRout_datapath : out std_logic_vector(DATA_WIDTH-1 downto 0);
	RFs : out std_logic_vector (1 downto 0);
	RFwa: out std_logic_vector(3 downto 0);
	RFwe: out std_logic;
	Opr1a: out std_logic_vector(3 downto 0);
	Opr1e: out std_logic;
	Opr2a: out std_logic_vector(3 downto 0);
	Opr2e: out std_logic;
	ALUs: out std_logic_vector(1 downto 0);
	ALUz: in std_logic;
	Opr2: in std_logic_vector(DATA_WIDTH-1 downto 0);
	ADDR : out std_logic_vector(DATA_WIDTH-1 downto 0);
	Data_out: in std_logic_vector(DATA_WIDTH-1 downto 0);
	Mre: out std_logic;
	Mwe: out std_logic
	);
end control_unit;
architecture CU of control_unit is
	signal data1,data2,data3,IRout : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal PCclr,PCinc,PCld,IRld : std_logic;
	signal Ms : std_logic_vector (1 downto 0);
begin
IR1 : IR
	port map (
	clk =>clk,
	IRld => IRld,
	IRin => Data_out,
	IRout => IRout);
MUX2 : MUX4to1
	port map (
	SEL => Ms,
	A => Opr2,
	B => IRout,
	C => data2,
	D => data3,
	Z => ADDR);
PC1 : PC
	port map (
	clk =>clk,
	PCclr =>PCclr,
	PCinc =>PCinc,
	PCld => PCld,
	PCin => IRout,
	PCout => data2);

controller1 : controller
	port map (
	IRout =>  IRout,
 	clk => clk,
	reset => reset,
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
	IRout_datapath <= IRout;
end CU;
	
	
	
	
	 	
	