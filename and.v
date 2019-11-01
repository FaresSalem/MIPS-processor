module and_gate(in1,in2,out);

input in1,in2;
output reg out;


always @(*)
begin
	out<=in1&in2;
end
endmodule



module tb_and();

reg in1,in2;
wire out;

and_gate a1(in1,in2,out);
initial
begin

in1=0;
in2=0;

$monitor("in1-->%b  in2-->%b  out-->%b",in1,in2,out);

#5
in1=1;
in2=0;

#5
in1=0;
in2=1;

#5
in1=1;
in2=1;

end
endmodule
