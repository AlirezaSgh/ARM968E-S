module Condition_Check (
    input [3:0] cond,
    OPCode,
    output reg flag
);
  //cond = NZCV
  wire N, Z, C, V;
  assign N = OPCode[3];
  assign Z = OPCode[2];
  assign C = OPCode[1];
  assign V = OPCode[0];
  parameter [3:0] EQ = 4'd0, NE = 4'd1, CS_HS = 4'd2, CC_LO = 4'd3, MI = 4'd4, 
                PL = 4'd5, VS = 4'd6, VC = 4'd7, HI = 4'd8, LS = 4'd9, 
                GE = 4'd10, LT = 4'd11, GT = 4'd12, LE = 4'd13, AL = 4'd14;
  always @(cond, OPCode, N, Z, C, V) begin
    flag = 1;
    case (cond)
      EQ: flag = Z;
      NE: flag = ~Z;
      CS_HS: flag = C;
      CC_LO: flag = ~C;
      MI: flag = N;
      PL: flag = ~N;
      VS: flag = V;
      VC: flag = ~V;
      HI: flag = C & (~Z);
      LS: flag = (~C) & Z;
      GE: flag = N == V;
      LT: flag = N != V;
      GT: flag = (~Z) & (N == V);
      LE: flag = Z | (N != V);
      AL: flag = 1;
      default: flag = 1;
    endcase
  end
endmodule
