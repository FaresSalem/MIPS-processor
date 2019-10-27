module register(data1,data2,writeReg,writeData,regWrite,clk,read1,read2);

input [4:0] read1,read2,writeReg;
input [31:0] writeData ;
input regWrite,clk;
output reg [31:0] data1,data2;

reg[31:0] rf [0:31];

initial 
begin 
rf[0]<=32'b00000000;
rf[1]<=32'b00000001;
end
always@(read1, read2)
begin
data1<=rf[read1];
data2<=rf[read2];
end
always@(posedge clk)
begin
if(regWrite)
      rf[writeReg]<=writeData;
end
endmodule


module tb_register();

reg [4:0] read1,read2,writeReg;
reg [31:0] writeData ;
reg regWrite,clk;
wire [31:0] data1,data2;

register a(data1,data2,writeReg,writeData,regWrite,clk,read1,read2);

initial 
begin 

regWrite=0;
clk=0;
read1=6'b000000;
read2=6'b000001;
$monitor($time,"data1-->%b,data2-->%b",data1,data2);
#5
clk=1;

end
endmodule
