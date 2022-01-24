library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.Sys_Definition.all;

entity mux4to1 is
   port (A, B, C, D: in  	std_logic_vector (DATA_WIDTH-1 downto 0);
        SEL : in 	 std_logic_vector (1 downto 0);
        Z: out 	std_logic_vector (DATA_WIDTH-1 downto 0)
               );
end mux4to1;
architecture mux4to1_dataflow of mux4to1 is
begin
    with SEL select
	Z <= 	A when "00",
	 	B when "01",
		C when "10",
		D when others;


end mux4to1_dataflow;
