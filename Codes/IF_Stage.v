module IF_Stage(
	input clk, rst, freeze, Branch_Taken, 
	input [31:0] Branch_Address, 
	output [31:0] PC, Instruction
);
wire pc_en;
assign pc_en = ~freeze;
wire [31:0] mux_out, pc_out, adder_out, instruction_memory_out;
register pc(clk, rst, pc_en, mux_out, pc_out);
MUX mux(adder_out, Branch_Address, Branch_Taken, mux_out);
Adder adder(32'd4, pc_out, PC);
Instruction_Memory instuction_memory(pc_out, Instruction);
endmodule

