module Instruction_Memory
        (pc_in, inst_out);
        input [31:0] pc_in;
        output [31:0] inst_out;

        reg [7:0] instructions[2047:0];

        initial begin
            $readmemb("inst.txt", instructions);
        end
    
        assign inst_out = { instructions[inst_out], instructions[inst_out + 1],
                            instructions[inst_out+2], instructions[inst_out+3]};

endmodule