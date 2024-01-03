module Hazard_Detection_Unit (
    input [3:0] src1,
    src2,
    Exe_Dest,
    input Exe_WB_EN,
    processor_mode,
    input [3:0] Mem_Dest,
    input Mem_WB_EN,
    output reg Hazard_Detected
);
  always @(src1, src2, Exe_WB_EN, Mem_Dest, Mem_WB_EN, Exe_Dest, processor_mode) begin
    Hazard_Detected = 1'b0;
    if (~processor_mode) begin
      if ((Exe_WB_EN & (src1 == Exe_Dest))|
          (Mem_WB_EN & (src1 == Mem_Dest))|
          (Exe_WB_EN & (src2 == Exe_Dest))|
          (Mem_WB_EN & (src2 == Mem_Dest)))
        Hazard_Detected = 1'b1;
    end
  end
endmodule
