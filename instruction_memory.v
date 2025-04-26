module instruction_memory (
    input  wire        clk,           
    input  wire [31:0] addr,            // Address from PC
    output wire [31:0] instruction      // Instruction output
);

    reg [31:0] memory [0:255];          // 1KB = 256 words x 4 bytes

    
    initial begin
        $readmemh("program.txt", memory); 
    end

    // Word-aligned access (addr[1:0] ignored)
    assign instruction = memory[addr[9:2]];

endmodule
