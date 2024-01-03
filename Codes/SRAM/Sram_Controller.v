module Sram_Controller (
    input clk,
    rst,
    wr_en,
    rd_en,
    input [31:0] address,
    writeData,
    output [31:0] readData,
    output ready,
    inout [15:0] SRAM_DQ,
    output reg [17:0] SRAM_ADDR,
    output SRAM_UB_N,
    SRAM_LB_N,
    output reg SRAM_WE_N,
    output SRAM_CE_N,
    SRAM_OE_N
);
  assign SRAM_OE_N = 1'b0;
  assign SRAM_UB_N = 1'b0;
  assign SRAM_LB_N = 1'b0;
  assign SRAM_CE_N = 1'b0;
  parameter [3:0] idle = 0, writeState0 = 1, writeState1 = 2, readState0 = 3, readState1 = 4, readState2 = 5, readState3 = 6, readState4 = 7;
  reg [3:0] ns, ps;
  reg [15:0] readLSB, readMSB;
  reg [31:0] res;

  always @* begin
    ns = idle;
    case (ps)
      idle: begin
        if (~wr_en & ~rd_en) ns = idle;
        else if (wr_en) ns = writeState0;
        else ns = readState0;
      end
      writeState0: ns = writeState1;
      writeState1: ns = idle;
      readState0: ns = readState1;
      readState1: ns = readState2;
      readState2: ns = readState3;
      readState3: ns = readState4;
      readState4: ns = idle;
      default: ns = idle;
    endcase
  end

  always @(ps, address, SRAM_DQ) begin
    SRAM_ADDR = 18'b0;
    SRAM_WE_N = 1'b1;
    if (rst) begin
      // readLSB <= 16'b0;
      // readMSB <= 16'b0;
      // res <= 32'b0;
    end
    case (ps)
      writeState0: begin
        SRAM_ADDR = {address[18:2], 1'b0};
        SRAM_WE_N = 1'b0;
      end
      writeState1: begin
        SRAM_ADDR = {address[18:2], 1'b1};
        SRAM_WE_N = 1'b0;
      end
      readState0: begin
        SRAM_ADDR = {address[18:2], 1'b0};
      end
      readState1: begin
        SRAM_ADDR = {address[18:2], 1'b0};
        readLSB   = SRAM_DQ;
      end
      readState2: begin
        SRAM_ADDR = {address[18:2], 1'b1};
      end
      readState3: begin
        SRAM_ADDR = {address[18:2], 1'b1};
        readMSB = SRAM_DQ;
        res = {readMSB, readLSB};
      end
      readState4: begin
      end
      default: begin
      end
    endcase
  end

  always @(posedge clk, posedge rst) begin
    if (rst) ps <= idle;
    else ps <= ns;
  end

  // always @(ps) begin
  //   ready = 1'b0;
  //   if (ps == idle || ps == readState) ready = 1'b1;
  // end

  assign ready = (ns == idle) ? 1'b1 : 1'b0;
  assign readData = res;
  assign SRAM_DQ = (ps == writeState0) ? writeData[15:0]:(ps == writeState1) ? writeData[31:16]:16'bZ;
endmodule

