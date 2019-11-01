module register(data1,data2,writeReg,writeData,regWrite,clk,read1,read2,reset);

input [4:0] read1,read2,writeReg;
input [31:0] writeData ;
input regWrite,clk,reset;
output reg [31:0] data1,data2;

integer file,i;

reg[31:0] rf [0:31];
/*
always @(read1 or read2)
begin

	file = $fopen("C:/Code/register.txt","w");
	for(i=0;i<32;i=i+1)
	begin   
	$fwrite(file,"%b\n",rf[i]); 
	end
	$fclose(file);$display("end");
	$stop();

end
*/

always @(reset)
begin
rf[0]<=32'h00000000;
rf[1]<=32'h00000000;
rf[2]<=32'h00000000;
rf[3]<=32'h00000000;
rf[4]<=32'h00000000;
rf[5]<=32'h00000000;
rf[6]<=32'h00000000;
rf[7]<=32'h00000000;
rf[8]<=32'h00000000;
rf[9]<=32'h00000000;
rf[10]<=32'h00000000;
rf[11]<=32'h00000000;
rf[12]<=32'h00000000;
rf[13]<=32'h00000000;
rf[14]<=32'h00000000;
rf[15]<=32'h00000000;
rf[16]<=32'h00000000;
rf[17]<=32'h00000000;
rf[18]<=32'h00000000;
rf[19]<=32'h00000000;
rf[20]<=32'h00000000;
rf[21]<=32'h00000000;
rf[22]<=32'h00000000;
rf[23]<=32'h00000000;
rf[24]<=32'h00000000;
rf[25]<=32'h00000000;
rf[26]<=32'h00000000;
rf[27]<=32'h00000000;
rf[28]<=32'h00000000;
rf[29]<=32'h00000000;
rf[30]<=32'h00000000;
rf[31]<=32'h00000000;
end

always@(read1 or read2)
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
