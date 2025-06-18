
# RV32I Single-Core Processor

This project implements a single-core processor based on the RISC-V RV32I instruction set architecture (ISA). The processor is designed in Verilog and is intended for educational use and simulation.

## Features

- **Instruction Set**: RV32I Base Integer ISA
- **Core Type**: Single-core
- **Data Width**: 32-bit
- **Instruction Width**: 32-bit
- **Supported Operations**:
  - Integer arithmetic and logical operations
  - Load and store operations
  - Branch and jump instructions
  - Immediate-type instructions
- **Pipeline**: Single-cycle (non-pipelined)
- **Register File**: 32 registers (x0–x31)
- **Memory Interface**: Unified instruction and data memory
- **Clocking**: Synchronous
- **Reset**: Active-low

## Modules

- `core.v`: Top-level module that integrates all components.
- `core_tb.v`: Testbench for the processor.
- `alu.v`: Arithmetic Logic Unit for integer operations.
- `adder.v`: Simple adder used in PC or branch calculation.
- `control_unit.v`: Main control logic for instruction decoding.
- `alu_control_unit.v`: ALU control signal generator.
- `register_file.v`: Contains the 32 general-purpose registers.
- `instruction_memory.v`: Read-only instruction memory.
- `data_memory.v`: Data memory for load/store operations.
- `PC.v`: Program counter logic.
- `imm_generator.v`: Immediate value extractor.
- `mux.v`: Multiplexer modules.
- `program.txt`: Sample program or binary to be loaded in instruction memory.


## Simulation

Use a Verilog simulator like Icarus Verilog:

```bash
iverilog -o core_tb core.v core_tb.v alu.v adder.v control_unit.v alu_control_unit.v register_file.v instruction_memory.v data_memory.v PC.v imm_generator.v mux.v
vvp core_tb
```
Or just use Vivado


## Future Improvements

- Add support for M-extension (multiplication/division)
- Verification of the core
- Implement pipelining (multi-stage datapath)
- Add M, A & C extensions for Linux capability
- Integrate instruction/data cache for better performance
- Add exception/interrupt support

## Author

**Rana Umar Nadeem**  
[GitHub Profile](https://github.com/ranaumarnadeem)
