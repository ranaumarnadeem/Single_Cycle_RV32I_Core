`timescale 1ns/1ps

module instruction_memory_tb;

    reg  [31:0] addr;
    wire [31:0] instruction;

    // Instantiate the instruction memory
    instruction_memory uut (
        .clk(1'b0),         // No clock used right now
        .addr(addr),
        .instruction(instruction)
    );

    initial begin
        // Simulation start
        $display("Starting Instruction Memory Testbench...");
        
        // Monitor outputs
        $monitor("Time=%0t | addr=0x%h | instruction=0x%h", $time, addr, instruction);

        // Apply different addresses
        addr = 32'h00000000; #10;
        addr = 32'h00000004; #10;
        addr = 32'h00000008; #10;
        addr = 32'h0000000C; #10;
        addr = 32'h00000010; #10;
        addr = 32'h00000014; #10;

        $display("Finished Instruction Memory Testbench.");
        
    end

endmodule
