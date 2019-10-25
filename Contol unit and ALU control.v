module Control(ALUControl,opcode, funct, ALUSrc, RegDst, MemWrite, MemRead, Beq, Bne, Jump, MemToReg, RegWrite );
  input [5:0] opcode, funct;
  output reg ALUSrc, RegDst, MemWrite, MemRead, Beq, Bne, Jump, MemToReg,RegWrite;
  output reg [3:0] ALUControl;

  always @(*) begin
    case (opcode)
    // R-type
    'b 000000: begin
      ALUSrc <= 0;
      RegDst <= 1;
      MemWrite <= 0;
      MemRead <= 0;
      Beq <= 0;
      Bne <= 0;
      Jump <= 0;
      MemToReg <= 0;
      RegWrite <= 1;

      case (funct)
      // ADD
      'b 100000: ALUControl <= 'b 0010;
      // SUB
      'b 100010: ALUControl <= 'b 0110;
      // AND
      'b 100100: ALUControl <= 'b 0000;
      // OR
      'b 100101: ALUControl <= 'b 0001;
      // SLT
      'b 101010: ALUControl <= 'b 0111;
      // sLL
      'b 000000: ALUControl <= 'b 1110;
      endcase
    end

    // lw
    'b 100011: begin
      ALUSrc <= 1;
      RegDst <= 0;
      MemWrite <= 0;
      MemRead <= 1;
      Beq <= 0;
      Bne <= 0;
      Jump <= 0;
      MemToReg <= 1;
      RegWrite <= 1;
      // ADD
      ALUControl <= 'b 0010;
    end

    // sw
    'b 101011: begin
      ALUSrc <= 1;
      MemWrite <= 1;
      MemRead <= 0;
      Beq <= 0;
      Bne <= 0;
      Jump <= 0;
      RegWrite <= 0;
      // ADD
      ALUControl <= 'b 0010;
    end

    // beq
    'b 000100: begin
      ALUSrc <= 0;
      MemWrite <= 0;
      MemRead <= 0;
      Beq <= 1;
      Bne <= 0;
      Jump <= 0;
      RegWrite <= 0;
      // SUB
      ALUControl <= 'b 0110;
    end

    // bne
    'b 000101: begin
      ALUSrc <= 0;
      MemWrite <= 0;
      MemRead <= 0;
      Beq <= 0;
      Bne <= 1;
      Jump <= 0;
      RegWrite <= 0;
      // SUB
      ALUControl <= 'b 0110;
    end

    // Jump
    'b 000010: begin
      MemWrite <= 0;
      MemRead <= 0;
      Beq <= 0;
      Bne <= 0;
      Jump <= 1;
      RegWrite <= 0;
    end

    // addi
    'b 001000: begin
      ALUSrc <= 1;
      RegDst <= 0;
      MemWrite <= 0;
      MemRead <= 0;
      Beq <= 0;
      Bne <= 0;
      Jump <= 0;
      MemToReg <= 0;
      RegWrite <= 1;
      // ADD
      ALUControl <= 'b 0010;
    end
   //ori 
    'b 001101:begin
    ALUSrc <= 1;
    RegDst <= 0;
    MemWrite <= 0;
    MemRead <= 0;
    Beq <= 0;
    Bne <= 0;
    Jump <= 0;
    MemToReg <= 0;
    RegWrite <= 1;
    // or
    ALUControl <='b 0001;
    end
    endcase
  end
endmodule



module tb_control();
reg[5:0] opcode,funct;
wire ALUSrc, RegDst, MemWrite, MemRead, Beq, Bne, Jump, MemToReg,RegWrite;
wire [3:0] ALUControl;

Control c(ALUControl,opcode, funct, ALUSrc, RegDst, MemWrite, MemRead, Beq, Bne, Jump, MemToReg, RegWrite );

initial 
begin
#5
 
opcode<=6'b000010;
//funct <=6'b100000;

$monitor("ALUControl->%b,opcode->%b, funct->%b, ALUSrc->%b, RegDst->%b, MemWrite->%b, MemRead->%b, Beq->%b, Bne->%b, Jump->%b, MemToReg->%b, RegWrite->%b",ALUControl,opcode, funct, ALUSrc, RegDst, MemWrite, MemRead, Beq, Bne, Jump, MemToReg, RegWrite);


end
endmodule
