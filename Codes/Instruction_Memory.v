module Instruction_Memory
        (pc_in, inst_out);
        input [31:0] pc_in;
        output [31:0] inst_out;

        reg [7:0] instructions[0:71];

        initial begin
            $readmemb("inst.txt", instructions);
            // instructions[0]=8'b11100011;
            // instructions[1]=8'b10100000;
            // instructions[2]=8'b00000000;
            // instructions[3]=8'b00010100;
            // instructions[4]=8'b11100011;
            // instructions[5]=8'b10100000;
            // instructions[6]=8'b00011010;
            // instructions[7]=8'b00000001;
            // instructions[8]=8'b11100011;
            // instructions[9]=8'b10100000;
            // instructions[10]=8'b00100001;
            // instructions[11]=8'b00000011;
            // instructions[12]=8'b11100000;
            // instructions[13]=8'b10010010;
            // instructions[14]=8'b00110000;
            // instructions[15]=8'b00000010;
            // instructions[16]=8'b11100000;
            // instructions[17]=8'b10100000;
            // instructions[18]=8'b01000000;
            // instructions[19]=8'b00000000;
            // instructions[20]=8'b11100000;
            // instructions[21]=8'b01000100;
            // instructions[22]=8'b01010001;
            // instructions[23]=8'b00000100;
            // instructions[24]=8'b11100000;
            // instructions[25]=8'b11000000;
            // instructions[26]=8'b01100000;
            // instructions[27]=8'b10100000;
            // instructions[28]=8'b11100001;
            // instructions[29]=8'b10000101;
            // instructions[30]=8'b01110001;
            // instructions[31] = 8'b01000010;
            // instructions[32] = 8'b11100000;
            // instructions[33] = 8'b00000111;
            // instructions[34] = 8'b10000000;
            // instructions[35] = 8'b00000011;
            // instructions[36] = 8'b11100001;
            // instructions[37] = 8'b11100000;
            // instructions[38] = 8'b10010000;
            // instructions[39] = 8'b00000110;
            // instructions[40]=8'b11100000;
            // instructions[41] = 8'b00100100;
            // instructions[42] = 8'b10100000;
            // instructions[43] = 8'b00000101;
            // instructions[44] = 8'b11100001;
            // instructions[45] = 8'b01011000;
            // instructions[46] = 8'b00000000;
            // instructions[47] = 8'b00000110;
            // instructions[48] = 8'b00010000;
            // instructions[49] = 8'b10000001;
            // instructions[50]=8'b00010000;
            // instructions[51] = 8'b00000001;
            // instructions[52] = 8'b11100001;
            // instructions[53] = 8'b00011001;
            // instructions[54] = 8'b00000000;
            // instructions[55] = 8'b00001000;
            // instructions[56] = 8'b00000000;
            // instructions[57] = 8'b10000010;
            // instructions[58] = 8'b00100000;
            // instructions[59] = 8'b00000010;
            // instructions[60]=8'b11100011;
            // instructions[61] = 8'b10100000;
            // instructions[62] = 8'b00001011;
            // instructions[63] = 8'b00000001;
            // instructions[64] = 8'b11100100;
            // instructions[65] = 8'b10000000;
            // instructions[66] = 8'b00010000;
            // instructions[67] = 8'b00000000;
            // instructions[68] = 8'b11100100;
            // instructions[69] = 8'b10010000;
            // instructions[70]=8'b10110000;
            // instructions[71]=8'b00000000;

        end
    
        assign inst_out = { instructions[pc_in], instructions[pc_in + 1],
                            instructions[pc_in+2], instructions[pc_in+3]};

endmodule