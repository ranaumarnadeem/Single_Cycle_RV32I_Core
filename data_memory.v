module data_memory (
    input  wire        clk,
    input  wire        MemRead,
    input  wire        MemWrite,
    input  wire [31:0] addr,
    input  wire [31:0] write_data,
    output wire [31:0] read_data
);

    reg [31:0] memory [0:255]; // 1KB of memory

    
    assign read_data = (MemRead) ? memory[addr[9:2]] : 32'b0;

   
    always @(posedge clk) begin
        if (MemWrite)
            memory[addr[9:2]] <= write_data;
    end

endmodule
