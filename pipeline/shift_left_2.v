module shift_left_2(in,out);
input [31:0] in;
output reg [31:0] out;
always @(in)
begin
out<=in<<2;
end
endmodule

module tb_shift();
reg [31:0] in;
wire [31:0] out;
shift_left_2 s(in,out);
initial
begin
$monitor("in : %b,out : %b",in,out);
#5
in=32'hf0991239;
#5
in=32'hf0114321;
end
endmodule
