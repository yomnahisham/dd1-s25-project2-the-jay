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
  - Multiplication complete indicator: LED LD0
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
- Required for Milestone 1 (May 11th)

## Current Status
- **Milestone 1 (May 11th) - In Progress**
  - Block diagram design
  - Logisim implementation of:
    1. 7-Segment display driver
    2. Serial-Parallel Multiplier

## Getting Started
1. Clone this repository
2. Open the .circ files using Logisim Evolution
3. Review the block diagram in the Diagram directory
4. Follow the circuit implementations in the Logisim files

## Team Members
Yomna Otman, Ayla Saleh, Jacques Jean
