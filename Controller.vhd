library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Sys_Definition.all;
entity Controller is 
port(
	IRout: in std_logic_vector(DATA_WIDTH-1 downto 0);
 	clk : in std_logic;
	reset: in std_logic;
	ALUz: in std_logic;
	PCclr: out std_logic;
	PCinc: out std_logic;
	PCld: out std_logic;
	IRld: out std_logic;
	Ms: out std_logic_vector (1 downto 0);
	Mre: out std_logic;
	Mwe: out std_logic;
	RFs: out std_logic_vector(1 downto 0);
	RFwa: out std_logic_vector(3 downto 0);
	RFwe: out std_logic;
	Opr1a:out std_logic_vector(3 downto 0);
	Opr1e:out std_logic;
	Opr2a: out std_logic_vector(3 downto 0);
	Opr2e: out std_logic;
	ALUs: out std_logic_vector(1 downto 0));
end Controller;
architecture controller of Controller is
	signal OPCODE,rn,rm : std_logic_vector(3 downto 0);
	type state_list is (RESET1,FETCH,FETCH1,FETCH2,DECODE,MOV1,MOV1a,MOV2,MOV2a,MOV3,MOV3a,
	MOV4,MOV4a,ADD,ADD1,SUB,SUB1,JZ,JZ1,ORs,ORs1,ANDs,ANDs1,JMP,NO);
	signal state : state_list;
begin 
	OPCODE <= IRout(15 downto 12);
	rn <= IRout(11 downto 8);
	rm <= IRout(7 downto 4);
process(OPCODE,clk,reset)
	begin
	if reset = '1' then
	state <= RESET1;
	elsif clk'event and clk = '1' then
	case state is
	when RESET1 =>
	state <= FETCH;
	when FETCH =>
	state <= FETCH1;
	when FETCH1 =>
	state <= FETCH2;
	when FETCH2 =>
	state <= DECODE;
	when DECODE =>
	case OPCODE is
		when "0000" => state <= MOV1;
		when "0001" => state <= MOV2;
		when "0010" => state <= MOV3;
		when "0011" => state <= MOV4;
		when "0100" => state <= ADD;
		when "0101" => state <= SUB;
		when "0110" => state <= JZ;
		when "0111" => state <= ORs;
		when "1000" => state <= ANDs;
		when "1001" => state <= JMP;
		when others => state <= NO;
	end case;
	when MOV1 => 
	state <= MOV1a;
	when MOV1a => state <=  FETCH;
	when MOV2 => state <= MOV2a;
	when MOV2a => state <= FETCH;
	when MOV3 => state <= MOV3a;
	when MOV3a => state <= FETCH;
	when MOV4 => state <= FETCH;
	when ADD => state <= ADD1;
	when ADD1 => state <= FETCH;
	when SUB => state <= SUB1;
	when SUB1 => state <= FETCH;
	when JZ => state <= JZ1;
	when JZ1 => state <= FETCH;
	when ORs => state <= ORs1;
	when ORs1 => state <= FETCH;
	when ANDs => state <= ANDS1;
	when ANDs1 => state <= FETCH;
	when JMP => state <= FETCH;
	when others => State <= FETCH;
	end case;
	end if;
	end process;	
--PC
	PCClr <= '1' when (state = RESET1) else '0';
	PCinc <= '1' when (state = FETCH2) else '0';
	PCld <= ALUz when state = JZ1 else '0';
--IR
	IRld <= '1' when (state = FETCH1) else '0';
-- Ms trong bo hop kenh 
	with state select 
	Ms <= 	"00" when MOV3a,
		"01" when MOV1|MOV2a,
 		"10" when FETCH,
		"11" when others;
-- Mre, Mwe cua memory
	with state select 
	Mre <= 	'1' when FETCH|MOV1,
		'0' when others;
	with state select  
	Mwe <= 	'1' when MOV2a|MOV3a,
		'0' when others;
--RFs
	with state select
	RFs <= 	"00" when ADD1|SUB1|ORs1|ANDs1,
		"01" when MOV4,
		"10" when MOV1a,
		"11" when others;
--RFwe
	with state select
	RFwe <= '1' when MOV1a|MOV4|ADD1|SUB1|ORs1|ANDs1,
		'0' when others;
--RFwa
	with state select 
	RFwa <= rn when MOV1a|MOV4|ADD1|SUB1|ORs1|ANDs1,
		"0000" when others;
--Opr1e
	with state select
	Opr1e <= '1' when MOV2|MOV3|ADD|SUB|JZ|ORs|ANDs,
		'0' when others;
--Opr1a
	with state select
	Opr1a <= rn when MOV2|MOV3|ADD|SUB|JZ|ORs|ANDs,
		"0000" when others;
--Opr2e
	with state select 
	Opr2e <= '1' when MOV3|ADD|SUB|ORs|ANDs,
		'0' when others;
--Opr2a
	with state select 
	Opr2a <= rm when MOV3|ADD|SUB|ORs|ANDs,
		"0000" when others;
--ALUs 
	with state select
	ALUs <= "00" when ADD,
		"01" when SUB,
		"10" when ORs,
		"11" when others;
		
end controller;

		



		
	
	

	
	
	
