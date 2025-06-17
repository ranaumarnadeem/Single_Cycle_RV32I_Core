module alu (
    input  wire [31:0] a,           // First operand
    input  wire [31:0] b,           // Second operand
    input  wire [3:0]  alu_ctrl,    
    output reg  [31:0] result,      
    output wire        zero          
);

    
    assign zero = (result == 0);

    always @(*) begin
        case (alu_ctrl)
            4'b0000: result = a & b;                           // AND, ANDI
            4'b0001: result = a | b;                           // OR, ORI
            4'b0010: result = a + b;                           // ADD, ADDI, AUIPC, JALR, LW, SW
            4'b0110: result = a - b;                           // SUB, BEQ, BNE, BLT, BGE
            4'b0011: result = a ^ b;                           // XOR, XORI
            4'b0100: result = a << b[4:0];                     // SLL, SLLI
            4'b0101: result = a >> b[4:0];                     // SRL, SRLI
            4'b1101: result = $signed(a) >>> b[4:0];           // SRA, SRAI (arithmetic)
            4'b0111: result = ($signed(a) < $signed(b)) ? 32'b1 : 32'b0; // SLT, SLTI (signed)
            4'b1000: result = (a < b) ? 32'b1 : 32'b0;         // SLTU, SLTIU (unsigned)
            4'b1111: result = b << 12;
            default: result = 32'b0;                           
        endcase
    end

endmodule
