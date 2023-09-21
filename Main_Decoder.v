module Main_Decoder(
    input wire [6:0] op,
    //input wire Zero,
    output reg [1:0] ALUOp,
    output reg Branch,
    output reg [1:0] ResultSrc,
    output reg MemWrite,
    output reg MemRead,
    output reg ALUSrc,
    output reg [1:0] ImmSrc,
    output reg Jump,
    output reg RegWrite
);


always @(*) begin
  case (op)
  7'b0000011 : {RegWrite,ImmSrc,ALUSrc,MemWrite,MemRead,ResultSrc,Branch,ALUOp,Jump} = 12'b100101010000;
  7'b0100011 : {RegWrite,ImmSrc,ALUSrc,MemWrite,MemRead,ResultSrc,Branch,ALUOp,Jump} = 12'b001110000000;
  7'b0110011 : {RegWrite,ImmSrc,ALUSrc,MemWrite,MemRead,ResultSrc,Branch,ALUOp,Jump} = 12'b100000000100;
  7'b1100011 : {RegWrite,ImmSrc,ALUSrc,MemWrite,MemRead,ResultSrc,Branch,ALUOp,Jump} = 12'b010000001010;
  7'b0010011 : {RegWrite,ImmSrc,ALUSrc,MemWrite,MemRead,ResultSrc,Branch,ALUOp,Jump} = 12'b100100000100;
  7'b1101111 : {RegWrite,ImmSrc,ALUSrc,MemWrite,MemRead,ResultSrc,Branch,ALUOp,Jump} = 12'b111000100001;
  default : {RegWrite,ImmSrc,ALUSrc,MemWrite,MemRead,ResultSrc,Branch,ALUOp,Jump} = 12'b000000000000;
  endcase
   
end


endmodule