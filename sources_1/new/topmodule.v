`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 05:08:56 AM
// Design Name: 
// Module Name: topmodule
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_module (
    input clk,
    input rst,
    input clr,
    input BTNC,
    input [7:0] parallel_data_in,
    input [7:0] serial_data_in,
    output [15:0] product
);

wire start;
push_button start_button (
    .clk(clk),
    .rst(rst),
    .x(BTNC),
    .z(start)
);

wire clock_out;
clkdivider clk_div (
    .clk(clk),
    .rst(rst),
    .clk_out(clk_out)
);

wire load_done;
counter #(8) load_counter (
    .clk(clk_out),
    .rst(rst),
    .en(start),
    .done(load_done)
);

wire multiplication_done;
counter #(16) multiplication_counter (
    .clk(clk_out),
    .rst(rst),
    .en(start),
    .done(multiplication_done)
);

wire [7:0] multiplicand;
parallel_register #(8) parallel_register (
    .clk(clk_out),
    .rst(rst),
    .load(start),
    .data_in(parallel_data_in),
    .q(multiplicand)
);

wire [7:0] multiplier;
shift_register #(8) shift_register (
    .clk(clk_out),
    .rst(rst),
    .clr(clr),
    .extend(load_done),
    .load(start),
    .data_in(serial_data_in),
    .q(multiplier)
);

wire [15:0] product;
SPM multiplication (
    .clk(clk_out),
    .rst(rst),
    .clr(clr),
    .en(load_done),
    .multiplicand(multiplicand),
    .multiplier(multiplier),
    .product(product)
);
    
endmodule
