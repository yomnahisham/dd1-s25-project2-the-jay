`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 06:00:54 PM
// Design Name: 
// Module Name: shift_tb
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


module shift_tb;

reg clk, rst, en;
reg [7:0] m;
wire [7:0] o;

top_module top(
    .clk(clk), .rst(rst), .en(en),
    .m(m),
    .o(o)
    );
    
initial begin
    clk <= 0;
    forever clk <= ~clk;
end

initial begin
    rst = 0; en = 1; m = 8'b10101010;
end

endmodule
