`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 12:57:17 PM
// Design Name: 
// Module Name: push_button
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


module push_button(input clk, rst, x, output z);
   wire clkout, unbounce, synced;
   clkdivider #(250000) giveme200hz(clk, rst, clkout);
   debouncer bouncer(clkout, rst, x, unbounce);
   synch sun (clkout, rst, unbounce, synced);
   fsm detector(clkout, rst, synced, z);
endmodule


