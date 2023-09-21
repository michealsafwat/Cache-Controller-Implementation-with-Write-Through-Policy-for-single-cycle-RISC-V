module DATA_CONTROL(
input wire clk,
input wire reset_n,
input wire [31:0] instruction,
input wire [31:0] Result,
input wire stall,
output wire [31:0] PC,
output wire [31:0] WriteData,
output wire [31:0] ALUResult,
output wire MemWrite,
output wire MemRead
);


wire pcsrc, branch ;
wire [2:0] alu_control;
wire [1:0] immsrc;
wire [1:0] resultsrc;
Control_Unit ctrl(
    .funct_7(instruction[30]),
    .funct_3(instruction[14:12]),
    .op(instruction[6:0]),
    .Zero(Zero),
    .Branch(branch),
    .ResultSrc(resultsrc),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .ALUSrc(ALUSrc),
    .ImmSrc(immsrc),
    .Jump(Jump),
    .RegWrite(RegWrite),
    .pcsrc(pcsrc),
    .ALUControl(alu_control)
    
);


Data_Path dp (
    .clk(clk),
    .reset_n(reset_n),
    .ReadData(Result),
    .Instr(instruction),
    .PCSrc(pcsrc),
    .ResultSrc(resultsrc),
    .ALUSrc(ALUSrc),
    .ImmSrc(immsrc),
    .Jump(Jump),
    .RegWrite(RegWrite),
    .stall(stall),
    .ALUControl(alu_control),
    .WriteData(WriteData),
    .ALUResult(ALUResult),
    .PC(PC),
    .Zero(Zero)
);


endmodule