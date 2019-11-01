//mux_in1_in2_out
module mux_32_13_32(in1,in2,sel,out);

input [31:0] in1;
input [12:0] in2;
input sel;
output reg[31:0] out;

always @(*)
begin
if(sel == 1)
	out<=(in2| 32'h00000000);
else if(sel == 0)
	out<=in1 ;
end
endmodule

module mux_13_13_13(in1,in2,sel,out);

input [12:0] in1;
input [12:0] in2;
input sel;
output reg[12:0] out;

always @(*)
begin
if(sel == 0)
	out<=in1;
else if(sel == 1)
	out<=in2;
end
endmodule

module mux_32_32_32(in1,in2,sel,out);

input [31:0] in1;
input [31:0] in2;
input sel;
output reg[31:0] out;

always @(*)
begin
if(sel == 0)
	out<=in1;
else if(sel == 1)
	out<=in2;
end
endmodule

module mux_5_5_5(in1,in2,sel,out);

input [4:0] in1;
input [4:0] in2;
input sel;
output reg[4:0] out;

always @(*)
begin
if(sel == 0)
	out<=in1;
else if(sel == 1)
	out<=in2;
end
endmodule


module mux_5_const_5(in1,sel,out);

input[4:0] in1;
input sel;
output reg[4:0] out;

always @(*)
begin
if(sel == 0)
	out<=in1;
else if(sel == 1)
	out<=5'd31;
end
endmodule

module mux_13_32_13(in1,in2,sel,out);

input [12:0] in1;
input [31:0] in2;
input sel;
output reg[12:0] out;

always @(*)
begin
if(sel == 0)
	out<=in2;
else if(sel == 1)
	out<=in1;
end
endmodule