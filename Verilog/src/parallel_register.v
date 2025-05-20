`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 05:06:21 PM
// Design Name: 
// Module Name: parallel_register
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


module parallel_register #(parameter x = 4)(
  input clk, rst, load,
  input [x-1:0] data_in,
  output reg [x-1:0] q
);

always @(posedge clk or posedge rst) begin
  if(rst) q <= {x{1'b0}};
  else if (load) q <= data_in;
  else q<=q;  
end
endmodule 