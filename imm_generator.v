module imm_generator (
    input  wire [31:0] instr,
    output reg  [31:0] imm_out
);

    wire [6:0] opcode = instr[6:0];

    always @(*) begin
        case (opcode)
            7'b0010011, // I-type (addi, andi, ori, xori, slli, srli, srai, slti, sltiu)
            7'b0000011, // I-type (lw, lb, lh, lbu, lhu)
            7'b1100111: // I-type (jalr)
                imm_out = {{20{instr[31]}}, instr[31:20]}; // Sign-extend 12 bits

            7'b0100011: // S-type (sw, sb, sh)
                imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // Sign-extend 12 bits

            7'b1100011: // B-type (beq, bne, blt, bge, bltu, bgeu)
                imm_out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}; // Sign-extend 13 bits

            7'b0010111, // U-type (AUIPC)
            7'b0110111: // U-type (LUI)
                imm_out = {instr[31:12], 12'b0}; // Upper 20 bits, lower 12 are 0

            7'b1101111: // J-type (jal)
                imm_out = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0}; // Sign-extend 21 bits

            default:
                imm_out = 32'b0; // For undefined opcodes
        endcase
    end

endmodule
