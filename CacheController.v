module CacheController (

    input wire clk,
    input wire reset_n,
    input wire MemRead,
    input wire MemWrite,
    input wire [9:0] WordAddress,
    input wire ready,

    output reg stall,
    output reg miss
    //output reg fill


);

  reg fill;
  reg [1:0] current_state;
  reg [1:0] next_state;

  reg [2:0] tag_array[0:31];
  reg valid_array[0:31];

  reg [1:0] offset;
  reg [4:0] index;
  reg [2:0] tag;

  localparam IDLE = 2'b00;
  localparam WRITE = 2'b01;
  localparam READ = 2'b11;

  integer i = 0;
  always @(negedge clk or negedge reset_n) begin
    if (!reset_n) begin
      current_state <= IDLE;
      for (i = 0; i < 32; i = i + 1) begin
        valid_array[i] <= 1'b0;
        tag_array[i]   <= 3'b0;
      end
    end else begin
      current_state <= next_state;
    end
  end




  always @(*) begin
    index = WordAddress[6:2];
    offset = WordAddress[1:0];
    tag = WordAddress[9:7];

    case (current_state)
      IDLE: begin
        stall = 1'b0;
        fill  = 1'b0;

        if (MemRead == 1'b1) begin
          miss = 1'b0;
          next_state = READ;

        end else if (MemWrite == 1'b1) begin
          miss = 1'b1;
          next_state = WRITE;
        end else next_state = IDLE;
      end


      WRITE: begin
        if (valid_array[index] == 1'b0) begin // miss
          miss  = 1'b1;
          stall = 1'b1;
          fill  = 1'b0;
          if (ready) begin
            stall = 1'b0;
            fill = 1'b0;
            miss = 1'b1;
            next_state = IDLE;
          end else begin
            miss = 1'b1;
            stall = 1'b1;
            fill = 1'b0;
            next_state = WRITE;
          end
        end else begin // hit 
          miss = 1'b0;
          stall = 1'b1;
          
          if (ready) begin
            miss = 1'b0;
            stall = 1'b0;
            fill = 1'b1;
            tag_array[index] = tag;
           valid_array[index] = 1'b1;
            next_state = IDLE;

          end else begin
            miss = 1'b0;
            stall = 1'b1;
            next_state = WRITE;
          end
        end
      end

      READ: begin
        if (tag_array[index] == tag && valid_array[index] == 1'b1) begin  //hit
          miss = 1'b0;
          stall = 1'b0;
          next_state = IDLE;

        end else begin  // miss
          miss  = 1'b1;
          stall = 1'b1;
          if (ready) begin
            stall = 1'b0;
            fill = 1'b1;
            tag_array[index] = tag;
            valid_array[index] = 1'b1;
            next_state = IDLE;

          end else begin
            miss = 1'b1;
            stall = 1'b1;
            next_state = READ;
          end
        end
      end

      default: next_state = IDLE;
    endcase
  end
endmodule
