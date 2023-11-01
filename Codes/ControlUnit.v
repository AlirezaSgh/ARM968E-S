module ControlUnit(
    input [3:0] OP_Code,
    input [1:0] Mode,
    input S_in, I_in,
    output reg [3:0] EXE_CMD,
    output reg WB_EN, MEM_R_EN, MEM_W_EN, B_out, S_out
);
    // Operations
    parameter [3:0] NOP = 4'd0, MOV = 4'd1, MVN = 4'd2, ADD = 4'd3, ADC = 4'd4, SUB = 4'd5, SBC = 4'd6,
                    AND = 4'd7, ORR = 4'd8, EOR = 4'd9, CMP = 4'd10, TST = 4'd11, LDR = 4'd12, STR = 4'd13, B = 4'd14;

    reg [3:0] operation;
    always@(Mode, OP_Code) begin
        case(Mode)
            2'b00: begin
                case(OP_Code)
                    4'b1101: operation = MOV;
                    4'b1111: operation = MVN;
                    4'b0100: operation = ADD;
                    4'b0101: operation = ADC;
                    4'b0010: operation = SUB;
                    4'b0110: operation = SBC;
                    4'b0000: operation = AND;
                    4'b1100: operation = ORR;
                    4'b0001: operation = EOR;
                    4'b1010: operation = CMP;
                    4'b1000: operation = TST;
                endcase
            end
            2'b01:begin
                case(OP_Code)
                    4'b0100: begin
                        if(S_in)
                            operation = LDR;
                        else
                            operation = STR;
                    end
                    default: operation = NOP;
                endcase
            end
            2'b10:begin
                if(I_in)
                    operation = B;
                else
                    operation = NOP;
            end
            default: operation = NOP;
        endcase
    end

    always @(operation) begin
        case(operation)
            NOP: begin
                EXE_CMD = 0110;
            end
            MOV: begin
                EXE_CMD = 0001;
            end
            MVN: begin
                EXE_CMD = 1001;
            end
            ADD: begin
                EXE_CMD = 0010;
            end
            ADC: begin
                EXE_CMD = 0011;
            end
            SUB: begin
                EXE_CMD = 0100;
            end
            SBC: begin
                EXE_CMD = 0101;
            end
            AND: begin
                EXE_CMD = 0110;
            end
            ORR: begin
                EXE_CMD = 0111;
            end
            EOR: begin
                EXE_CMD = 1000;
            end
            CMP: begin
                EXE_CMD = 0100;
            end
            TST: begin
                EXE_CMD = 0110;
            end
            LDR: begin
                EXE_CMD = 0010;
            end
            STR: begin
                EXE_CMD = 0010;
            end
            B: begin
                B_out = 1;
            end
        endcase
    end

endmodule