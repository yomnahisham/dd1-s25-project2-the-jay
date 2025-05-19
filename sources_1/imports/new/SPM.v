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
    input clk,
    input rst,
    input clr,
    input [7:0] multiplicand,
    input [7:0] multiplier,
    output [15:0] product
);

wire [15:0] temp;

complement complement(
    .clk(clk),
    .rst(rst),
    .clr(clr),
    .data_in(multiplicand[7] & multiplier[0]),
    .data_out(product[15])
);

//csa csa1(
//    .clk(clk),
//    .rst(rst),
//    .clr(clr),
//    .x(multiplicand[6] & multiplier[0]),
//    .y(product[7]),
//    .out(product[6])   
//);

genvar i;
generate // generate 7 csa instances
    for (i = 0; i < 7; i = i + 1) begin
        csa csa(
            .clk(clk),
            .rst(rst),
            .clr(clr),
            .x(multiplicand[i + 8] & multiplier[0]),
            .y(product[i+9]),
            .out(product[i + 8])
        );
    end
endgenerate



endmodule