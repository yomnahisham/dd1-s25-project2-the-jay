`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 08:34:21 PM
// Design Name: 
// Module Name: SIPO
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


module SIPO#(parameter x = 8)(
  input clk,             // Clock signal
  input rst,             // Synchronous reset
  input clr,             // Clear shift register contents
  input shift_en,        // Enables shifting on each clock edge
  input data_in,         // Serial input bit
  output reg [x-1:0] q   // Parallel output
);

  always @(posedge clk or posedge rst) begin
    if (rst || clr) q <= 0;
    else if (shift_en) begin
      q <= {data_in, q[x-1:1]};  // Shift left, bring in data_in at LSB
    end else
        q<=q; 
  end

endmodule
