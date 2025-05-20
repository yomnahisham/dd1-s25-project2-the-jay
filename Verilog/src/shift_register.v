`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 05:06:53 PM
// Design Name: 
// Module Name: shift_register
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


module shift_register #(parameter x = 8)(
  input clk,
  input rst,
  input clr,
  input shift_en,     // triggers serial shifting from data_in
  input extend,       // arithmetic shift (MSB repeat)
  input load,         // initiates serial loading from data_in
  input [x-1:0] data_in,
  output reg [x-1:0] q
);

//  reg [$clog2(x):0] load_index;   // enough bits to count to x, log base 2 of n
//  reg loading;                    // flag to indicate loading is in progress

/// Initialize q to avoid X values
  initial begin
    q = {x{1'b0}};
  end
  
  always @(posedge clk or posedge rst) begin
    if (rst || clr) begin
      q <= {x{1'b0}}; // Explicitly initialize to all zeros
    end else if (load) begin
      // Parallel load from data_in
      q <= data_in;
    end else if (shift_en) begin
      // Shift right with MSB extension if needed
      if (extend) 
        q <= {q[x-1], q[x-1:1]};
      else 
        q <= {1'b0, q[x-1:1]};
    end
  end
endmodule
