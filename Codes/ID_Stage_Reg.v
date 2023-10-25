module ID_Stage_Reg(
	input clk, rst, flush, WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN, B_IN, S_IN,
	input [3:0] EXE_CMD_IN,
	input [31:0] PC_IN, Val_Rn_IN, Val_Rm_IN,
	input imm_IN,
	input [11:0] Shift_operand_IN,
	input [23:0] Signed_imm_24_IN,
	input [3:0] Dest_IN,
	output reg WB_EN, MEM_R_EN, MEM_W_EN, B, S,
	output reg [3:0] EXE_CMD,
	output reg [31:0] PC, Val_Rn, Val_Rm, 
	output reg imm, 
	output reg [11:0] Shift_operand,
	output reg [23:0] Signed_imm_24,
	output reg [3:0] Dest
);

endmodule