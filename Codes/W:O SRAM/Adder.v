module Adder (
    in1,
    in2,
    out
);
  parameter width = 32;
  input [width - 1:0] in1, in2;
  output [width - 1:0] out;
  assign out = in1 + in2;
endmodule
