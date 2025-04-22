module pc (
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] pc_next,
    output reg  [31:0] pc_current 
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_current <= 32'b0;  // Reset to 0
        else
            pc_current <= pc_next; // Update PC
    end

endmodule
