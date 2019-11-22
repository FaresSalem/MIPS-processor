module instruction_memory(pc,clk,instruction);
input[12:0] pc;
input clk;
output reg [31:0] instruction;

reg [31:0] memory [0:8191];
initial
begin
    $readmemb("C:/Code/text.txt",memory);
 end

//always @(pc)
always @(negedge clk)
instruction <= memory[pc];


endmodule

module tb_ins_mem();
reg clk=0;
reg [12:0] pc=13'b0000000000000;
wire inst;
integer i;
instruction_memory M(pc,clk,inst);
always
begin
#5
clk=~clk;
end
always @ (posedge clk)
begin
pc=pc+1;
end
initial
begin
$monitor("pc : %b",pc);
end
endmodule
