module data_memory_tb();

    reg         clk;
    reg         MemRead;
    reg         MemWrite;
    reg  [31:0] addr;
    reg  [31:0] write_data;
    reg  [2:0]  funct3;
    wire [31:0] read_data;

  
    data_memory dm(
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .addr(addr),
        .write_data(write_data),
        .funct3(funct3),
        .read_data(read_data)
    );

   
    always #5 clk = ~clk;


    initial begin
        // Initialize signals
        clk = 0;
        MemRead = 0;
        MemWrite = 0;
        addr = 0;
        write_data = 0;
        funct3 = 3'b000; // LB (Load Byte)

        // Test SB - write 8'b10101010 to memory address 0x4
        #10;
        MemWrite = 1;
        addr = 32'h4;
        write_data = 32'hA5A5A5A5;
        funct3 = 3'b000; // SB
        #10;
        MemWrite = 0;
        
        // Test LB - read byte from address 0x4
        MemRead = 1;
        #10;
        $display("Read data (LB) = %h", read_data);  // Should read 0xA5 (the byte written at address 0x4)

        // Test SH - write 16-bit data to memory address 0x8
        #10;
        MemWrite = 1;
        addr = 32'h8;
        write_data = 32'h12345678;
        funct3 = 3'b001; // SH
        #10;
        MemWrite = 0;

        // Test LH  - read half word from address 0x8
        MemRead = 1;
        #10;
        $display("Read data (LH) = %h", read_data);  // Should read 0x5678 (the half-word written at address 0x8)

        // Test SW - write 32-bit data to memory address 0xC
        #10;
        MemWrite = 1;
        addr = 32'hC;
        write_data = 32'hDEADBEEF;
        funct3 = 3'b010; // SW
        #10;
        MemWrite = 0;

        // Test LW - read word from address 0xC
        MemRead = 1;
        #10;
        $display("Read data (LW) = %h", read_data);  // Should read 0xDEADBEEF (the word written at address 0xC)

        // Test LBU 
        funct3 = 3'b100; // LBU
        MemRead = 1;
        #10;
        $display("Read data (LBU) = %h", read_data);  // Should read 0xA5 (the byte written at address 0x4)

        // Test LHU - read half word from address 0x8
        #10;
        funct3 = 3'b101; // LHU
        MemRead = 1;
        #10;
        $display("Read data (LHU) = %h", read_data);  // Should read 0x5678 (the half-word written at address 0x8)

        $finish;
    end

endmodule
