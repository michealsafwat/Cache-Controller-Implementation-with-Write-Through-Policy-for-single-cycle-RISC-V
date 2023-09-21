module MUX_2x1 # (parameter N = 32)(
// define input  port
input wire [N-1:0] in1,
input wire[N-1:0] in2, 
input wire select,
// define the output port
output wire [N-1:0]out
);
// assign one of the inputs to the output based upon select line input
assign out = (select==1'b1) ? in2 : in1;
endmodule 