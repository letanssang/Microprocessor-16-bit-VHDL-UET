library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.Sys_Definition.all;
entity RF is
port ( 	nReset : in std_logic;
	clk : in std_logic;
	RFwe: in std_logic;
	Opr1e: in std_logic;
	Opr2e: in std_logic;
	RFin : in std_logic_vector(DATA_WIDTH-1 downto 0);
	RFwa : in std_logic_vector(3 downto 0);
	Opr1a: in std_logic_vector(3 downto 0);
	Opr2a: in std_logic_vector(3 downto 0);
	Opr1 : out std_logic_vector(DATA_WIDTH-1 downto 0);
	Opr2 : out std_logic_vector(DATA_WIDTH-1 downto 0)
	);
end RF;
architecture RF of RF is
type data_array is array (integer range<>) of std_logic_vector(DATA_WIDTH-1 downto 0);
signal reF : data_array(0 to 15) := (others => (others => '0'));
begin 
	process(clk,nReset)
	begin 
	if nReset = '1' then
	Opr1 <= (others => '0');
	Opr2 <= (others => '0');
	reF <= (others => (others => '0'));
	elsif clk'event and clk = '1' then
	if RFwe = '1' then
	reF(conv_integer(RFwa)) <= RFin;
	end if;
	if Opr1e = '1' then
	Opr1 <= reF(conv_integer(Opr1a));
	end if;
	if Opr2e = '1' then
	Opr2 <= reF(conv_integer(Opr2a));
	end if;
  	end if;
	end process;
end RF;