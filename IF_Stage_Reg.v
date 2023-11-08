module IF_Stage_Reg(
    input clk, rst, freeze, flush,
    input [31:0] PC_in, Instruction_in,
    output reg [31:0] PC, instructions
);
    wire en;
    assign en = ~freeze;

    always @(posedge clk) begin
        if(rst) begin
            PC <= 0;
            instructions <= 0;
        end
        else if (en) begin   
            PC <= PC_in;
            instructions <= Instruction_in;
        end     
    end


endmodule