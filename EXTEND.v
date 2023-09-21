module EXTEND(
input wire [31:7] Inst,
input wire [1:0] ImmSrc,
output reg [31:0] ImmExt
    
);

always @(ImmSrc or Inst) begin

case(ImmSrc)
2'b00: ImmExt = {{20{Inst[31]}}, Inst[31:20]}; // S−type (stores)
2'b01: ImmExt = {{20{Inst[31]}}, Inst[31:25], Inst[11:7]};
// B−type (branches)
 2'b10: ImmExt = {{20{Inst[31]}}, Inst[7], Inst[30:25], Inst[11:8], 1'b0}; // J−type (jal)
  2'b11: ImmExt = {{12{Inst[31]}}, Inst[19:12], Inst[20], Inst[30:21], 1'b0};
   default: ImmExt = 32'bx; // undefined
   endcase 
end

endmodule

