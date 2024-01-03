module Memory (
    input clk,
    MEMread,
    MEMwrite,
    input [31:0] address,
    data,
    output [31:0] MEM_result
);
  reg [31:0] mem_reg[0:63];
  integer i;
  initial begin
    for (i = 0; i < 64; i = i + 1) mem_reg[i] = i;
  end
  wire [31:0] calculated_address;
  assign calculated_address = (address >= 1024) ? ((address - 1024) >> 2) : 0;
  assign MEM_result = MEMread ? mem_reg[calculated_address] : 0;
  always @(posedge clk) begin
    if (MEMwrite) begin
      mem_reg[calculated_address] <= data;
    end
  end
endmodule
