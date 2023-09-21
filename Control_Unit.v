module Control_Unit (
    input wire funct_7,
    input wire [2:0] funct_3,
    input wire [6:0] op,
    input wire Zero,
    output wire Branch,
    output wire [1:0] ResultSrc,
    output wire MemWrite,
    output wire MemRead,
    output wire ALUSrc,
    output wire [1:0] ImmSrc,
    output wire Jump,
    output wire RegWrite,
    output wire pcsrc,
    output wire [2:0] ALUControl
    );
////////
wire [1:0] aluop;
////////////
   Main_Decoder Decoder  (   
    .op(op),
   // .Zero(Zero),
    .ALUOp(aluop),
    .Branch(Branch),
    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .Jump(Jump),
    .RegWrite(RegWrite)
    );

////////////                      
ALU_Decoder ALUCtrl  (  
    .funct_7(funct_7),
    .op_5(op[5]),
    .funct_3(funct_3),
    .ALUOp(aluop),
    .ALUControl(ALUControl)
    );

    assign pcsrc = (Branch & Zero) | Jump;

endmodule