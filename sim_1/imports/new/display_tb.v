`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 01:18:54 PM
// Design Name: 
// Module Name: display_tb
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


module display_tb();
    // Inputs
    reg clk = 0;
    reg rst;
    reg x;

    // Output
    wire z;
    // Expose clkout so we can wait on the divided clock
    wire clkout;

    // DUT with DIV=1 for fast clkout
    push_button #(.DIV(1)) uut (
        .clk    (clk),
        .rst    (rst),
        .x      (x),
        .z      (z)
    );
    assign clkout = uut.clkout;

    // 100 MHz clock
    always #5 clk = ~clk;

    initial begin
        // Reset
        rst = 1; x = 0;
        #20; rst = 0;

        // 1) Short bounces (should NOT produce z)
        x = 1; #10; x = 0; #10;
        x = 1; #10; x = 0; #10;
        // give it a moment on clkout
        repeat (3) @(posedge clkout);

        // 2) Clean press (should produce one z)
        #20;
        x = 1; #20; x = 0;
        // wait 5 clkout cycles to let debouncer+sync clear
        repeat (5) @(posedge clkout);

        // 3) Second clean press (should produce another z)
        x = 1; #20; x = 0;
        repeat (5) @(posedge clkout);

        // 4) Third clean press
        x = 1; #20; x = 0;
        repeat (5) @(posedge clkout);

        $finish;
    end

    // Print whenever z goes high
    always @(posedge clk) if (z)
        $display("[%0t] >>> pulse detected (z=1)", $time);
endmodule
