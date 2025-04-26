`timescale 1ns / 1ps

module control_unit_tb;

 
    reg [6:0] opcode;

   
    wire RegWrite, ALUSrc, MemRead, MemWrite, MemToReg, Branch, Jump;
    wire [1:0] ALUOp;

  
    control_unit uut (
        .opcode(opcode),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg),
        .Branch(Branch),
        .ALUOp(ALUOp),
        .Jump(Jump)
    );

 
    task print_control_signals;
        begin
            $display("Opcode = %b | RegWrite = %b | ALUSrc = %b | MemRead = %b | MemWrite = %b | MemToReg = %b | Branch = %b | Jump = %b | ALUOp = %b", 
                      opcode, RegWrite, ALUSrc, MemRead, MemWrite, MemToReg, Branch, Jump, ALUOp);
        end
    endtask

    initial begin
        $display("=== Control Unit Test ===");

        // R-type
        opcode = 7'b0110011; #10; print_control_signals();

        // I-type (ADDI, ANDI, etc.)
        opcode = 7'b0010011; #10; print_control_signals();

        // Load (LW)
        opcode = 7'b0000011; #10; print_control_signals();

        // Store (SW)
        opcode = 7'b0100011; #10; print_control_signals();

        // Branch (BEQ, BNE)
        opcode = 7'b1100011; #10; print_control_signals();

        // JAL
        opcode = 7'b1101111; #10; print_control_signals();

        // JALR
        opcode = 7'b1100111; #10; print_control_signals();

        // LUI
        opcode = 7'b0110111; #10; print_control_signals();

        // AUIPC
        opcode = 7'b0010111; #10; print_control_signals();

        // Unknown opcode
        opcode = 7'b1111111; #10; print_control_signals();

        $finish;
    end

endmodule
