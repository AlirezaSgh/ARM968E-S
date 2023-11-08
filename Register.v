module register(clk, rst, en, in, out);
parameter width = 32;
input clk, rst, en;
input [width - 1:0] in;
output reg [width - 1:0] out;
initial begin
    out <= 0;
end
always @(posedge clk) begin
if(rst) out <= 0;
else if(en) out <= in;
end
endmodule
