`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 05:01:37 PM
// Design Name: 
// Module Name: SPM
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


module SPM(
    input clk, rst, clr,
    input [7:0] x,
    input y,
    output p
);
    // Declare the partial product signals
    wire [7:1] pp;  
    
    // First CSA instance for the first bit
    csa csa0 (.clk(clk), .rst(rst), .clr(clr), .x(x[0]&y), .y(pp[1]), .sum(p));
   
    genvar i;
    generate 
        for(i=1; i<7; i=i+1) begin
            csa csa_inst (.clk(clk), .rst(rst), .clr(clr), .x(x[i]&y), .y(pp[i+1]), .sum(pp[i]));
        end 
    endgenerate
    
    // Handle the complement for signed multiplication 
    complement tcmp (.clk(clk), .rst(rst), .clr(clr), .data_in(x[7]&y), .data_out(pp[7]));
    
endmodule
 
