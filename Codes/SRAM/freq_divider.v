module freq_div #(
    parameter width = 10
) (
    input clk,
    output reg co
);
  reg [1:0] count;
  initial begin
    co = 0;
    count = 0;
  end
  //   reg [width-1:0] count;
  always @(posedge clk) begin
    // co <= ~co;
    {co, count} <= count + 2'd1;
  end
endmodule
