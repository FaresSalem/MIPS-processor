module clock(clk);
output reg clk;
initial
clk=0;
always
begin
#31.25
clk=~clk;
end
endmodule