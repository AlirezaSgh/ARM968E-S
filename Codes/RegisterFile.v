module RegisterFile (
    input clk,
    rst,
    input [3:0] src1,
    src2,
    Dest_wb,
    input [31:0] Result_WB,
    input writeBackEn,
    output [31:0] reg1,
    reg2
);

  reg [31:0] reg_file[0:15];
  integer i;

  initial begin
    for (i = 0; i < 16; i = i + 1) reg_file[i] <= i;
  end

  always @(negedge clk) begin
    if (rst) begin
      for (i = 0; i < 16; i = i + 1) begin
        reg_file[i] <= i;
      end
    end else if (writeBackEn) begin
      reg_file[Dest_wb] <= Result_WB;
    end
  end

  assign reg1 = reg_file[src1];
  assign reg2 = reg_file[src2];

endmodule
