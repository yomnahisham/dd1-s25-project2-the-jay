`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 02:27:17 PM
// Design Name: 
// Module Name: pb_tb
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


module pb_tb(); 
    // Inputs
    reg clk = 0;
    reg rst;
    reg x;

    // Output
    wire z;

    // DUT (using DIV=1 for fast clkout)
    push_button uut (
        .clk(clk),
        .rst(rst),
        .x(x),
        .z(z)
    );

    // 100 MHz clock
    always #5 clk = ~clk;

    initial begin
        // Reset
        rst = 1; x = 0;
        #20; rst = 0;

        // 1) Short bounces (should NOT produce z)
        x = 1; #100; x = 0; #10;
        x = 1; #10; x = 0; #10;

        // 2) Clean press (should produce one z)
        #20;
        x = 1; #20; x = 0;
        #50;

        // 3) Another clean press
        x = 1; #100; x = 0;
        #50;

        $finish;
    end

    // Print whenever z goes high
    always @(posedge clk) if (z)
        $display("[%0t] >>> pulse detected (z=1)", $time);
endmodule

