module core (
    input  wire        clk,
    input  wire        reset,
    output wire [31:0] pc_current,
    output wire [31:0] instruction,
    output wire [31:0] result
);

    wire [31:0]  pc_next, pc_plus4;

    wire [6:0]  opcode = instruction[6:0];
    wire [4:0]  rd     = instruction[11:7];
    wire [2:0]  funct3 = instruction[14:12];
    wire [4:0]  rs1    = instruction[19:15];
    wire [4:0]  rs2    = instruction[24:20];
    wire [6:0]  funct7 = instruction[31:25];

    wire        RegWrite, ALUSrc, MemRead, MemWrite, MemToReg, Branch;
    wire [1:0]  ALUOp;

    wire [31:0] imm;
    wire [31:0] read_data1, read_data2;
    wire [3:0]  alu_ctrl;
    wire [31:0] alu_input1;
    wire [31:0] alu_input2;
    wire [31:0] alu_result;
    wire        zero_flag;
    wire [31:0] data_mem_out;
    wire [31:0] write_back_data;
    wire [31:0] branch_target;
    wire        branch_taken;

    wire [31:0] x4; // Register x4 (a4) output

    pc pc_inst (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc_current(pc_current)
    );

    adder pc_adder (
        .a(pc_current),
        .b(32'd4),
        .sum(pc_plus4)
    );

    instruction_memory instr_mem_inst (
        .clk(clk),
        .addr(pc_current),
        .instruction(instruction)
    );

    control_unit ctrl (
        .opcode(opcode),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    register_file reg_file (
        .clk(clk),
        .reset(reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_back_data),
        .reg_write(RegWrite),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .x4(x4) // expose register 4
    );

    assign result = x4;

    imm_generator imm_gen (
        .instr(instruction),
        .imm_out(imm)
    );

    alu_control_unit alu_ctrl_unit (
        .alu_op(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .alu_ctrl(alu_ctrl)
    );

    mux #(32) alu_src_mux (
        .a(read_data2),
        .b(imm),
        .sel(ALUSrc),
        .out(alu_input2)
    );

    // for lui
    assign alu_input1 = (ALUOp == 2'b11) ? 32'b0 : read_data1;

    alu alu_inst (
        .a(alu_input1),
        .b(alu_input2),
        .alu_ctrl(alu_ctrl),
        .result(alu_result),
        .zero(zero_flag)
    );

    data_memory data_mem (
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .addr(alu_result),
        .write_data(read_data2),
        .read_data(data_mem_out)
    );

    mux #(32) write_back_mux (
        .a(alu_result),
        .b(data_mem_out),
        .sel(MemToReg),
        .out(write_back_data)
    );

    adder branch_adder (
        .a(pc_current),
        .b(imm),
        .sum(branch_target)
    );

    assign branch_taken = Branch & zero_flag;

    mux #(32) pc_mux (
        .a(pc_plus4),
        .b(branch_target),
        .sel(branch_taken),
        .out(pc_next)
    );

endmodule
