`include "pc_adder.v"
`include "ALU.v"
`include "data_memory.v"
`include "pc.v"
`include "register.v"
`include "clock.v"
`include "muxes.v"
`include "sign_extend.v"
`include "instruction_memory.v"
`include "controlUnit_aluControl.v"
`include "shift_left_2.v"
`include "adder_2.v"


module tb_full();

// pipeline wires
wire 		clk;
reg 		reset;
wire [12:0] PC_out, PC4, ID_PC4, EX_PC4;
wire [12:0] PCbne,PC4bne,PCj,PC4bnej,PCjr; // PC signals in MUX
wire [31:0] Instruction_out, ID_Instruction, EX_Instruction; // Output of Instruction Memory
wire [5:0]  Opcode, Function;
wire [31:0] signex_out;
wire 	    sign_extend_control;
wire [31:0] Im16_Ext, EX_Im16_Ext;   ////////////// immediate extend

wire [4:0]   rs, rt, rd, EX_rs, EX_rt, EX_rd, EX_WriteRegister, MEM_WriteRegister, WB_WriteRegister;	 //////////////////// reg file
wire [31:0]  WB_WriteData, ReadData1out, ReadData2out, EX_ReadData1out, EX_ReadData2out;
wire [31:0]  EX_ReadData1, EX_ReadData2;



wire 	    RegDst, RegWrite, ALUSrc, MemWrite, MemRead;
wire	    zero_flag, Beq, MemToReg, jal, and_out, Jump, jr, and2_out, not_out;
wire [12:0] adder1_out, adder2_out, mux6_out, mux7_out, mux8_out;
wire [4:0]  mux1_out;
wire [31:0] mux3_out,  alu_out, read_datamem_out, mux4_out;
wire [3:0]  ALUControl;


clock c(clk);

pc p(PC_out,mux8_out,reset,clk);
adder_13bit adder1(adder1_out,PC_out);

instruction_memory inst_mem(PC_out,clk,Instruction_out);

register regf(ReadData1out, ReadData2out, WB_WriteRegister, WB_WriteData, not_out, clk, Instruction_out[25:21], Instruction_out[20:16], reset);


Control cont(ALUControl,Instruction_out[31:26],Instruction_out[5:0],ALUSrc,RegDst,MemWrite, MemRead, Beq, Bne, Jump, MemToReg, RegWrite,jr,jal,sign_extend_control );

mux_5_5_5 mux1(Instruction_out[20:16],Instruction_out[15:11],RegDst,mux1_out);

mux_5_const_5 mux2(mux1_out,jal,WB_WriteRegister);

sign_extend sign_ex(Instruction_out[15:0],signex_out,sign_extend_control);

mux_32_32_32 mux3(ReadData2out,signex_out,ALUSrc,mux3_out);

alu  alu1( alu_out ,zero_flag,ReadData1out,mux3_out,ALUControl,Instruction_out[10:6]);

data_memory data_mem(read_datamem_out,alu_out[12:0],ReadData2out,MemRead,MemWrite,clk); 



and_gate and1(Beq,zero_flag,and_out);

//shift_left_2(signex_out,shift_left_out);

mux_32_32_32 mux4(alu_out,read_datamem_out,MemToReg,mux4_out);

mux_32_13_32 mux5(mux4_out,adder1_out,jal,WB_WriteData);

adder_2 adder2(adder1_out,signex_out[12:0],adder2_out);

mux_13_13_13 mux6(adder1_out,adder2_out,and_out,mux6_out);

mux_13_13_13 mux7(mux6_out,Instruction_out[12:0],Jump,mux7_out);

mux_13_13_13 mux8(mux7_out,ReadData1out[12:0],jr,mux8_out);

not(not_out,jr);

and_gate and2(RegWrite,not_out,and2_out);



initial 
begin
reset=1;
#1
reset=0;
end

endmodule