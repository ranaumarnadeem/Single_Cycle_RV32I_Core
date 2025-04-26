`timescale 1ns/1ps

module tb_imm_generator;

    reg  [31:0] instr;
    wire [31:0] imm_out;

    \
    imm_generator uut (
        .instr(instr),
        .imm_out(imm_out)
    );

    initial begin
        $display("Starting imm_generator testbench...");

        //-------------------------------------------------------------------------
        // I-Type Immediate Test (e.g., ADDI / LW / JALR)
        // imm[11:0] = instr[31:20], sign-extended
        // Positive immediate = 12'h0A5  (binary 0000_1010_0101)
        instr = {12'h0A5, 13'b0, 7'b0010011};  // opcode 0010011 for I-type
        #10; 
        $display("I-type (ADDI) positive: instr = %h, imm_out = %h", instr, imm_out);

        // Negative immediate = 12'hF22 (binary 1111_0010_0010)
        instr = {12'hF22, 13'b0, 7'b0010011}; 
        #10; 
        $display("I-type (ADDI) negative: instr = %h, imm_out = %h", instr, imm_out);
        

        //-------------------------------------------------------------------------
        // S-Type Immediate Test (e.g., SW, SB, SH)

        instr = {7'h09, 13'b0, 5'h03, 7'b0100011};  // opcode 0100011 for S-type
        #10;
        $display("S-type (SW): instr = %h, imm_out = %h", instr, imm_out);
        

        //-------------------------------------------------------------------------
        // B-Type Immediate Test (e.g., BEQ, BNE, etc.)

        instr = {1'b0,         // instr[31]
                 6'b000000,    // instr[30:25]
                 13'b0,        // filler (bits [24:12] not used in immediate generation)
                 4'b0011,      // instr[11:8]
                 1'b1,         // instr[7]
                 7'b1100011};  // opcode for B-type
        #10;
        $display("B-type (Branch): instr = %h, imm_out = %h", instr, imm_out);
        

        //-------------------------------------------------------------------------
        // U-Type Immediate Test for LUI

        instr = {20'hABCDE, 12'b0, 7'b0110111};  
        #10;
        $display("U-type (LUI): instr = %h, imm_out = %h", instr, imm_out);

        //-------------------------------------------------------------------------
        // U-Type Immediate Test for AUIPC

        #10;
        $display("U-type (AUIPC): instr = %h, imm_out = %h", instr, imm_out);

        //-------------------------------------------------------------------------
        // J-Type Immediate Test (JAL)
    
        instr = {1'b0,      // instr[31]
                 10'h2AA,   // instr[30:21]
                 1'b1,      // instr[20]
                 8'h55,     // instr[19:12]
                 7'b1101111 // opcode for J-type
                };
        #10;
        $display("J-type (JAL): instr = %h, imm_out = %h", instr, imm_out);

        $finish;
    end

endmodule
