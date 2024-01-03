module EXE_Stage (
    input         clk,
    input  [ 3:0] EXE_CMD,
    input         MEM_R_EN,
    MEM_W_EN,
    input  [31:0] PC,
    Val_Rn,
    Val_Rm,
    ALU_res_in,
    WB_data,  //added for forwarding
    input         imm,
    input  [11:0] Shift_operand,
    input  [23:0] Signed_imm_24,
    input  [ 3:0] SR,
    input  [ 1:0] sel_src1,
    sel_src2,  //added for forwarding
    output [31:0] ALU_result,
    mux2_out,  //added for forwarding
    Br_addr,
    output [ 3:0] status
);

  wire bypass_rm;
  wire [31:0] val2, extended_imm, shifted_imm, mux1_out;
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
  assign mux1_out = (sel_src1 == 2'b00) ? Val_Rn :  //Forwarding Mux1
      (sel_src1 == 2'b01) ? ALU_res_in : (sel_src1 == 2'b10) ? WB_data : Val_Rn;
  assign mux2_out = (sel_src2 == 2'b00) ? Val_Rm :
                    (sel_src2 == 2'b01) ? ALU_res_in :
                    (sel_src2 == 2'b10) ? WB_data :
                    Val_Rm;

  Val2Generator v2gen (
      imm,
      bypass_rm,
      mux2_out,
      Shift_operand,
      val2
  );
  ALU alu (
      mux1_out,
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
