module pc(pcResult,pcNext,reset,clk);
input[12:0] pcNext;
input clk,reset;
output reg[12:0] pcResult;

//initial pcResult<=13'h0000;

always @ (posedge clk)
begin
if(reset == 1)
	pcResult<=13'h0000;
else
	pcResult<=pcNext;
end
endmodule


module tb_pc();
reg clk=0,reset=0;
reg[12:0] pcNext;
wire [12:0] pcResult;
pc p(pcResult,pcNext,reset,clk);
initial
begin
clk=0;
pcNext<=13'b00000000000;
$monitor("pcresult : %b,pcnext : %b,reset : %b, clk : %b",pcResult,pcNext,reset,clk);
#5
clk=~clk;
pcNext<=13'b00000000010;
#5
clk=~clk;
#5
clk=~clk;
pcNext<=13'b00000000111;
#5
clk=~clk;
#5
clk=~clk;
pcNext<=13'b00000000101;
end 
endmodule

