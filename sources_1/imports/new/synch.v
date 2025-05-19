`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 12:58:36 PM
// Design Name: 
// Module Name: synch
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


module synch(
input wire clk,
input wire rst,
input wire s,
output reg s1
);
reg m;
always @(posedge clk, posedge rst) begin
if(rst) begin 
    m <= 0;
    s1 <= 0;
end else begin 
    m <= s;
    s1 <= m;
end 
end
endmodule

