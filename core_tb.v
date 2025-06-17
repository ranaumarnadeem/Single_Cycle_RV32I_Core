`timescale 1ns / 1ps

module core_tb;

    reg clk;
    reg reset;

    wire [31:0] pc_current;
    wire [31:0] instruction;


core uut (
    .clk(clk),
    .reset(reset),
    .pc_current(pc_current),
    .instruction(instruction)
);


    always #5 clk = ~clk; // 10ns clock

    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;
    end

    initial begin
        $readmemh("program.txt", uut.instr_mem_inst.memory);
    end


endmodule
