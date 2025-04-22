module instruction_memory (
    input  wire [31:0] addr,         // Address from PC
    output wire [31:0] instruction   // Instruction output
);

    reg [31:0] memory [0:255];       // 256 instructions max

    initial begin
        $readmemh("program.txt", memory); // Load hex instructions
    end

    assign instruction = memory[addr[9:2]]; // Word-aligned access

endmodule
