module Inst_Mem(

input [31:0] PC_OUT,
output [31:0] Instr
);

reg [31:0] mem[0:99];

initial begin
$readmemh("Program 1_Machine Code.txt",mem);
end

assign Instr = mem[PC_OUT>>2];

endmodule