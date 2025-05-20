`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2025 05:40:36 PM
// Design Name: 
// Module Name: top_module
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


module top_module(
    input clk, rst, en,
    input [7:0] m,
    output [7:0] o
    );
    
    wire [3:0] countSix_out;
    wire load_done;
    counter #(4,8) countSix (
    .clk(clk),           // Clock input
    .rst(rst),           // Reset input
    .en(en),            // Enable input
    .count(countSix_out),  // Counter output
    .done(load_done)       // Done signal when max count reached
    );
    
    
  shift_register #(8)mult(
  .clk(clk),
  .rst(rst),
  .clr(rst),
  .shift_en(1'b1),     // triggers serial shifting from data_in
  .extend(load_done),       // arithmetic shift (MSB repeat)
  .load(1'b1),         // initiates serial loading from data_in
  .data_in(m),
  .q(o)
);


endmodule
