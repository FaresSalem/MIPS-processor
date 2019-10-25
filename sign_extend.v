module sign_extend(in_16,out_32);
output reg [31:0] out_32;
input [15:0] in_16;
always @(in_16)
begin
if(in_16[15] == 0)
out_32 <= in_16 | 32'h00000000;
else if(in_16[15] == 1)
out_32 <= in_16 | 32'hffff0000;
else
out_32 <= 32'hxxxxxxxx;
end
endmodule

module tb_sign_extend();
reg [15:0] in;
wire [31:0] out;
sign_extend S(in,out);
initial
begin
$monitor("in %b , out %b",in,out);
#5
in=16'h03d2;
#5
in=16'hfacc;
end
endmodule
