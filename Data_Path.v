module Data_Path(

    input wire clk,
    input wire reset_n,
    input wire [31:0] ReadData,
    input wire [31:0] Instr,
    input wire PCSrc,
    input wire [1:0] ResultSrc,
    input wire ALUSrc,
    input wire [1:0] ImmSrc,
    input wire Jump,
    input wire RegWrite,
    input wire stall,
    input wire [2:0] ALUControl,
    output wire [31:0] WriteData,
    output wire [31:0] ALUResult,
    output wire [31:0] PC,
    
    output wire Zero

);


wire [31:0]  result ,plus4, target_sum, rd1, srcb, imm, pcnext;

  MUX_2x1  pc_mux  (
.in1(plus4),
.in2(target_sum), 
.select(PCSrc),
.out(pcnext)
);


  ALU  alu  (
 .SrcA(rd1),
 .SrcB(srcb),
 .ALUControl(ALUControl),
 .Zero(Zero),
 .ALUResult(ALUResult)
);

  MUX_2x1  alu_src_mux  (
.in1(WriteData),
.in2(imm), 
.select(ALUSrc),
.out(srcb)
);

  Reg_File  reg_file  (
.A1(Instr[19:15]),
.A2(Instr[24:20]),
.A3(Instr[11:7]),
.WD3(result),
.clk(clk),
.rst(reset_n),
.WE3(RegWrite),
.RD1(rd1),
.RD2(WriteData)

);

  MUX_3x1  mux_data_mem_out (
.in1(ALUResult),
.in2(ReadData), 
.in3(plus4),
.select(ResultSrc),
.out(result)
);

  EXTEND  sign_extend  (
.Inst(Instr[31:7]),
.ImmSrc(ImmSrc),
.ImmExt(imm)
);


  PC  pc (
.PC_IN(pcnext),
.clk(clk),
.rst(reset_n),
.EN(stall),
.PC_OUT(PC)

);

/* MemoryTop memtop (
.clk(clk),
.reset_n(reset_n),
.MemRead(!we),
.MemWrite(we),
.WordAddress(alu[9:0]),
.DataIn(write_data),
.Stall(stall),
.DataOut()
); */

  PC_ADDER  pc_plus4 (

.PC(PC),
.PCPlus4(plus4)

);



  ADDER  PCTARGRT  (
.a(PC),
.b(imm),
.sum(target_sum)
);
endmodule