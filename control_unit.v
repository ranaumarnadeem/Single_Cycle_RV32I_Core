module control_unit (
    input  wire [6:0] opcode,         // Instruction[6:0]
    output reg        RegWrite,
    output reg        ALUSrc,
    output reg        MemRead,
    output reg        MemWrite,
    output reg        MemToReg,
    output reg        Branch,
    output reg [1:0]  ALUOp
);

    always @(*) begin
        // Default values
        RegWrite  = 0;
        ALUSrc    = 0;
        MemRead   = 0;
        MemWrite  = 0;
        MemToReg  = 0;
        Branch    = 0;
        ALUOp     = 2'b00;

        case (opcode)
            7'b0110011: begin // R-type
                RegWrite  = 1;
                ALUSrc    = 0;
                ALUOp     = 2'b10;
            end

            7'b0010011: begin // I-type 
                RegWrite  = 1;
                ALUSrc    = 1;
                ALUOp     = 2'b10;
            end

            7'b0000011: begin // lw
                RegWrite  = 1;
                ALUSrc    = 1;
                MemRead   = 1;
                MemToReg  = 1;
                ALUOp     = 2'b00;
            end

            7'b0100011: begin // sw
                RegWrite  = 0;
                ALUSrc    = 1;
                MemWrite  = 1;
                ALUOp     = 2'b00;
            end

            7'b1100011: begin // beq, bne
                RegWrite  = 0;
                ALUSrc    = 0;
                Branch    = 1;
                ALUOp     = 2'b01;
            end

            7'b0110111: begin // LUI
                RegWrite  = 1;
                ALUSrc    = 1;
                ALUOp     = 2'b10; // Treat similar to I-type
            end

            7'b0010111: begin // AUIPC
                RegWrite  = 1;
                ALUSrc    = 1;
                ALUOp     = 2'b10;
            end

            default: begin
                
            end
        endcase
    end

endmodule
