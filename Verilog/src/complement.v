`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 05:02:42 PM
// Design Name: 
// Module Name: complement
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


module complement(
    input clk,
    input rst,
    input clr,
    input data_in,
    output reg data_out
);

    reg d;

    always @(posedge clk) begin
        if (rst || clr) begin
            data_out <= 1'b0;
            d <= 1'b0;
        end if (clr) begin
            data_out <= 1'b0;
            d <= 1'b0;
        end else begin
            data_out <= d ^ data_in;  // XOR operation to invert the input data
            d <= d | data_in;  // OR operation to store the result
        end
    end
endmodule