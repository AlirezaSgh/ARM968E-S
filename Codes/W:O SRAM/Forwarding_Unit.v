module Forwarding_Unit (
    input [3:0] WB_dest,
    Mem_Dest,
    src1,
    src2,
    input WB_en,
    Mem_WB_en,
    processor_mode,
    output reg [1:0] sel_src1,
    sel_src2
);
  always @(*) begin
    sel_src1 = 2'd0;
    sel_src2 = 2'd0;
    if (processor_mode) begin
      if (Mem_WB_en) begin
        if (src1 == Mem_Dest) sel_src1 = 2'd1;
        if (src2 == Mem_Dest) sel_src2 = 2'd1;
      end

      if (WB_en) begin
        if (src1 == WB_dest) sel_src1 = 2'd2;
        if (src2 == WB_dest) sel_src2 = 2'd2;
      end
    end
  end
endmodule
