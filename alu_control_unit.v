module alu_control_unit (
    input  wire [1:0]  alu_op,       // Main control unit decides this
    input  wire [2:0]  funct3,       // From instruction
    input  wire [6:0]  funct7,       // From instruction
    output reg  [3:0]  alu_ctrl      // To ALU
);

    always @(*) begin
        case (alu_op)
            2'b00: alu_ctrl = 4'b0010; // LW, SW, ADDI
            2'b01: alu_ctrl = 4'b0110; // Branch (SUB)
            2'b10: begin               // R-type and I-type
                case (funct3)
                    3'b000: alu_ctrl = (funct7[5] == 1'b1) ? 4'b0110 : 4'b0010; // SUB/ADD
                    3'b111: alu_ctrl = 4'b0000; // AND
                    3'b110: alu_ctrl = 4'b0001; // OR
                    3'b100: alu_ctrl = 4'b0011; // XOR
                    3'b001: alu_ctrl = 4'b0100; // SLL
                    3'b101: alu_ctrl = (funct7[5] == 1'b1) ? 4'b1101 : 4'b0101; // SRA/SRL
                    3'b010: alu_ctrl = 4'b0111; // SLT
                    3'b011: alu_ctrl = 4'b1000; // SLTU
                    default: alu_ctrl = 4'b0000;
                endcase
            end
            2'b11: alu_ctrl = 4'b1111; // LUI (b << 12)
            default: alu_ctrl = 4'b0000;
        endcase
    end

endmodule
