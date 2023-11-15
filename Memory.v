module Memory (
    input clk,
    MEMread,
    MEMwrite,
    input [31:0] address,
    data,
    output [31:0] MEM_result
);
  reg [31:0] mem_reg[0:63];
  initial begin
    integer i;
    for (i = 0; i < 64; i++) mem_reg[i] = i;
  end
  reg [31:0] calculated_address;
  assign calculated_address = (address - 1024)>>2;
  always @(clk) begin
    if (MEMread) begin
      MEM_result <= mem_reg[calculated_address];
    end else if (MEMwrite) begin
      mem_reg[calculated_address] <= data;
    end
  end
endmodule