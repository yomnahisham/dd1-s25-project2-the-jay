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
    output reg sum
);

    reg sc;

    // Half Adders logic
    wire hsum1, hco1;
    assign hsum1 = y ^ sc;
    assign hco1 = y & sc;

    wire hsum2, hco2;
    assign hsum2 = x ^ hsum1;
    assign hco2 = x & hsum1;

    always @(posedge clk) begin
        if (rst || clr) begin
            // Reset logic
            sum <= 1'b0;
            sc <= 1'b0;
        end else begin
            // Sequential logic
            sum <= hsum2;
            sc <= hco1 ^ hco2;  // Carry-save logic
        end
    end
endmodule