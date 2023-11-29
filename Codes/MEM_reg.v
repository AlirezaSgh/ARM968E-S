module MEM_reg (
    input clk,
    rst,
    WB_en_in,
    MEM_R_en_in,
    input [31:0] ALU_result_in,
    Mem_read_value_in,
    input [3:0] Dest_in,
    output reg WB_en,
    MEM_R_en,
    output reg [31:0] ALU_result,
    Mem_read_value,
    output reg [3:0] Dest
);
  always @(posedge clk) begin
    if (rst) {WB_en, MEM_R_en, ALU_result, Mem_read_value, Dest} = 70'b0;
    else begin
      Dest <= Dest_in;
      Mem_read_value <= Mem_read_value_in;
      ALU_result <= ALU_result_in;
      MEM_R_en <= MEM_R_en_in;
      WB_en <= WB_en_in;
    end
  end
endmodule
