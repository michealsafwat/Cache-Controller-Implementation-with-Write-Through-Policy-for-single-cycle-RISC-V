module CacheMemory (
    input clk,
    input reset_n,
    input [127:0] DataBlock,
    input [31:0] Data_in,
    input [4:0] index,
    input [1:0] offset,
    input miss,
    input WE,
    input ready,
    output reg [31:0] DataOut


);

  reg [31:0] DataWords[0:3];
  reg [131:0] cache_memory[0:31];
  //reg [31:0] DataOut
  integer i = 0;

  always @(*) begin  //read
    if (WE == 0 && miss == 1'b0) begin  // hit
      case (offset)
        00: DataOut = cache_memory[index][31:0];
        01: DataOut = cache_memory[index][63:32];
        10: DataOut = cache_memory[index][95:64];
        11: DataOut = cache_memory[index][127:96];
      endcase
    end 
    else    if (WE ==0  && miss == 1'b1 && ready== 1'b1)// read miss so write to cache
    begin
      //cache_memory[index] = DataBlock;
            case (offset)
        00: DataOut = cache_memory[index][31:0];
        01: DataOut = cache_memory[index][63:32];
        10: DataOut = cache_memory[index][95:64];
        11: DataOut = cache_memory[index][127:96];
      endcase
    end 
    
 else begin  //miss
      DataOut = 32'b0;
    end 
  end

  always @(posedge clk) begin
    if (!reset_n) begin
      for (i = 0; i < 32; i = i + 1) begin
        cache_memory[i] <= 132'b0;
      end
    end

else if (WE == 1 && miss == 1'b0) begin  // write hit 
      case (offset)
        00: cache_memory[index][31:0] <= Data_in;
        01: cache_memory[index][63:32] <= Data_in;
        10: cache_memory[index][95:64] <= Data_in;
        11: cache_memory[index][127:96] <= Data_in;
      endcase
      //cache_memory[index][31:0] <= Data_in;
    end
else if (WE ==0  && miss == 1'b1)// read miss so write to cache
    begin
      cache_memory[index] <= DataBlock;

    end 

  end

endmodule
