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


module counter #(parameter bits = 4, parameter max_count = 15)(
    input  clk,           // Clock input
    input  rst,           // Reset input
    input  en,            // Enable input
    output reg [bits-1:0] count,  // Counter output
    output reg done       // Done signal when max count reached
);

    // Counter logic
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= {bits{1'b0}};
        else if (en) begin
            if (count == max_count)
                count <= {bits{1'b0}}; // Reset the counter
            else
                count <= count + 1'b1; // Increment the counter
        end
    end

    // Registered done signal when max count reached
    always @(posedge clk or posedge rst) begin
        if (rst)
            done <= 0;
        else if (en && count == max_count)
            done <= 1; // Set done when max count is reached
        else
            done <= 0; // Clear done signal when the counter is not at max count
    end

endmodule
 