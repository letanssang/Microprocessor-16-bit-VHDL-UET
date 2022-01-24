# Microprocessor-16-bit-VHDL-UET
![alt text](https://github.com/letanssang/Microprocessor-16-bit-VHDL-UET/blob/main/z3136160817596_2cf32866351870d254e1f8f35c8ff1b6.jpg)
![alt text](https://github.com/letanssang/Microprocessor-16-bit-VHDL-UET/blob/main/z3136162866170_43f580260a2186dddaa640512ff3d9f5.jpg)








TT	Assembly Instruction	First Byte	Second Byte	Operation
		Opcode	Operand1	Operand2	
1	MOV Rn, direct	0000	Rn	direct	Rn = M(direct)
2	MOV direct, Rn	0001	Rn	direct	M(direct) = Rn
3	MOV Rn, @Rm	0010	Rn	Rm		M(Rm) = Rn
4	MOV Rn, #immed	0011	Rn	immediate	Rn = immediate
5	ADD Rn, Rm	0100	Rn	Rm		Rn = Rn + Rm
6	SUB Rn, Rm	0101	Rn	Rm		Rn = Rn - Rm
7	JZ  Rn, Addr	0110	Rn	Addr	PC = Addr  only if Rn = 0
8	OR Rn, Rm	0111	Rn	Rm		Rn = Rn OR Rm
9	AND Rn, Rm	1000	Rn	Rm		Rn = Rn AND Rm
10	JMP  Addr	1010	Rn	Adrr	PC = Addr  

NOT DONE YET !!

