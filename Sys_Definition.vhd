library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;
use std.textio.all;
package Sys_Definition is
Constant   DATA_WIDTH  :     integer   := 16;     -- Word Width
Constant   ADDR_WIDTH  :     integer   := 16 ;     -- Address width
component mux4to1 is
   port (A, B, C, D: in  	std_logic_vector (DATA_WIDTH-1 downto 0);
        SEL : in 	 std_logic_vector (1 downto 0);
        Z: out 	std_logic_vector (DATA_WIDTH-1 downto 0)
               );
end component mux4to1;
component ALU is 
	port( 	Opr1, Opr2 : in std_logic_vector(DATA_WIDTH -1 downto 0);
		ALUs : in std_logic_vector(1 downto 0);
		ALUz : out std_logic; 
		ALUr : out std_logic_vector(DATA_WIDTH-1 downto 0) 
	);
end component ALU;
component RF is
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
end component RF;
component datapath is
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
end component datapath;
component Controller is 
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
end component Controller;
component IR is
port (
	clk : in std_logic;
	IRld : in std_logic;
	IRin : in std_logic_vector (DATA_WIDTH-1 downto 0);
	IRout: out std_logic_vector(DATA_WIDTH-1 downto 0));
end component IR;
component PC is
port (
	clk : in std_logic;
	PCclr : in std_logic;
	Pcinc : in std_logic;
	PCld : in std_logic;
	PCin : in std_logic_vector(DATA_WIDTH-1 downto 0);
	PCout: out std_logic_vector(DATA_WIDTH-1 downto 0));
end component PC;
component control_unit is
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
end component control_unit;
component dpmem is
  port (
    	Clk              : in  std_logic;
	nReset        : in  std_logic; -- Reset input
   	addr              : in  std_logic_vector(ADDR_WIDTH -1 downto 0);
	Wen               : in  std_logic;          -- Write Enable
    	Datain            : in  std_logic_vector(DATA_WIDTH -1 downto 0) := (others => '0');   -- Input Data
	Ren               : in  std_logic;          -- Read Enable
    	Dataout           : out std_logic_vector(DATA_WIDTH -1 downto 0)   -- Output data
    
    );
end component dpmem;
component CPU is
port (	
	nReset : in std_logic;
	clk : in std_logic;
	ADDR : out std_logic_vector(DATA_WIDTH-1 downto 0);
	IRin : in std_logic_vector(DATA_WIDTH-1 downto 0);
	Mre : out std_logic;
	Mwe : out std_logic;
	Datapath_out : out std_logic_vector(DATA_WIDTH-1 downto 0));
end component CPU;
component microprocessor is
port (
	clk : in std_logic;
	nReset: in std_logic
);
end component microprocessor;
end Sys_Definition;
PACKAGE BODY Sys_Definition IS
	-- package body declarations

END PACKAGE BODY Sys_Definition;

