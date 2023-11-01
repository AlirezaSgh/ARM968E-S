module EXE_Stage_Reg(
	input clk, rst, WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN, 
	input [31:0] ALU_result_inp, ST_val_in,
	input [3:0] Dest_in,
	output reg WB_EN, MEM_R_EN, MEM_W_EN, 
	output reg [31:0] ALU_result, ST_val,
	output reg [3:0] Dest
);

endmodule