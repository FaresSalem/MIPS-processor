`timescale 1ns/1ns
module clock(clk);
output reg clk;
initial
clk=1;
always
begin
#31.25
clk=~clk;
end
endmodule