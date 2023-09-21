module RSCV_tb();

reg clk_tb;
reg reset_n_tb;
parameter CLK_PERIOD = 10;

initial
begin
  clk_tb = 0;
  reset_n_tb = 0;
  #(CLK_PERIOD)
  reset_n_tb = 1;
#(CLK_PERIOD)


#10000
$stop;
end




always
begin
  #(CLK_PERIOD/2)
  clk_tb = 1;
    #(CLK_PERIOD/2)
  clk_tb = 0;

end


RISC_V dut (

    .clk(clk_tb),
    .reset_n(reset_n_tb)
);



endmodule