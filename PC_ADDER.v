module PC_ADDER(

input [31:0] PC,
output [31:0] PCPlus4
);


 assign PCPlus4=32'd4 + PC;
    


endmodule