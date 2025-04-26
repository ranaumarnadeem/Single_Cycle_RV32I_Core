module data_memory (
    input  wire        clk,
    input  wire        MemRead,
    input  wire        MemWrite,
    input  wire [31:0] addr,
    input  wire [31:0] write_data,
    input  wire [2:0]  funct3,        // To decide byte/half/word operation
    output reg  [31:0] read_data
);

    reg [7:0] memory [0:1023]; // 1KB memory (byte addressable)

    wire [9:0] byte_addr = addr[9:0]; // 10-bit for 1KB addressing

    always @(*) begin
        if (MemRead) begin
            case (funct3)
                3'b000: begin // LB
                    read_data = {{24{memory[byte_addr][7]}}, memory[byte_addr]};
                end
                3'b001: begin // LH
                    read_data = {{16{memory[byte_addr+1][7]}}, memory[byte_addr+1], memory[byte_addr]};
                end
                3'b010: begin // LW
                    read_data = {memory[byte_addr+3], memory[byte_addr+2], memory[byte_addr+1], memory[byte_addr]};
                end
                3'b100: begin // LBU
                    read_data = {24'b0, memory[byte_addr]};
                end
                3'b101: begin // LHU
                    read_data = {16'b0, memory[byte_addr+1], memory[byte_addr]};
                end
                default: read_data = 32'b0;
            endcase
        end else begin
            read_data = 32'b0;
        end
    end

    always @(posedge clk) begin
        if (MemWrite) begin
            case (funct3)
                3'b000: begin // SB
                    memory[byte_addr] <= write_data[7:0];
                end
                3'b001: begin // SH
                    memory[byte_addr]     <= write_data[7:0];
                    memory[byte_addr + 1] <= write_data[15:8];
                end
                3'b010: begin // SW
                    memory[byte_addr]     <= write_data[7:0];
                    memory[byte_addr + 1] <= write_data[15:8];
                    memory[byte_addr + 2] <= write_data[23:16];
                    memory[byte_addr + 3] <= write_data[31:24];
                end
            endcase
        end
    end

endmodule
