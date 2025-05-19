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


module shift_register #(parameter x = 5)(
  input clk,
  input rst,
  input clr,
  //input shift_en,     // triggers serial shifting from data_in
  input extend,       // arithmetic shift (MSB repeat)
  input load,         // initiates serial loading from data_in
  input [x-1:0] data_in,
  output reg [x-1:0] q
);

  reg [$clog2(x):0] load_index;   // enough bits to count to x, log base 2 of n
  reg loading;                    // flag to indicate loading is in progress

  always @(posedge clk or rst) begin
    if (rst || clr) begin
      q <= 0;
      load_index <= 0;
      loading <= 0;
    end else if (load) begin
      loading <= 1;
      load_index <= 0;
      q <= 0;
    end else if (loading) begin
      q <= {data_in[load_index], q[x-1:1]};
      load_index <= load_index + 1;
      if (load_index == x - 1)
        loading <= 0;  // finished loading
//    end else if (shift_en) begin
//      q <= {1'b0, q[x-1:1]};  // shift in zero (or another shift_in input if needed)
    end else if (extend) begin
      q <= {q[x-1], q[x-1:1]};  // arithmetic shift
    end
  end

endmodule
