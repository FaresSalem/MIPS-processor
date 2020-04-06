`timescale 1ns/1ns

module data_memory(read_data,address,write_data,memread,memwrite,clk);

output reg[31:0] read_data;
input memread,memwrite,clk;
input [12:0] address;
input [31:0] write_data;

integer file,i,j,k=0;

reg[31:0] mem[0:8191];

always @(memwrite)
begin
	#50 // delay between writing to the memory and then writing to the file
	file = $fopen("C:/Users/fares/Desktop/assembler/GUI/Data_Memory.txt","w");

	for(i=0;i<8192;i=i+4)
	begin
		$fwrite(file,"%04d   : ", i);
		$fwrite(file,"%h %h %h %h",mem[i],mem[i+1],mem[i+2],mem[i+3]);
		$fwrite(file,"\n");
		// for (j=0;j<4;j=j+1)
			// begin
			// $display(k);
			// $fwrite(file,"%h ",mem[k]); 
			// k = k + 1;
			// $display(k);
			// end
		
	end
	$fclose(file);
	//$display("end");
//	$stop();

end


always@(address or memread)
begin
if(memread == 1)
    read_data<=mem[4];
end

always @(posedge clk)
begin 
if(memwrite == 1)   
     mem[address]<=write_data;
end 

endmodule

// module tb_data_memory();
// reg clk;
// reg [31:0] write_data;
// reg [12:0] address;
// reg memread,memwrite;
// wire [31:0]read_data;
// data_memory m (read_data,address,write_data,memread,memwrite,clk);
// initial

// begin
// $monitor("read_data %b,address %b,write_data %b,memread %b,memwrite %b,clk %b",read_data,address,write_data,memread,memwrite,clk);
// clk=1;
// #5
// write_data=32'h12345678;
// address=13'b0000000000000;
// memwrite=1;
// memread=0;
// clk=0;

// #5
// clk=1;
// #5

// address=13'b0000000000000;
// memread=1;
// memwrite=0;
// clk=0;

// end



// endmodule
