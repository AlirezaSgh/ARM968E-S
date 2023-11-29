module register (
    clk,
    rst,
    en,
    in,
    out
);
  parameter width = 32;
  input clk, rst, en;
  input [width - 1:0] in;
  output reg [width - 1:0] out;
  initial begin
    out <= 0;
  end
  always @(posedge clk) begin
    if (rst) out <= 0;
    else if (en) out <= in;
  end
endmodule

module status_reg (
    clk,
    rst,
    en,
    in,
    out
);
  input clk, rst, en;
  input [3:0] in;
  output reg [3:0] out;
  initial begin
    out <= 0;
  end
  always @(negedge clk) begin
    if (rst) out <= 0;
    else if (en) out <= in;
  end
endmodule
