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
    input en,
    input [7:0] multiplicand,
    input [7:0] multiplier,
    output [15:0] product
);

wire [15:0] temp;

complement complement(
    .clk(clk),
    .rst(rst),
    .clr(clr),
    .data_in(multiplicand[1] & multiplier[0]),
    .data_out(product[7])
);

genvar i;
generate // generate 7 csa instances
    for (i = 0; i < 7; i = i + 1) begin
        csa csa(
            .clk(clk),
            .rst(rst),
            .clr(clr),
            .x(multiplicand[i] & multiplier[0]),
            .y(product[i+1]),
            .out(product[i])
        );
    end
endgenerate

//always @(posedge clk or rst) begin
//    if (rst || clr) begin
//        product <= 0;
//    end else if (en) begin
//        product <= {1'b0, product[14:0]}; // shift right
//    end
//end


endmodule
