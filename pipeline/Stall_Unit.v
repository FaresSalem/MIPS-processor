//`timescale 1 ps / 100 fs
`timescale 1ns/1ns // our clk

module StallControl(output wire 	  PC_WriteEn, IFID_WriteEn, Stall_flush,
					input  wire 	  EX_MemRead,
					input  wire [4:0] EX_rt, ID_rs, ID_rt,
					input  wire [5:0] Opcode);

	always @(EX_MemRead or EX_rt or ID_rs or ID_rt)
	begin
	 if ((EX_MemRead == 1) && ((EX_rt == ID_rs) || ((EX_rt == ID_rt) && (Opcode != 6'b001101) && (Opcode != 6'b100011) && (Opcode != 6'b001000)))
	  begin
	  PC_WriteEn   = 1'b0;
	  IFID_WriteEn = 1'b0;
	  Stall_flush  = 1'b1;
	  end
	 else
	  begin
	  PC_WriteEn   = 1'b1;
	  IFID_WriteEn = 1'b1;
	  Stall_flush  = 1'b0;
	  end
	end

endmodule


module module flush_block(output 	   ID_RegDst, ID_ALUSrc, ID_MemtoReg, ID_RegWrite,
						  output 	   ID_MemRead, ID_MemWrite, ID_Branch, ID_JRControl,
						  output [1:0] ID_ALUOp,
						  input  [1:0] ALUOp,
						  input 	   flush, RegDst, ALUSrc, MemtoReg, RegWrite,
									   MemRead, MemWrite, Branch, JRControl);

	not #50    	(notflush, flush);
	and #50 U1 	(ID_RegDst, RegDst, notflush);
	and #50 U2 	(ID_ALUSrc, ALUSrc, notflush);
	and #50 U3 	(ID_MemtoReg, MemtoReg, notflush);
	and #50 U4 	(ID_RegWrite, RegWrite, notflush);
	and #50 U5 	(ID_MemRead, MemRead, notflush);
	and #50 U6 	(ID_MemWrite, MemWrite, notflush);
	and #50 U7 	(ID_Branch, Branch, notflush);
	and #50 U8 	(ID_JRControl, JRControl, notflush);
	and #50 U9 	(ID_ALUOp[1], ALUOp[1], notflush);
	and #50 U10	(ID_ALUOp[0], ALUOp[0], notflush);

endmodule


module Discard_Instr(output ID_flush, IF_flush,
				     input  jump, bne, jr);

	or #50 U1 (IF_flush, jump, bne, jr);
	or #50 U2 (ID_flush, bne, jr);

endmodule