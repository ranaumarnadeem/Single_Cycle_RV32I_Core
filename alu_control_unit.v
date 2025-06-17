module alu_control_unit (
    input  wire [1:0]  alu_op,       // Main control unit decides this
    input  wire [2:0]  funct3,       // From instruction
    input  wire [6:0]  funct7,       // From instruction
    output reg  [3:0]  alu_ctrl      // To ALU
);

    always @(*) begin
        case (alu_op)
            2'b00: alu_ctrl = 4'b0010; // For LW, SW, ADDI, etc
            2'b01: alu_ctrl = 4'b0110; // For branches: SUB to compare
            2'b10: begin // R-type or I-type logic/shift
                case ({funct7[5], funct3})
                    4'b0000: alu_ctrl = 4'b0010; // ADD or ADDI
                    4'b1000: alu_ctrl = 4'b0110; // SUB
                    4'b0111: alu_ctrl = 4'b0000; // AND / ANDI
                    4'b0110: alu_ctrl = 4'b0001; // OR / ORI
                    4'b0100: alu_ctrl = 4'b0011; // XOR / XORI
                    4'b0001: alu_ctrl = 4'b0100; // SLL / SLLI
                    4'b0101: alu_ctrl = 4'b0101; // SRL / SRLI
                    4'b1101: alu_ctrl = 4'b1101; // SRA / SRAI
                    4'b0010: alu_ctrl = 4'b0111; // SLT / SLTI
                    4'b0011: alu_ctrl = 4'b1000; // SLTU / SLTIU
                    default: alu_ctrl = 4'b0000; 
                endcase
end
            2'b11: alu_ctrl = 4'b1111;
                           default: alu_ctrl = 4'b0000;
        endcase
    end

endmodule
