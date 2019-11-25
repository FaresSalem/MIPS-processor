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

wire clk,zero_ext,RegDst,RegWrite,ALUSrc,MemWrite,MemRead,zero_flag,Beq,MemToReg,jal,and_out,Jump,jr,and2_out,not_out;
wire[12:0] pc_out,adder1_out,adder2_out,mux6_out,mux7_out,mux8_out;
wire [4:0] mux1_out,mux2_out;
wire [31:0]  mux3_out,reg_out1,reg_out2,alu_out,signex_out,instruction_out,read_datamem_out,mux5_out,mux4_out;
wire [3:0] ALUControl;
reg reset;

clock c(clk);

pc p(pc_out,mux8_out,reset,clk);

instruction_memory inst_mem(pc_out,clk,instruction_out);

register regf(reg_out1,reg_out2,mux2_out,mux5_out,and2_out,clk,instruction_out[25:21],instruction_out[20:16],reset);

Control cont(ALUControl,instruction_out[31:26],instruction_out[5:0],ALUSrc,RegDst,MemWrite, MemRead, Beq, Bne, Jump, MemToReg, RegWrite,jr,jal,zero_ext );

mux_5_5_5 mux1(instruction_out[20:16],instruction_out[15:11],RegDst,mux1_out);

mux_5_const_5 mux2(mux1_out,jal,mux2_out);

sign_extend sign_ex(instruction_out[15:0],signex_out,zero_ext);

mux_32_32_32 mux3(reg_out2,signex_out,ALUSrc,mux3_out);

alu  alu1( alu_out ,zero_flag,reg_out1,mux3_out,ALUControl,instruction_out[10:6]);

data_memory data_mem(read_datamem_out,alu_out[12:0],reg_out2,MemRead,MemWrite,clk); 

adder_13bit adder1(adder1_out,pc_out);

and_gate and1(Beq,zero_flag,and_out);

//shift_left_2(signex_out,shift_left_out);

mux_32_32_32 mux4(alu_out,read_datamem_out,MemToReg,mux4_out);

mux_32_13_32 mux5(mux4_out,adder1_out,jal,mux5_out);

adder_2 adder2(adder1_out,signex_out[12:0],adder2_out);

mux_13_13_13 mux6(adder1_out,adder2_out,and_out,mux6_out);

mux_13_13_13 mux7(mux6_out,instruction_out[12:0],Jump,mux7_out);

mux_13_13_13 mux8(mux7_out,reg_out1[12:0],jr,mux8_out);

not(not_out,jr);

and_gate and2(RegWrite,not_out,and2_out);



initial 
begin
reset=1;
#10
reset=0;
end

endmodule
