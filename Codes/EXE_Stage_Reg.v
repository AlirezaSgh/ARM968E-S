module EXE_Stage_Reg (
    input clk,
    rst,
    WB_EN_IN,
    MEM_R_EN_IN,
    MEM_W_EN_IN,
    input [31:0] ALU_result_inp,
    ST_val_in,
    input [3:0] Dest_in,
    output reg WB_EN,
    MEM_R_EN,
    MEM_W_EN,
    output reg [31:0] ALU_result,
    Val_Rm,
    output reg [3:0] Dest
);

  always @(posedge clk) begin
    if (rst) {WB_EN, MEM_R_EN, MEM_W_EN, ALU_result, Val_Rm, Dest} <= 71'b0;
    else begin
      WB_EN <= WB_EN_IN;
      MEM_R_EN <= MEM_R_EN_IN;
      MEM_W_EN <= MEM_W_EN_IN;
      ALU_result <= ALU_result_inp;
      Val_Rm <= ST_val_in;
      Dest <= Dest_in;
    end
  end
endmodule
