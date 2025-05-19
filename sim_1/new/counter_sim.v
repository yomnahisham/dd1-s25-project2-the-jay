`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 01:19:15 AM
// Design Name: 
// Module Name: counter_sim
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


module counter_sim();

reg clk, rst, en;
wire [2:0] count;
wire done;


counter #(3,6) counter(
    .clk(clk), .rst(rst), .en(en),
    .count(count),
    .done(done)
    );
    
    initial begin
        clk = 0;
        forever #10 clk=~clk;
    end
    
    initial begin
        en = 1;
        rst=1;
        #100
        rst=0;
        #100
        en=0;
        #100
        en = 1;
    end
    
endmodule
