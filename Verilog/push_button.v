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


module push_button(input clk, rst, x, output reg na);
   wire unbounce, synced;
   wire between; 
   debouncer bouncer(clk, rst, x, unbounce);
   synch sun (clk, rst, unbounce, synced);
   fsm detector(clk, rst, synced, between);
  // assign na = between; 
  always@(*)begin 
    na = between; 
  end
endmodule


