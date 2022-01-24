library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.Sys_Definition.all;
entity PC is
port (
	clk : in std_logic;
	PCclr : in std_logic;
	Pcinc : in std_logic;
	PCld : in std_logic;
	PCin : in std_logic_vector(DATA_WIDTH-1 downto 0);
	PCout: out std_logic_vector(DATA_WIDTH-1 downto 0));
end PC;
architecture PC1 of PC is
	signal PCout_temp: std_logic_vector(DATA_WIDTH-1 downto 0);
begin 
	process(clk)
	begin
	if PCclr = '1' then
	PCout_temp <= (others => '0');
	elsif clk'event and clk = '1' then
	if PCinc = '1' then
	PCout_temp <= PCout_temp +1;
	elsif PCld = '1' then
	PCout_temp <= PCin;
	end if;
	end if;
	end process;
	PCout <= PCout_temp;
end PC1;