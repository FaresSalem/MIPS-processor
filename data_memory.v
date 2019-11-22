module data_memory(read_data,address,write_data,memread,memwrite,clk);

output reg[31:0] read_data;
input memread,memwrite,clk;
input [12:0] address;
input [31:0] write_data;

integer file,i;

reg[31:0] mem[0:8191];
/*
always @(memread or memwrite)
begin

	file = $fopen("C:/Code/dataMemory.txt","w");
	for(i=0;i<8192;i=i+1)
	begin   
	$fwrite(file,"%b\n",mem[i]); 
	end
	$fclose(file);$display("end");
	$stop();

end
*/
always@(*)
begin
if(memread == 1)
    read_data<=mem[address];
end

always @(posedge clk)
begin 
if(memwrite == 1)   
     mem[address]<=write_data;
end 

endmodule

module tb_data_memory();
reg clk;
reg [31:0] write_data;
reg [12:0] address;
reg memread,memwrite;
wire [31:0]read_data;
data_memory m (read_data,address,write_data,memread,memwrite,clk);
initial

begin
$monitor("read_data %b,address %b,write_data %b,memread %b,memwrite %b,clk %b",read_data,address,write_data,memread,memwrite,clk);
clk=1;
#5
write_data=32'h12345678;
address=13'b0000000000000;
memwrite=1;
memread=0;
clk=0;

#5
clk=1;
#5

address=13'b0000000000000;
memread=1;
memwrite=0;
clk=0;

end
endmodule
