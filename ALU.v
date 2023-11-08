module ALU(input signed [31:0] in1, in2, input [3:0] EXE_CMD, input C, output[3:0] Status_bit, output reg signed[31:0] result);
    parameter [3:0] MOV = 4'b001, MVN = 4'b1001, ADD_LDR_STR = 4'b0010, ADC = 4'b0011, SUB_CMP = 4'b0100, SBC = 4'b0101,
                    AND_TST = 4'b0110, ORR = 4'b0111, EOR = 4'b1000, TST = 4'b0110;
    //n neg out
    //v overflow
    //C carry out
    //Z zero
    reg N, Z, Co, V;
    assign Status_bit = {N, Z, Co, V};
    always @(in1, in2, C, EXE_CMD) begin
        N = 1'b0;
        Z = 1'b0;
        Co = 1'b0;
        V = 1'b0;
        case (EXE_CMD)
            MOV:    result = in2;
            MVN:    result = ~in2;
            ADD_LDR_STR:    begin
                {Co,result} = in1 + in2;
                if(in1 > 0 & in2 > 0 & result < 0)
                    V = 1'b1;
                else if(in1 < 0 & in2 < 0 & result > 0)
                    V = 1'b1;
                else if(in1 > 0 & in2 < 0 & result > in1)
                    V = 1'b1;
                else if(in1 < 0 & in2 > 0 & result < in1)
                    V = 1'b1;
            end
            ADC:    begin
                {Co,result} = in1 + in2 + C;
                if(in1 > 0 & in2 > 0 & result < 0)
                    V = 1'b1;
                else if(in1 < 0 & in2 < 0 & result > 0)
                    V = 1'b1;
                else if(in1 > 0 & in2 < 0 & result > in1)
                    V = 1'b1;
                else if(in1 < 0 & in2 > 0 & result < in1)
                    V = 1'b1;
            end
            SUB_CMP:    begin
                result = in1 - in2;
                if(in1 > 0 & in2 < 0 & result < 0)
                    V = 1'b1;
                else if(in1 < 0 & in2 > 0 & result > 0)
                    V = 1'b1;
                else if(in1 > 0 & in2 > 0 & result > in1)
                    V = 1'b1;
                else if (in1 < 0 & in2 < 0 & result < in1)
                    V = 1'b1;
            end
            SBC:    begin
                result = in1 - in2 - (~C);
                if(in1 > 0 & in2 < 0 & result < 0)
                    V = 1'b1;
                else if(in1 < 0 & in2 > 0 & result > 0)
                    V = 1'b1;
                else if(in1 > 0 & in2 > 0 & result > in1)
                    V = 1'b1;
                else if (in1 < 0 & in2 < 0 & result < in1)
                    V = 1'b1;
            end
            AND_TST:    result = in1 & in2;
            ORR:    result = in1 | in2;
            EOR:    result = in1 ^ in2;
            default: result = 32'b0;
        endcase

        if(result == 0)
            Z = 1'b1;

        if(result < 0)
            N = 1'b1;
    end
endmodule

module ALU_tb();
    reg[31:0] in1, in2;
    reg[3:0] EXE_CMD;
    reg C;
    wire[3:0] Status_bit;
    wire[31:0] result;
    ALU ut(in1, in2, EXE_CMD, C, Status_bit,result);
    initial begin
        repeat(10) begin
            {in1, in2, EXE_CMD, C} = $random;
            #10;
        end
        in1 = 32'b01111111111111111111111111111111;
        in2 = 32'b00011010101010101110101010101011;
        EXE_CMD = 4'b0010;
        #20 $stop;
    end
endmodule
