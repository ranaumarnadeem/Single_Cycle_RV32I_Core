module core_tb;

    reg clk;
    reg reset;

    wire [31:0] pc_current;
    wire [31:0] instruction;
    wire [31:0] result;

    core uut (
        .clk(clk),
        .reset(reset),
        .pc_current(pc_current),
        .instruction(instruction),
        .result(result)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;
    end

    initial begin
        $readmemh("program.txt", uut.instr_mem_inst.memory);
    end

    initial begin
        $monitor("Time: %0t | PC: %h | Inst: %h | Result (x4): %h", $time, pc_current, instruction, result);
        #200;
        $finish;
    end

endmodule
