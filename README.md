# Digital Design 1 - Project 2: 8x8 Signed Serial-Parallel Multiplier

## Project Overview
This repository contains the implementation of an 8x8 Signed Serial-Parallel Multiplier (SPM) for Digital Design 1 (DD1). The project involves designing and implementing a digital circuit that multiplies two 8-bit signed binary numbers, where one operand is processed serially while the other is available in parallel. The implementation will be demonstrated on the Basys 3 FPGA board.
## Project Structure
```
├── Diagram/
│   └── blockdiagram.pdf    # Block diagram documentation for the entire system
├── Logisim/
│   ├── 7 seg.circ         # 7-segment display driver implementation
│   └── SPM.circ           # Serial-Parallel Multiplier circuit implementation
├── Verilog/
│   ├── constr           # Constraint Files
│   ├── sim             # Simulation Files
|   └── src             # Source Files
└── README.md              # Project documentation
```

## Project Requirements

### Input/Output Specifications
- **Inputs:**
  - Multiplier (8-bit signed): SW7-SW0
  - Multiplicand (8-bit signed): SW15-SW8
- **Outputs:**
  - Product display: Right three 7-segment digits (decimal)
  - Sign display: Leftmost 7-segment digit
  - Multiplication complete indicator: LED L1
- **Controls:**
  - Start multiplication: BTNC
  - Scroll product digits: BTNL and BTNR

### Components

#### 7-Segment Display Driver
- Located in `Logisim/7 seg.circ`
- Implements the display driver for showing the product and sign
- Handles decimal conversion and display multiplexing

#### Serial-Parallel Multiplier (SPM)
- Located in `Logisim/SPM.circ`
- Implements the 8x8 signed multiplication logic
- Processes one operand serially while the other is available in parallel

#### Block Diagram
- Located in `Diagram/blockdiagram.pdf`
- Documents the system architecture and component interconnections

## Team Members
Yomna Otman, Ayla Saleh, Jacques Jean
