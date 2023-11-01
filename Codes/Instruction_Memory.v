module Instruction_Memory
        (pc_in, inst_out);
        input [31:0] pc_in;
        output [31:0] inst_out;

        reg [7:0] instructions[2047:0];

        initial begin
            $readmemb("inst.txt", instructions);
        end
    
        assign inst_out = { instructions[pc_in], instructions[pc_in + 1],
                            instructions[pc_in+2], instructions[pc_in+3]};

endmodule