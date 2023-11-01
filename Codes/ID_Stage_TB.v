module if_id_tb(); 
wire WB_EN, MEM_R_EN, MEM_W_EN, B, S, imm, Two_src; 
reg writeBackEN = 0, hazard = 0; 
 
reg rst = 1, CLOCK_50 = 0; 
wire [31:0] PC_in, Inst_in, Inst, Val_Rn, Val_Rm; 
reg [31:0] Result_WB = 0; 
reg [3:0] SR = 0,Des_wb = 0; 
wire [3:0] EXE_CMD, Dest, src1, src2; 
wire [23:0] Signed_imm_24; 
wire [11:0] Shift_operand; 
IF_Stage fetch(CLOCK_50, rst, 1'b0, 1'b0, 32'b0, PC_in, Inst_in); 
IF_Stage_Reg if_reg(CLOCK_50, rst, 1'b0, 1'b0, PC_in, Inst_in, PC, Inst); 
ID_Stage decode(CLOCK_50, rst, Inst, Result_WB, writeBackEN, Des_wb, hazard,  
  SR, WB_EN, MEM_R_EN, MEM_W_EN, B, S, EXE_CMD, Val_Rn,  
  Val_Rm, imm, Shift_operand, Signed_imm_24, Dest, src1, src2, Two_src); 
 
always #1 CLOCK_50 = ~CLOCK_50; 
initial begin 
    #20 rst = 0; 
end 
endmodule