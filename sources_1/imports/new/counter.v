`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 01:00:04 PM
// Design Name: 
// Module Name: counter
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


module counter #(parameter x = 3, n = 6) (
    input clk, rst, en,
    output [x-1:0] count,
    output done
    );
    
    reg [x-1:0] count;
    always @(posedge clk, rst) begin
        if (rst == 1) count <= 0;
        else if (en == 1) begin
            if (count == n-1) count <= count;
            else count <= count + 1;  
        end
    end

    // Done signal when max count reached
    assign done = (count == n - 1);

endmodule 