//*modified
module Reg_File(

input [4:0] A1,
input [4:0] A2,
input [4:0] A3,
input [31:0] WD3,
input clk,rst,
input WE3,
output  [31:0] RD1,
output  [31:0] RD2
);
integer i;
reg[31:0] RegFile[0:31];
assign RD1=RegFile[A1];
assign RD2=RegFile[A2];

/*initial begin
    $readmemh("Program 2_Machine Code.txt",RegFile);
end*/

 /*always @(*) begin  //causes latches
     if (WE3==0) begin
        RD1<= RegFile[A1];
        RD2<= RegFile[A2];
    end
    
 end*/

 always @(negedge clk,negedge rst) begin
   if(!rst)begin
     for(i=0;i<32;i=i+1)begin
       RegFile[i]<={32{1'b0}};
     end
   end
      else if (WE3==1'b1) begin
     RegFile[A3]<= WD3;
      end
 end


endmodule