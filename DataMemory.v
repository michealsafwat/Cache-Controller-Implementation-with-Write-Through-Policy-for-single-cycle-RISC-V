module DataMemory (
    input clk,
    input reset_n,
    input miss,
    input [9:0] A,
    input [31:0] WD,
    input WE,
    output reg [127:0] DataBlock,
    output reg ready

);

  reg [31:0] data_memory[0:1023];

  reg ready_delay1, ready_delay2, ready_delay3, ready_delay4, ready_delay5 ;
  wire [4:0] index;
  integer i = 0;

assign index = A [9:2];

  always @(posedge clk) begin//read
  //index <= A [6:2];
    if (WE == 0 && miss == 1) begin
      DataBlock <= {data_memory[{index,2'b11}], data_memory[{index,2'b10}], data_memory[{index,2'b01}], data_memory[{index,2'b00}]};
  ready_delay1 <=1'b1;
  ready_delay2 <= ready_delay1;
  ready_delay3 <= ready_delay2;
    ready_delay4 <= ready_delay3;
    //ready_delay5 <= ready_delay4;
    ready <= ready_delay4;
     if (ready) begin
    ready<= 1'b0;
    ready_delay1 <= 1'b0;
    ready_delay2 <= 1'b0;
    ready_delay3 <= 1'b0;
    ready_delay4 <= 1'b0;
    ready_delay5 <= 1'b0;
    DataBlock <= 128'b0;
    end
    end 
    else if (WE == 0 && miss == 0) begin
      ready<= 1'b0;
    ready_delay1 <= 1'b0;
    ready_delay2 <= 1'b0;
    ready_delay3 <= 1'b0;
    ready_delay4 <= 1'b0;
    ready_delay5 <= 1'b0;
    DataBlock <= 128'b0;
    end
  end

  always @(posedge clk) begin
    if (!reset_n) begin
    ready <= 1'b0;
    ready_delay1 <= 1'b0;
    ready_delay2 <= 1'b0;
    ready_delay3 <= 1'b0;
    ready_delay4 <= 1'b0;
    ready_delay5 <= 1'b0;
      for (i = 0; i < 1024; i = i + 1) begin
        data_memory[i] <= 32'b0;
      end
    end else if (WE == 1) begin
      data_memory[A] <= WD;
    ready_delay1 <=1'b1;
  ready_delay2 <= ready_delay1;
  ready_delay3 <= ready_delay2;
  ready_delay4 <= ready_delay3;
 // ready_delay5 <= ready_delay4;
    ready <= ready_delay4;
    if (ready) begin
    ready<= 1'b0;
    ready_delay1 <= 1'b0;
    ready_delay2 <= 1'b0;
    ready_delay3 <= 1'b0;
    ready_delay4 <= 1'b0;
    ready_delay5 <= 1'b0;
    end
    end
  end


endmodule
