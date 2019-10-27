`include "ALU.v"
`include "data_memory.v"
`include "pc.v"
`include "register.v"
`include "clock.v"
`include "mux_in5.v"
`include "instruction_memory.v"
`include "sign_extend.v"
`include "controlUnit_aluControl.v"
`include "mux_in32.v"
`include "shift_left_2.v"


module tb_full();
wire clk,reset,RegDst,RegWrite,ALUSrc,MemWrite,MemRead;
wire[12:0] pcResult,pcNext;
wire[31:0] instruction,sign_out_32,data2,data1,mux2_out,aluout,datamem_read,mux3_out;
wire[5:0] mux1_out;
wire[3:0] ALUControl;


clock cc(clk);

pc PC(pcResult,pcNext,reset,clk);

adder_13bit(result,instruction);

instruction_memory inst(pcResult,clk,instruction);

Control cont(ALUControl,instruction[26:31], instruction[0:5], ALUSrc, RegDst, MemWrite, MemRead, Beq, Bne, Jump, MemToReg, RegWrite );

mux_in5 mux1(instruction[16:20],instruction[11:15],RegDst,mux1_out);

register regFile(data1,data2,mux1_out,mux3_out,RegWrite,clk,instruction[21:25],instruction[16:20]);

sign_extend(instruction[15:0],sign_out_32);

mux_in32 mux2(data2,sign_out_32,ALUSrc,mux2_out);

alu Alu(aluout,zero,data1,mux2_out,ALUControl);

data_memory dataMem(datamem_read,aluout,data2,MemRead,MemWrite,clk);

mux_in32 mux3(aluout,datamem_read,MemToReg,mux3_out);

endmodule
