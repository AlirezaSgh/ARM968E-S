module Val2Generator(input I, bypass_rm, input[31:0] Val_Rm, input[11:0] Shift_operand, output reg[31:0] out);
    parameter[1:0] LSL = 2'b00, LSR = 2'b01, ASR = 2'b10, ROR = 2'b11;
    wire[4:0] shift_imm;
    wire[1:0] shift;
    wire[3:0] rotate_imm;
    wire [7:0] immed_8;
    reg [31:0] shift_buffer;
    assign immed_8 = Shift_operand[7:0];
    assign rotate_imm = Shift_operand[11:8];
    assign shift_imm = Shift_operand[11:7]; 
    assign shift = Shift_operand[6:5];
    always@(bypass_rm ,I, shift, Val_Rm) begin
        shift_buffer = 0;
        case(bypass_rm)//check later
            1'b0: case (I)
                    1'b0: begin 
                        case (shift)
                            LSL:    out = Val_Rm << shift_imm;
                            LSR:    out = Val_Rm >> shift_imm;
                            ASR:    out = Val_Rm >>> shift_imm;
                            ROR:    out = Val_Rm << shift_imm | Val_Rm >> 5 - shift_imm; //check later
                        endcase
                    end
                    1'b1: begin
                        shift_buffer = {24'd0,immed_8};
                        out = shift_buffer >> (shift_imm << 1) | shift_buffer << (32 - (shift_imm << 1));
                    end
                default: out = 32'b0;
            endcase
            1'b1:   out = {20'b0, Shift_operand};
        endcase
    end
endmodule

module V2G_tb();
    reg I, bypass_rm;
    reg[31:0] Val_Rm;
    reg[11:0] Shift_operand;
    wire [31:0] out;
    Val2Generator ut(I, bypass_rm, Val_Rm, Shift_operand, out);
    initial begin
        repeat(30) begin
            {I,bypass_rm,Val_Rm,Shift_operand} = $random;
            #10;
        end
        I = 1;
        bypass_rm = 0;
        {Val_Rm,Shift_operand} = $random;
        #20
        $stop;
    end
endmodule