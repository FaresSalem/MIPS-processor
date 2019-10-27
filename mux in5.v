module mux_in5(in1,in2,sel,out);

input [4:0] in1,in2;
input [1:0] sel;
output reg [4:0] out;

always@(sel or in1 or in2)
begin 
if(sel == 0)
	out<=in1;
else if(sel ==1)
	out<=in2;
else
	out<=4'bx;
end
endmodule


module tb_mux_in5();

reg  [4:0] in1,in2;
reg  [1:0] sel;
wire [4:0] out;
mux_in5 a(in1,in2,sel,out);
initial 
begin 
sel=0;
in1=5'b00000;
in2=5'b11111;

$monitor("sel--->%b,out--->%b",sel,out);
#5
sel=1;
#5
sel=1;
#5
sel=0;
#5
sel=1;
#5
sel=0;
end
endmodule
