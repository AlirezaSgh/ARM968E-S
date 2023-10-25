module ID_Stage(
	input clk, rst, 
    //From IF Reg
	input [31:0] Instruction,
    //From WB Stage
    input [31:0] Result_WB,
    input writeBackEN,
    input [3:0] Dest_wb,
    //From Hazard Detect Module
    input hazard,
    //from Status Register
    input [3:0] SR,
    //To Next Stage
    output WB_EN, MEM_R_EN, MEM_W_EN, B, S,
    output [3:0] EXE_CMD,
    output [31:0] Val_Rn, Val_Rm,
    output imm,
    output [11:0] Shift_operand,
    output [23:0] Signed_imm_24,
    output [3:0] Dest,
    //To Hazard Detect Module
    output [3:0] src1, src2,
    output Two_src
);
    wire [11:0] OPC_shifter_operand;
    wire [3:0] cond, OPCOde, Rn, Rd, rotate_imm, immed_8, CU_EXE_CMD;
    wire [1:0] OPC_mode;
    wire OPC_I, OPC_S, CU_B, CU_S, CU_WB_EN, CU_MEM_R_EN, CU_MEM_W_EN;
    assign cond = Instruction[31:28];
    assign mode = Instruction[27:26];
    assign OPC_I = Instruction[25];
    assign OPCode = Instruction[24:21];
    assign OPC_S = Instruction[20];
    assign Rn = Instruction[19:16];
    assign Rd = Instruction[15:12];
    assign OPC_shifter_operand = Instruction[11:0];
    MUX register_file_mux(Rd, Instruction[3:0], MEM_W_EN);
    MUX #9 cond_mux({CU_EXE_CMD, CU_WB_EN, CU_MEM_R_EN, CU_MEM_W_EN, CU_B, CU_S}, 9'b0,,{EXE_CMD, WB_EN, MEM_R_EN, MEM_W_EN, B, S});
    Condition_Check condition_check();
    RegisterFile register_file(clk, rst, Rn, , Des_wb, Result_WB, writeBackEN, Val_Rn, Val_Rm);
    ControlUnit control_unit(OPCode, mode, OPC_S, OPC_I, CU_EXE_CMD, CU_WB_EN, CU_MEM_R_EN, CU_MEM_W_EN, CU_B, CU_S);
endmodule