module RISC_V(
input wire clk, reset_n

);


wire [31:0] instr, pn_out, alu, res, write_data;
wire we,re;
wire STALL;
// instantiate processor and memories
DATA_CONTROL dp_ctrl (
.clk(clk),
.reset_n(reset_n),
.instruction(instr),
.Result(res),
.PC(pn_out),
.stall(STALL),
.WriteData(write_data),
.ALUResult(alu),
.MemRead(re),
.MemWrite(we)

);


Inst_Mem imem (
    .PC_OUT(pn_out),
    .Instr(instr)
    );

MemoryTop memtop (
.clk(clk),
.reset_n(reset_n),
.MemRead(re),
.MemWrite(we),
.WordAddress(alu[9:0]),
.DataIn(write_data),
.Stall(STALL),
.DataOut(res)
);
endmodule    