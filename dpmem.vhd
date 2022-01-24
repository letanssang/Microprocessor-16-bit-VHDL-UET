library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.Sys_Definition.all;
entity dpmem is
  port (
    	Clk              : in  std_logic;
	nReset        : in  std_logic; -- Reset input
   	addr              : in  std_logic_vector(ADDR_WIDTH -1 downto 0);
	Wen               : in  std_logic;          -- Write Enable
    	Datain            : in  std_logic_vector(DATA_WIDTH -1 downto 0) := (others => '0');   -- Input Data
	Ren               : in  std_logic;          -- Read Enable
    	Dataout           : out std_logic_vector(DATA_WIDTH -1 downto 0)   -- Output data
    
    );
end dpmem;
architecture dpmem_arch of dpmem is
   
  type DATA_ARRAY is array (integer range <>) of std_logic_vector(DATA_WIDTH -1 downto 0); -- Memory Type
  signal   M       :     DATA_ARRAY(0 to (2**ADDR_WIDTH) -1) := (others => (others => '0'));  -- Memory model
-- you can add more code for your application by increase the PM_Size
  constant PM_Size : Integer := 14; -- Size of program memory :(range 255 downto 0 )
  --type P_MEM is array (0 to PM_Size-1) of std_logic_vector(DATA_WIDTH -1 downto 0); -- Program Memory
  constant PM : DATA_ARRAY(0 to PM_Size-1) := (	
-- Machine code for initializing program memory
	X"3102", 	-- 0.MOV4 R1,#2 	R1 = 2
	X"6003",	-- 1.JZ R0,3		
	X"9000",	-- 2.JMP 0			
	X"3203",	-- 3.MOV4 R2,#3 	R2 = 3  
	X"1100",	-- 4.MOV2 M0,R1		M[0+14]= 2
	X"2210",	-- 5.MOV3 M[R1],R2	M[2+14] = 3	
	X"0310",	-- 6.MOV1 R3,M2+14	R3 = 3
	X"040E",	-- 7.MOV1 R4,M0+14	R4 = 2  
	X"4120",	-- 8.ADD R1,R2		R1=5 101
	X"5340",	-- 9.SUB R3,R4		R3=1 001
	X"7240",	-- A.OR R2,R4		R2=3
	X"8130",	-- B.AND R1,R3		R1 = 1
	X"1101",	--C.MOV2 M1,R1         M1=R1
	X"1203"		--D.MOV2 M2,R2 	M2=R2
    );
begin  -- dpmem_arch
	
	
  --  Read/Write process

  RW_Proc : process (clk, nReset)
  begin  
    if nReset = '1' then
          Dataout <= (others => '0');
          M(0 to PM_Size-1) <= PM; -- initialize program memory
    elsif (clk'event and clk = '1') then   -- rising clock edge
        if Wen = '1' then
			   M(conv_integer(addr)+PM_Size)      <= Datain; -- ensure that data cant overwrite on program
        else
			   if Ren = '1' then
				    Dataout <= M(conv_integer(addr));
			   else
				Dataout <= (others => 'Z');
			end if;
		end if;
      end if;
  end process  RW_Proc;
     
end dpmem_arch;
