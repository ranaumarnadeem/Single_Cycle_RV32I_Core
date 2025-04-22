module register_file (
    input  wire        clk,
    input  wire        reset,
    input  wire [4:0]  rs1,        // Source register 1
    input  wire [4:0]  rs2,        // Source register 2
    input  wire [4:0]  rd,         // Destination register
    input  wire [31:0] write_data, // Data to write
    input  wire        reg_write,  // Write enable
    output wire [31:0] read_data1, // Data from rs1
    output wire [31:0] read_data2  // Data from rs2
);

    reg [31:0] regs[31:0];         // 32 registers

    // Read
    assign read_data1 = (rs1 != 0) ? regs[rs1] : 32'b0;
    assign read_data2 = (rs2 != 0) ? regs[rs2] : 32'b0;

    // Write on positive edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            integer i;
            for (i = 0; i < 32; i = i + 1)
                regs[i] <= 32'b0;
        end else if (reg_write && (rd != 0)) begin
            regs[rd] <= write_data; // x0 is hardwired to 0
        end
    end

endmodule
