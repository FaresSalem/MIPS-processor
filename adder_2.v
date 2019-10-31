module adder_2(addin,shiftin,result);

output reg[12:0] result;
input [12:0] addin;
input [12:0] shiftin;

initial result<=13'h0000;

always @(addin,shiftin)
begin
result<=shiftin+addin;
end
endmodule


