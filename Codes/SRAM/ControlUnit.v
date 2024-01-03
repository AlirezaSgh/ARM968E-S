module ControlUnit (
    input [3:0] OP_Code,
    input [1:0] Mode,
    input S_in,
    I_in,
    output reg [3:0] EXE_CMD,
    output reg WB_EN,
    MEM_R_EN,
    MEM_W_EN,
    B_out,
    S_out
);
  // Operations
  parameter [3:0] NOP = 4'd0, MOV = 4'd1, MVN = 4'd2, ADD = 4'd3, ADC = 4'd4, SUB = 4'd5, SBC = 4'd6,
                    AND = 4'd7, ORR = 4'd8, EOR = 4'd9, CMP = 4'd10, TST = 4'd11, LDR = 4'd12, STR = 4'd13, B = 4'd14;

  reg [3:0] operation;
  always @(Mode, OP_Code, S_in, I_in) begin
    operation = NOP;
    S_out = 1'b0;
    case (Mode)
      2'b00: begin
        S_out = S_in;
        case (OP_Code)
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
          default: operation = NOP;
        endcase
      end
      2'b01: begin
        case (OP_Code)
          4'b0100: begin
            if (S_in) operation = LDR;
            else operation = STR;
          end
          default: operation = NOP;
        endcase
      end
      2'b10: begin
        if (I_in) operation = B;
        else operation = NOP;
      end
      default: operation = NOP;
    endcase
  end

  always @(operation, S_in) begin
    EXE_CMD = 4'd0;
    WB_EN = 1'b0;
    MEM_R_EN = 1'b0;
    MEM_W_EN = 1'b0;
    B_out = 1'b0;
    case (operation)
      NOP: begin
        EXE_CMD = 4'b0110;
      end
      MOV: begin
        EXE_CMD = 4'b0001;
        WB_EN   = 1'b1;

      end
      MVN: begin
        EXE_CMD = 4'b1001;
        WB_EN   = 1'b1;
      end
      ADD: begin
        EXE_CMD = 4'b0010;
        WB_EN   = 1'b1;
      end
      ADC: begin
        EXE_CMD = 4'b0011;
        WB_EN   = 1'b1;
      end
      SUB: begin
        EXE_CMD = 4'b0100;
        WB_EN   = 1'b1;
      end
      SBC: begin
        EXE_CMD = 4'b0101;
        WB_EN   = 1'b1;
      end
      AND: begin
        EXE_CMD = 4'b0110;
        WB_EN   = 1'b1;
      end
      ORR: begin
        EXE_CMD = 4'b0111;
        WB_EN   = 1'b1;
      end
      EOR: begin
        EXE_CMD = 4'b1000;
        WB_EN   = 1'b1;
      end
      CMP: begin
        EXE_CMD = 4'b0100;
      end
      TST: begin
        EXE_CMD = 4'b0110;
      end
      LDR: begin
        EXE_CMD = 4'b0010;
        MEM_R_EN = 1'b1;
        WB_EN = 1'b1;
      end
      STR: begin
        EXE_CMD  = 4'b0010;
        MEM_W_EN = 1'b1;
      end
      B: begin
        B_out = 1'b1;
      end
    endcase
  end

endmodule
