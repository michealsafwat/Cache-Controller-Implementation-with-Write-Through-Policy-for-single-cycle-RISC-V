module MemoryTop(

input wire clk,
input wire reset_n,
input wire MemRead,
input wire MemWrite,
input wire [9:0] WordAddress,
input wire [31:0] DataIn,
output wire Stall,
output wire [31:0] DataOut

);

wire [127:0] datablock;
wire MISS, READY;


DataMemory D_MEM(
.clk(clk),
.reset_n(reset_n),
.miss(MISS),
.A(WordAddress),
.WD(DataIn),
.WE(MemWrite),
.DataBlock(datablock),
.ready(READY)
);

CacheMemory C_MEM (
.clk(clk),
.reset_n(reset_n),
.DataBlock(datablock),
.Data_in(DataIn),
.index(WordAddress[6:2]),
.offset(WordAddress[1:0]),
.miss(MISS),
.WE(MemWrite),
.ready(READY),
.DataOut(DataOut)

);


CacheController control(
.clk(clk),
.reset_n(reset_n),
.MemRead(MemRead),
.MemWrite(MemWrite),
.WordAddress(WordAddress),
.stall(Stall),
.ready(READY),
.miss(MISS)
//.fill(FILL)



);


endmodule