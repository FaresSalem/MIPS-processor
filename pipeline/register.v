module register(data1,data2,writeReg,writeData,regWrite,clk,read1,read2,reset);

input [4:0] read1,read2,writeReg;
input [31:0] writeData ;
input regWrite,clk,reset;
output reg [31:0] data1,data2;

integer file,i;

reg[31:0] rf [0:31];

always @(read1 or read2)
begin
	file = $fopen("C:/Users/fares/Desktop/assembler/GUI/Register_File.txt","w");
	
	$fwrite(file,"R0		[r0] = %h\n",rf[0]); 
	$fwrite(file,"R1		[at] = %h\n",rf[1]); 
	$fwrite(file,"R2		[v0] = %h\n",rf[2]); 
	$fwrite(file,"R3		[v1] = %h\n",rf[3]); 
	$fwrite(file,"R4		[a0] = %h\n",rf[4]); 
	$fwrite(file,"R5		[a1] = %h\n",rf[5]); 
	$fwrite(file,"R6		[a2] = %h\n",rf[6]); 
	$fwrite(file,"R7		[a3] = %h\n",rf[7]); 
	$fwrite(file,"R8		[t0] = %h\n",rf[8]); 
	$fwrite(file,"R9		[t1] = %h\n",rf[9]); 
	$fwrite(file,"R10 		[t2] = %h\n",rf[10]); 
	$fwrite(file,"R11 		[t3] = %h\n",rf[11]); 
	$fwrite(file,"R12 		[t4] = %h\n",rf[12]); 
	$fwrite(file,"R13 		[t5] = %h\n",rf[13]); 
	$fwrite(file,"R14		[t6] = %h\n",rf[14]); 
	$fwrite(file,"R15 		[t7] = %h\n",rf[15]); 
	$fwrite(file,"R16 		[s0] = %h\n",rf[16]); 
	$fwrite(file,"R17 		[s1] = %h\n",rf[17]); 
	$fwrite(file,"R18 		[s2] = %h\n",rf[18]); 
	$fwrite(file,"R19 		[s3] = %h\n",rf[19]); 
	$fwrite(file,"R20 		[s4] = %h\n",rf[20]); 
	$fwrite(file,"R21 		[s5] = %h\n",rf[21]); 
	$fwrite(file,"R22 		[s6] = %h\n",rf[22]); 
	$fwrite(file,"R23 		[s7] = %h\n",rf[23]); 
	$fwrite(file,"R24 		[t8] = %h\n",rf[24]); 
	$fwrite(file,"R25 		[t9] = %h\n",rf[25]); 
	$fwrite(file,"R26 		[k0] = %h\n",rf[26]); 
	$fwrite(file,"R27 		[k1] = %h\n",rf[27]); 
	$fwrite(file,"R28 		[gp] = %h\n",rf[28]); 
	$fwrite(file,"R29 		[sp] = %h\n",rf[29]); 
	$fwrite(file,"R30 		[s8] = %h\n",rf[30]); 
	$fwrite(file,"R31 		[ra] = %h\n",rf[31]); 
	
	$fclose(file);$display("end");
end


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
