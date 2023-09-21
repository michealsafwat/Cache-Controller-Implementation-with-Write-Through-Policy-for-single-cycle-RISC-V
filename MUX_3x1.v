module MUX_3x1 # (parameter N = 32)(
// define input  port
input wire [N-1:0] in1,
input wire[N-1:0] in2, 
input wire[N-1:0] in3, 
input wire [1:0] select,
// define the output port
output wire [N-1:0]out
);
// assign one of the inputs to the output based upon select line input
assign out = select[1]? in3 : ( select[0]? in2 :in1);
endmodule 