# FPGA Ping Pong Game
A hardware implementation of the classic Ping Pong (Pong) arcade game, written in Verilog and designed for FPGA boards. 

## Overview
This project handles VGA synchronization, game logic, paddle movement, and score tracking using a seven-segment display. It was developed and compiled using Intel Quartus.

## Hardware Requirements
* **FPGA Board:** (e.g., Altera DE2, Cyclone IV, etc. - put your board here)
* **Display:** VGA-compatible monitor
* **Inputs:** Push buttons on the FPGA for paddle control

## Block diagrams


## Algorithmic Overview



## File Structure
* `pong_top.v` - The top-level module connecting all components
* `vga_sync.v` - Handles VGA timing and synchronization signals
* `pong_graph.v` - Generates the pixel graphics for paddles and the ball
* `debounce.v` - Debounces the physical button inputs
* `seven_seg.v` - Drives the seven-segment display for scoring

## How to Run
1. Open `pong_fpga.qpf` in Intel Quartus.
2. Assign the correct pins for your specific FPGA board using the Pin Planner.
3. Compile the design.
4. Program the device via the Quartus Programmer.