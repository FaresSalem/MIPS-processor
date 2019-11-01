module adder_13bit(result,pc_in);

output reg[12:0] result;
input [12:0] pc_in;
//wire [12:0] const;

//initial result<=13'h0000;

always @(pc_in)
begin
result<=pc_in+13'h0001;
end
endmodule


module tb_adder_13bit();
wire[12:0] result;
reg[12:0] pc_in;

adder_13bit a(result,pc_in);

initial
begin
pc_in<=13'b0000000000000;
$monitor("pc_in-->%b,result-->%b",pc_in,result);
#5
pc_in<=13'b0000000000000;
#5
pc_in<=13'b0000000000001;
#5
pc_in<=13'b0000000000011;

end
endmodule

