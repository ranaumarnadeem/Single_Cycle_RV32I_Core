module control_unit (
    input  wire [6:0] opcode,        
    output reg        RegWrite,
    output reg        ALUSrc,
    output reg        MemRead,
    output reg        MemWrite,
    output reg        MemToReg,
    output reg        Branch,
    output reg [1:0]  ALUOp,
    output reg        Jump         
);

    always @(*) begin
       
        RegWrite  = 0;
        ALUSrc    = 0;
        MemRead   = 0;
        MemWrite  = 0;
        MemToReg  = 0;
        Branch    = 0;
        ALUOp     = 2'b00;
        Jump      = 0;

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

            7'b0000011: begin // Load 
                RegWrite  = 1;
                ALUSrc    = 1;
                MemRead   = 1;
                MemToReg  = 1;
                ALUOp     = 2'b00;
            end

            7'b0100011: begin // Store 
                RegWrite  = 0;
                ALUSrc    = 1;
                MemWrite  = 1;
                ALUOp     = 2'b00;
            end

            7'b1100011: begin // Branch 
                RegWrite  = 0;
                ALUSrc    = 0;
                Branch    = 1;
                ALUOp     = 2'b01;
            end

            7'b1101111: begin // JAL 
                RegWrite  = 1;
                ALUSrc    = 0;  // PC-relative
                Jump      = 1;
                ALUOp     = 2'b00;
            end

            7'b1100111: begin // JALR 
                RegWrite  = 1;
                ALUSrc    = 1;  // rs1 + imm
                Jump      = 1;
                ALUOp     = 2'b00;
            end

            7'b0110111: begin // LUI 
                RegWrite  = 1;
                ALUSrc    = 1;
                ALUOp     = 2'b11; 
            end

            7'b0010111: begin
                RegWrite  = 1;
                ALUSrc    = 1;
                ALUOp     = 2'b11; 
            end

            default: begin
                
            end
        endcase
    end

endmodule
