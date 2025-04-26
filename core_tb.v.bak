`timescale 1ns / 1ps

module core_tb;

    // === Inputs ===
    reg clk;
    reg reset;

    // === Outputs ===
    wire [31:0] pc_current;
    wire [31:0] instruction;

    // === Instantiate the Core Module ===
    core core_inst (
        .clk(clk),
        .reset(reset)
    );

    // === Clock Generation ===
    always begin
        #5 clk = ~clk;  // 10ns clock period (100MHz)
    end

    // === Reset Logic ===
    initial begin
        clk = 0;
        reset = 1;  // Start with reset high
        #10 reset = 0;  // Release reset after 10ns
    end

    // === Instruction Memory Initialization ===
    initial begin
        // Load a predefined set of RISC-V instructions from a hex file
        $readmemh("program.hex", core_inst.core_inst.instr_mem.memory);
    end

    // === Monitor Outputs ===
    initial begin
        $monitor("Time = %0t | PC = %h | Instruction = %h | Registers = %h", $time, pc_current, instruction, core_inst.core_reg.reg_file.regs);
    end

    // === Test Vector Initialization ===
    initial begin
        // Initialize test scenario
        // The following assumes `program.hex` is a file containing a sequence of RISC-V instructions
        // Some example instructions:
        // - `addi x1, x0, 5` - Set x1 to 5
        // - `addi x2, x0, 10` - Set x2 to 10
        // - `add x3, x1, x2` - Add x1 and x2, store in x3
        // - `sw x3, 0(x0)` - Store x3 at address 0 (for example, memory operation)
        
        // Wait for a few clock cycles for reset to be deasserted
        #20;

        // Check register x1, x2, and x3 values after execution
        // x1 should be 5, x2 should be 10, and x3 should be 15 (from `add x3, x1, x2`)
        if (core_inst.core_reg.reg_file.regs[1] !== 5) begin
            $display("ERROR: Register x1 is not 5, it is %d", core_inst.core_reg.reg_file.regs[1]);
        end

        if (core_inst.core_reg.reg_file.regs[2] !== 10) begin
            $display("ERROR: Register x2 is not 10, it is %d", core_inst.core_reg.reg_file.regs[2]);
        end

        if (core_inst.core_reg.reg_file.regs[3] !== 15) begin
            $display("ERROR: Register x3 is not 15, it is %d", core_inst.core_reg.reg_file.regs[3]);
        end

        // Check if data memory is correct (for example, check if value at address 0 is 15)
        if (core_inst.core_mem.data_mem.memory[0] !== 15) begin
            $display("ERROR: Memory at address 0 is not 15, it is %d", core_inst.core_mem.data_mem.memory[0]);
        end

        // End the simulation after a few cycles
        #1000;  // Run simulation for 1000ns (100 clock cycles)
        $finish;
    end

endmodule
