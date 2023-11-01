module EXE_Stage(
	input clk,
	input [3:0] EXE_CMD,
	input MEM_R_EN, MEM_W_EN, 
	input [31:0] PC, Val_Rn, Val_Rm,
	input imm,
	input [11:0] Shift_operand,
	input [23:0] Signed_imm_24,
	input [3:0] SR, 
	output [31:0] ALU_result, Br_addr,
	output [3:0] status
);

endmodule