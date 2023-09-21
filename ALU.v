module ALU(

    input wire [31:0] SrcA,
    input wire [31:0] SrcB,
    input wire [2:0] ALUControl,
    output reg Zero,
    output reg [31:0]ALUResult
);



always @(*) begin
  case (ALUControl)
    0:  //ADD
        ALUResult = SrcA + SrcB;
    1:  //SUBTRACT
        ALUResult = SrcA - SrcB;
    2:  // AND
        ALUResult = SrcA & SrcB;
    3: // OR
        ALUResult = SrcA | SrcB;  
    4:  // SUBTRACT
        ALUResult = SrcA - SrcB;
    5:  // SET LESS THAN (SLT)
        ALUResult = SrcA < SrcB ? 1:0;
    
    default:
         ALUResult = 32'd0;
    endcase
 end

always @(*) begin
    if(ALUResult == 0)
        Zero = 1;
    else
        Zero = 0;
    
end

endmodule