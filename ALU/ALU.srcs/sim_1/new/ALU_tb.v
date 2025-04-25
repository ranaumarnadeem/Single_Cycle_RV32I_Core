`timescale 1ns / 1ps

module alu_tb;

  
    reg  [31:0] a, b;
    reg  [3:0]  alu_ctrl;

  
    wire [31:0] result;
    wire        zero;

   
    alu uut (
        .a(a),
        .b(b),
        .alu_ctrl(alu_ctrl),
        .result(result),
        .zero(zero)
    );

    initial begin
       

        //ADD
        a = 32'd10; b = 32'd5; alu_ctrl = 4'b0010;
        #5 $display("ADD  : %0d + %0d = %0d (zero = %b)", a, b, result, zero);

        // SUB
        a = 32'd10; b = 32'd5; alu_ctrl = 4'b0110;
        #5 $display("SUB  : %0d - %0d = %0d (zero = %b)", a, b, result, zero);

        // AND
        a = 32'hFF00FF00; b = 32'h0F0F0F0F; alu_ctrl = 4'b0000;
        #5 $display("AND  : %h & %h = %h", a, b, result);

        // OR
        a = 32'h0000FFFF; b = 32'hFFFF0000; alu_ctrl = 4'b0001;
        #5 $display("OR   : %h | %h = %h", a, b, result);

        // XOR
        a = 32'hAAAAAAAA; b = 32'h55555555; alu_ctrl = 4'b0011;
        #5 $display("XOR  : %h ^ %h = %h", a, b, result);

        // SLL
        a = 32'h00000001; b = 32'd4; alu_ctrl = 4'b0100;
        #5 $display("SLL  : %h << %d = %h", a, b[4:0], result);

        // SRL
        a = 32'h80000000; b = 32'd4; alu_ctrl = 4'b0101;
        #5 $display("SRL  : %h >> %d = %h", a, b[4:0], result);

        // SRA
        a = -32'sd16; b = 32'd2; alu_ctrl = 4'b1101;
        #5 $display("SRA  : %0d >>> %d = %0d", a, b[4:0], result);

        // SLT (signed)
        a = -32'sd1; b = 32'sd1; alu_ctrl = 4'b0111;
        #5 $display("SLT  : %0d < %0d = %0d", a, b, result);

        // SLTU (unsigned)
        a = 32'hFFFFFFFF; b = 32'h00000001; alu_ctrl = 4'b1000;
        #5 $display("SLTU : %0u < %0u = %0d", a, b, result);

        // Zero Flag Test
        a = 32'd10; b = 32'd10; alu_ctrl = 4'b0110;
        #5 $display("SUB  : %0d - %0d = %0d (zero = %b)", a, b, result, zero);

        $display("\nTestbench complete.");
        $stop;
    end

endmodule
