`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 12:57:17 PM
// Design Name: 
// Module Name: push_button
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

module push_button(
    input clk, rst, x,
    output z
    );
    
    wire db_out;
    debouncer db(
        .clk(clk_out),
        .rst(rst),
        .in(x),
        .out(db_out)
    );
    
    wire sig_out;
    synch sun(
        .clk(clk_out),
        .sig(db_out),
        .sig1(sig_out)
    );
    
    fsm detector(
        .clk(clk_out),
        .rst(rst),
        .x(sig_out),
        .z(z)
    );
    
endmodule

