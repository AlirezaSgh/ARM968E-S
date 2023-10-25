module IF_Stage_TB;
reg clk = 0, rst = 1, freeze = 0, Branch_Taken = 0;
reg [31:0] Branch_Address = 0;
wire [31:0] PC, Instruction;
IF_Stage ut(
	clk, rst, freeze, Branch_Taken, 
	Branch_Address, 
	PC, Instruction
);

initial begin
    repeat(1000000) #10 clk = ~clk;
end

initial begin 
    #25 rst = 0; freeze = 1;
end

endmodule