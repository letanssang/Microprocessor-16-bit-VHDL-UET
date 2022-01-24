library ieee;
use ieee.std_logic_1164.all;
use work.Sys_Definition.all;
entity CPU_tb is
end CPU_tb;
architecture CPU_tb of CPU_tb is
	constant clk_period : TIME := 20 ns;
	signal clk : std_logic := '0';
	signal nReset,Mre,Mwe,ALUz,PCclr,PCinc,PCld,IRld,Opr1e,Opr2e,RFwe : std_logic;
	signal ADDR,IRin,Datapath_out,IRouttoPC,IRout,Opr2,PCout,emptyMUX : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal RFs,ALUs,Ms : std_logic_vector (1 downto 0);
	signal RFwa,Opr1a,Opr2a : std_logic_vector (3 downto 0);
	
begin
	clk <= not clk after clk_period/2;
	IRouttoPC(7 downto 0) <=  IRout(7 downto 0);
	IRouttoPC(15 downto 8) <= "00000000";
controller1 : controller
	port map (
	IRout =>  IRout, 
 	clk => clk,
	reset => nReset,
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
PC1 : PC
	port map (
	clk =>clk,
	PCclr =>PCclr,
	PCinc =>PCinc,
	PCld => PCld,
	PCin => IRouttoPC,
	PCout => PCout);
IR1 : IR
	port map (
	clk =>clk,
	IRld => IRld,
	IRin => IRin,
	IRout => IRout);
MUX2 : MUX4to1
	port map (
	SEL => Ms,
	A => Opr2,
	B => IRouttoPC,
	C => PCout,
	D => emptyMUX,
	Z => ADDR);
datapath1 : datapath
	port map (
	clk => clk,
	reset => nReset,
	data1_in => IRouttoPC,
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
dpmem1 : dpmem 
  port map(
    	Clk => clk,
	nReset => nReset,
   	addr => ADDR,
	Wen	=> Mwe,
    	Datain => Datapath_out,
	Ren  => Mre,
    	Dataout => IRin
    
    );
test : process
begin 
	nReset <= '1';
	wait for 20 ns;
	nReset <= '0';
	wait for 1800 ns;
end process test;
end CPU_tb;
	
 

	

