module alu_control(
    input  wire [1:0]  alu_op,     // From control unit
    input  wire [2:0]  funct3,     // Bits [14:12] of instruction
    input  wire [6:0]  funct7,     // Bits [31:25]
    output reg  [3:0]  alu_ctrl    // To ALU
);

    always @(*) begin
        case (alu_op)
            2'b00: alu_ctrl = 4'b0010; // lw, sw, addi: just ADD
            2'b01: alu_ctrl = 4'b0110; // beq, bne: SUB to compare
            2'b10: begin // R-type and I-type ops
                case ({funct7[5], funct3})
                    4'b0000: alu_ctrl = 4'b0010; // ADD
                    4'b1000: alu_ctrl = 4'b0110; // SUB
                    4'b0111: alu_ctrl = 4'b0000; // AND
                    4'b0110: alu_ctrl = 4'b0001; // OR
                    4'b0100: alu_ctrl = 4'b0011; // XOR
                    4'b0001: alu_ctrl = 4'b0100; // SLL
                    4'b0101: alu_ctrl = 4'b0101; // SRL
                    4'b1101: alu_ctrl = 4'b1101; // SRA
                    4'b0010: alu_ctrl = 4'b0111; // SLT
                    4'b0011: alu_ctrl = 4'b1000; // SLTU
                    default: alu_ctrl = 4'b0000;
                endcase
            end
            default: alu_ctrl = 4'b0000;
        endcase
    end

endmodule
