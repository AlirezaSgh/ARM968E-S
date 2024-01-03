module IF_Stage_TB;
  reg clk = 0, rst = 1, freeze = 0, Branch_Taken = 0;
  reg [31:0] Branch_Address = 0;
  wire [31:0] PC, Instruction;
  IF_Stage IFS (
      clk,
      rst,
      freeze,
      Branch_Taken,
      Branch_Address,
      PC,
      Instruction
  );
  // wire     WB_EN, MEM_R_EN, MEM_W_EN, B, S;
  // ID_Stage IDS(
  // 	clk, rst, 
  //     //From IF Reg
  // 	Instruction,
  //     //From WB Stage
  //     0,
  //     0,
  //     0,
  //     //From Hazard Detect Module
  //     0,
  //     //from Status Register
  //     0,
  //     //To Next Stage
  //     WB_EN, MEM_R_EN, MEM_W_EN, B, S,
  //     EXE_CMD,
  //     Val_Rn, Val_Rm,
  //     imm,
  //     Shift_operand,
  //     Signed_imm_24,
  //     Dest,
  //     //To Hazard Detect Module
  //     src1, src2,
  //     Two_src
  // );

  initial begin
    repeat (1000000) #10 clk = ~clk;
  end

  initial begin
    #25 rst = 0;
    freeze = 1;
  end

endmodule
