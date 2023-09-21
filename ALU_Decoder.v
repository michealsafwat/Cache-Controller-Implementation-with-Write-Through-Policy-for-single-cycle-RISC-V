module ALU_Decoder(
    input wire funct_7,
    input wire op_5,
    input wire [2:0] funct_3,
    input wire [1:0] ALUOp,
    output reg [2:0] ALUControl
);

wire [6:0] decoder_in = {ALUOp, funct_3,op_5,funct_7};
always @(*) begin
 casex (decoder_in)
7'b00xxxxx :
                 ALUControl = 000;
7'b01xxxxx :    
                ALUControl = 001; 
7'b100000x :    
                ALUControl = 000; 
7'b1000010 :    
                ALUControl = 000; 
7'b1000011 :    
                ALUControl = 001; 
7'b10010xx :    
                ALUControl = 101; 
7'b10110xx :    
                ALUControl = 011; 
7'b10111xx :    
                ALUControl = 010;
default : ALUControl = 000;
endcase

 
end

endmodule