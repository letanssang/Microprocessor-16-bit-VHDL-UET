library ieee;
use ieee.std_logic_1164.all;
use work.Sys_Definition.all;
entity IR is
port (
	clk : in std_logic;
	IRld : in std_logic;
	IRin : in std_logic_vector (DATA_WIDTH-1 downto 0);
	IRout: out std_logic_vector(DATA_WIDTH-1 downto 0));
end IR;
architecture IR1 of IR is
begin 
	process(clk)
	begin 
	if clk'event and clk='1' then 
	if IRld = '1' then  
	IRout <= IRin;
	end if;
	end if;
	end process;
end IR1;