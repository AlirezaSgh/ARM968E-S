module EXE_Stage (
    input clk,
    input [3:0] EXE_CMD,
    input MEM_R_EN,
    MEM_W_EN,
    input [31:0] PC,
    Val_Rn,
    Val_Rm,
    input imm,
    input [11:0] Shift_operand,
    input [23:0] Signed_imm_24,
    input [3:0] SR,
    output [31:0] ALU_result,
    Br_addr,
    output [3:0] status
);

  wire bypass_rm;
  wire [31:0] val2, extended_imm, shifted_imm;
  assign extended_imm = {
    Signed_imm_24[23],
    Signed_imm_24[23],
    Signed_imm_24[23],
    Signed_imm_24[23],
    Signed_imm_24[23],
    Signed_imm_24[23],
    Signed_imm_24[23],
    Signed_imm_24[23],
    Signed_imm_24
  };
  assign shifted_imm = extended_imm << 2;
  assign bypass_rm = MEM_W_EN | MEM_R_EN;
  Val2Generator v2gen (
      imm,
      bypass_rm,
      Val_Rm,
      Shift_operand,
      val2
  );
  ALU alu (
      Val_Rn,
      val2,
      EXE_CMD,
      SR[1],
      status,
      ALU_result
  );
  Adder pc_adder (
      PC,
      shifted_imm,
      Br_addr
  );

endmodule
