`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 05:05:22 PM
// Design Name: 
// Module Name: csa
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


module csa (
    input clk,
    input rst,
    input clr,
    input x,
    input y,
    output reg out
);

reg d;

always@(posedge clk  or rst) begin
    if (rst) begin
        out <= 1'b0;
        d <= 1'b0;
    end else if(clr) begin
        out <= 1'b0;
        d <= 1'b0;
    end else begin
        out <= d ^ y ^ x; // Sum = A XOR B XOR Cin
        d <=  ((y ^ d) & x) ^ (y & d); // Carry = (A AND B) OR (Cin AND (A XOR B))
    end
end

    
endmodule