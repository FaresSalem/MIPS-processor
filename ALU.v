module alu ( aluout ,zero,aluin1,aluin2,aluco);

input[3:0] aluco ;
input[31:0] aluin1 ;
input[31:0] aluin2  ;
output reg [31:0] aluout;
output zero;

assign zero=(aluout == 0);

always@(aluin1,aluin2,aluco)
begin
case(aluco)
0  : aluout <= (aluin1&aluin2);
1  : aluout <= (aluin1|aluin2)  ;
2  : aluout <= (aluin1+aluin2) ;
6  : aluout <=(aluin1-aluin2) ;
7  : aluout <= (aluin1<aluin2)?1:0 ;
12 : aluout <= ~(aluin1|aluin2) ;

default : aluout <= 32'bxxxxxxxx;
endcase
end

endmodule

module tb_alu();

reg [31:0] aluin1,aluin2;
reg [3:0] aluco;
wire [31:0] aluout;
wire zero;

alu a(aluout,zero,aluin1,aluin2,aluco);

initial
begin

$monitor("%b %b %b %b %b",aluout,zero,aluco,aluin1,aluin2);

#3
aluin1=32'b 00001000;
aluin2=32'b 00000100;
aluco=0;
#3
aluin1=32'b00001000;
aluin2=32'b00000100;
aluco=1;
#3
aluin1=8'b00001000;
aluin2=8'b00000100;
aluco=2;
#3
aluin1=8'b00001000;
aluin2=8'b00000100;
aluco=6;
#3
aluin1=8'b00001000;
aluin2=8'b00000100;
aluco=7;
#3
aluin1=8'b00001000;
aluin2=8'b00000100;
aluco=12;
end
endmodule

