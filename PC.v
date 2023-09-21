module PC(

input  [31:0] PC_IN,
input clk,
input rst,
input EN,
output reg [31:0] PC_OUT

);

always @(posedge clk , negedge rst ) begin
    
    if (rst==0)
        PC_OUT<=32'b0;
    else if (!EN)
    PC_OUT<=PC_IN;


end

endmodule