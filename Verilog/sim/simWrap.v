`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 07:21:47 PM
// Design Name: 
// Module Name: simWrap
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


module simWrap();

    // Inputs
    reg clk;
    reg rst;
    reg clr;
    reg BTNC;
    reg BTNL;
    reg BTNR;
    reg [7:0] multiplicand;
    reg [7:0] multiplier;

    // Outputs
    wire [0:6] seg;
    wire [3:0] an;

//    // DUT output exposure for validation
//    wire [15:0] debug_product;
//    wire [7:0] debug_mplicand;
//    wire [7:0] debug_mplier;

    // Instantiate DUT
    wrapper uut (
        .clk(clk),
        .rst(rst),
        .clr(clr),
        .BTNC(BTNC),
        .BTNL(BTNL),
        .BTNR(BTNR),
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .seg(seg),
        .an(an)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 100 MHz clock (10 ns period)

    // Test Variables
    reg [15:0] expected_product;

    initial begin
        // Initialize
        rst = 1;
        clr = 0;
        BTNC = 0;
        BTNL = 0;
        BTNR = 0;
        multiplicand = 0;
        multiplier = 0;

        // Wait then release reset
        //#20;
        repeat(1) @(negedge clk);
        rst = 0;
        clr = 1; 
        // Apply test values
        multiplicand = -8'd7;
        multiplier   = 8'd3;
        expected_product = multiplicand * multiplier;
        #5; clr = 0; #5; 
        // Simulate BTNC (Start Button)
        //#30;
        repeat(1) @(negedge clk);
        BTNC = 1;
        repeat(6) @(negedge clk);
        //#100;
        BTNC = 0;

        // Wait for multiplication to complete
#2000;
        // Check result
        if (uut.product === expected_product)
            $display("PASS: %0d * %0d = %0d", multiplicand, multiplier, uut.product);
        else
            $display("FAIL: Expected %0d, Got %0d", expected_product, uut.product);

        // Additional test
        #50;
        multiplicand = 8'd4;
        multiplier   = 8'd15;
        expected_product = multiplicand * multiplier;

        #20;
        BTNC = 1;
        #10;
        BTNC = 0;

        #100;


        $finish;
    end

endmodule
