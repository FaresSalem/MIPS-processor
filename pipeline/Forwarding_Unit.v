//`timescale 1 ps / 100 fs
`timescale 1ns/1ns // our clk

module CompareAddress(output wire        equal,
					  input  wire  [4:0] Address1, Address2);
					  
	wire [4:0] xorAddress;
	
	xor  #50   xorAddress0 (xorAddress[0], Address1[0], Address2[0]);
	xor  #50   xorAddress1 (xorAddress[1], Address1[1], Address2[1]);
	xor  #50   xorAddress2 (xorAddress[2], Address1[2], Address2[2]);
	xor  #50   xorAddress3 (xorAddress[3], Address1[3], Address2[3]);
	xor  #50   xorAddress4 (xorAddress[4], Address1[4], Address2[4]);
	
	or   #50   U1          (Or_Out, xorAddress[0], xorAddress[1], xorAddress[2], xorAddress[3], xorAddress[4]);
	not  #50   U2          (equal, Or_Out);

endmodule


module Forwarding_Unit(output wire [1:0] ForwardA, ForwardB,
					   input  wire	   	 Mem_RegWrite, WB_RegWrite,
					   input  wire [4:0] Mem_WriteRegister, WB_WriteRegister, EX_rs, EX_rt);
	
	// CompareAddress module outputs one if addresses are equal
	CompareAddress U1 (b, MEM_WriteRegister, EX_rs); 
	CompareAddress U8 (b1, MEM_WriteRegister, EX_rt);
	CompareAddress U9 (d1, WB_WriteRegister, EX_rt);
	CompareAddress U2 (d, WB_WriteRegister, EX_rs);
	
	or  #50 U2 (a, MEM_WriteRegister[4], MEM_WriteRegister[3], 
   		           MEM_WriteRegister[2], MEM_WriteRegister[1],MEM_WriteRegister[0]);
	 
	or  #50 U4 (c, WB_WriteRegister[4], WB_WriteRegister[3],
				   WB_WriteRegister[2], WB_WriteRegister[1], WB_WriteRegister[0]);
	
	and #50 U3  (x,  MEM_RegWrite, a, b);
	and #50 U5  (y,  WB_RegWrite,  c, d);
	and #50 U10 (x1, MEM_RegWrite, a, b1);
	and #50 U11 (y1, WB_RegWrite,  c, d1);
	
	
	assign ForwardA[1] = x;
	not #50 U6 (notx, x);
	and #50 U7 (ForwardA[0], notx, y);
	
	assign ForwardB[1] = x1;
	not #50 U12 (notx1, x1);
	and #50 U13 (ForwardB[0], notx1, y1);

endmodule


module WB_forward(output [31:0] ReadData1Out, ReadData2Out, 
				  input  [31:0] ReadData1, ReadData2, WriteData,
				  input  [4:0]  rs, rt, WriteRegister, 
				  input 		RegWrite);

	wire ReadSourceRs, ReadSourceRt;
	wire compOut1, compOut2;

	always @(rs or rt or WriteRegister or WriteData or RegWrite)
	begin
	  if ((RegWrite == 1) && (WriteRegister != 0) && (WriteRegister == rs))
	  ReadSourceRs = 1'b1; //Forwarding WriteData to ReadData1
	  else 
	  ReadSourceRs = 1'b0;
	  if ((RegWrite == 1) && (WriteRegister != 0) && (WriteRegister == rt))
	  ReadSourceRt = 1'b1; //Forwarding WriteData to ReadData2
	  else s
	  ReadSourceRt = 1'b0;
	end

endmodule



