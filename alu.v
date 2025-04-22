module alu (
    input  wire [31:0] a,           // First operand
    input  wire [31:0] b,           // Second operand
    input  wire [3:0]  alu_ctrl,    // ALU operation control
    output reg  [31:0] result,      // ALU result
    output wire        zero         // Zero flag 
);

    // Zero flag
    assign zero = (result == 0);

    
    always @(*) begin
        case (alu_ctrl)
            4'b0000: result = a & b;                       // AND
            4'b0001: result = a | b;                       // OR
            4'b0010: result = a + b;                       // ADD
            4'b0110: result = a - b;                       // SUB
            4'b0011: result = a ^ b;                       // XOR
            4'b0100: result = a << b[4:0];                 // SLL (shift left logical)
            4'b0101: result = a >> b[4:0];                 // SRL (shift right logical)
            4'b1101: result = $signed(a) >>> b[4:0];       // SRA (shift right arithmetic)
            4'b0111: result = ($signed(a) < $signed(b)) ? 32'b1 : 32'b0; // SLT (signed)
            4'b1000: result = (a < b) ? 32'b1 : 32'b0;      // SLTU
            default: result = 32'b0;
        endcase
    end

endmodule
