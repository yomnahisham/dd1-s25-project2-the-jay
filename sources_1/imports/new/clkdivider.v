`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 12:55:34 PM
// Design Name: 
// Module Name: clkdivider
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


module clkdivider#(parameter n = 50000000)(
    input clk, rst,
    output reg clk_out
);

reg [31:0] count;

always @ (posedge clk or rst) begin
   if (rst) begin
       count <= 0;
       clk_out <= 0;
   end
   else begin
       if (count == n-1) begin
           count <= 0;
           clk_out <= ~clk_out;
       end
       else
           count <= count + 1;
   end
end
endmodule