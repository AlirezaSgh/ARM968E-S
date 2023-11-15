module counter_1bit(input clk, rst, en, clk_en, output reg co);
    reg count;
    always @(posedge clk) begin
        if(rst)
            count <= 1'b0;
        else if(en & clk_en)
            {co, count} <= count + 1'b1;
    end
endmodule

module counter_2bit(input clk, rst, en, clk_en, output reg co);
    reg[1:0] count;
    always @(posedge clk) begin
        if(rst)
            count <= 2'b0;
        else if(en & clk_en)
            {co, count} <= count + 2'b1;
    end
endmodule

module shreg_2bit(input clk, rst, en, clk_en, in, output reg[1:0] out);
    always @(posedge clk) begin
        if(rst)
            out <= 2'd0;
        else if(en & clk_en) begin
            out[1] <= out[0];
            out[0] <= in;
        end
    end
endmodule
 
module shreg_4bit(input clk, rst, en, clk_en, in, output reg[3:0] out);
    always @(posedge clk) begin
        if(rst)
            out <= 4'd0;
        else if(en & clk_en) begin
            out[3] <= out[2];
            out[2] <= out[1];
            out[1] <= out[0];
            out[0] <= in;
        end
    end
endmodule

module shreg_tb();
    reg clk = 0, rst = 1, en = 1, clk_en = 1, in;
    wire[3:0] out;
    shreg_4bit ut(clk, rst, en, clk_en, in, out);
    always #1 clk = ~clk;
    initial begin
        #2 rst = 0;
        in = 1;
        repeat(5)#2 in = $random;
        $stop;
    end
endmodule