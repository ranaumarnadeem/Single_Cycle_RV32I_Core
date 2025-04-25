`timescale 1ns / 1ps

module alu_control_tb;

    // Inputs
    reg  [1:0]  alu_op;
    reg  [2:0]  funct3;
    reg  [6:0]  funct7;

    // Output
    wire [3:0] alu_ctrl;

    // Instantiate the Unit Under Test (UUT)
    alu_control_unit uut (
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7(funct7),
        .alu_ctrl(alu_ctrl)
    );

    initial begin
        $display("Starting ALU Control Unit Testbench...\n");

        // ADD
        alu_op = 2'b10; funct3 = 3'b000; funct7 = 7'b0000000;
        #5 $display("ADD  => alu_ctrl = %b", alu_ctrl);

        // SUB
        alu_op = 2'b10; funct3 = 3'b000; funct7 = 7'b0100000;
        #5 $display("SUB  => alu_ctrl = %b", alu_ctrl);

        // AND
        alu_op = 2'b10; funct3 = 3'b111; funct7 = 7'b0000000;
        #5 $display("AND  => alu_ctrl = %b", alu_ctrl);

        // OR
        alu_op = 2'b10; funct3 = 3'b110; funct7 = 7'b0000000;
        #5 $display("OR   => alu_ctrl = %b", alu_ctrl);

        // XOR
        alu_op = 2'b10; funct3 = 3'b100; funct7 = 7'b0000000;
        #5 $display("XOR  => alu_ctrl = %b", alu_ctrl);

        // SLL
        alu_op = 2'b10; funct3 = 3'b001; funct7 = 7'b0000000;
        #5 $display("SLL  => alu_ctrl = %b", alu_ctrl);

        // SRL
        alu_op = 2'b10; funct3 = 3'b101; funct7 = 7'b0000000;
        #5 $display("SRL  => alu_ctrl = %b", alu_ctrl);

        // SRA
        alu_op = 2'b10; funct3 = 3'b101; funct7 = 7'b0100000;
        #5 $display("SRA  => alu_ctrl = %b", alu_ctrl);

        // SLT
        alu_op = 2'b10; funct3 = 3'b010; funct7 = 7'b0000000;
        #5 $display("SLT  => alu_ctrl = %b", alu_ctrl);

        // SLTU
        alu_op = 2'b10; funct3 = 3'b011; funct7 = 7'b0000000;
        #5 $display("SLTU => alu_ctrl = %b", alu_ctrl);

        // ADDI, LW, SW, AUIPC etc.
        alu_op = 2'b00;
        #5 $display("ADDI/LW/SW => alu_ctrl = %b", alu_ctrl);

        // Branch (BEQ, BNE, etc.)
        alu_op = 2'b01;
        #5 $display("BEQ/BNE/etc => alu_ctrl = %b", alu_ctrl);

        $display("\nTestbench finished.");
        $stop;
    end

endmodule
