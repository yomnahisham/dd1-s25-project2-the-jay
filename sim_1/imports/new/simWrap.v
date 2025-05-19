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
    reg en;
    reg clr;
    reg BTNC;
    reg BTNL;
    reg BTNR;
    reg [7:0] multiplicand;
    reg [7:0] multiplier;

    // Outputs
    wire [0:6] seg;
    wire [3:0] an;
    wire [15:0] product;

//    // DUT output exposure for validation
//    wire [15:0] debug_product;
//    wire [7:0] debug_mplicand;
//    wire [7:0] debug_mplier;

    // Instantiate DUT
    wrapper uut (
        .clk(clk),
        .en(en),
        .rst(rst),
        .clr(clr),
        .BTNC(BTNC),
        .BTNL(BTNL),
        .BTNR(BTNR),
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .seg(seg),
        .an(an),
        .product(product)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 100 MHz clock (10 ns period)

    // Test Variables
    reg [15:0] expected_product;

    initial begin
        // Initialize
        rst = 1;
        en = 1'b1;
        clr = 0;
        BTNC = 0;
        BTNL = 0;
        BTNR = 0;
        multiplicand = 0;
        multiplier = 0;

        // Wait then release reset
        #20;
        rst = 0;
        en = 1'b1;

        // Apply test values
        multiplicand = 8'd13;
        multiplier   = 8'd7;
        expected_product = multiplicand * multiplier;

        // Simulate BTNC (Start Button)
        #30;
        BTNC = 1;
        #10;
        BTNC = 0;

        // Wait for multiplication to complete
#100;
        // Check result
        if (uut.product === expected_product)
            $display("PASS: %0d * %0d = %0d", multiplicand, multiplier, uut.product);
        else
            $display("FAIL: Expected %0d, Got %0d", expected_product, uut.product);

        // Additional test
        #50;
        multiplicand = 8'd4;
        multiplier   = 8'd15;
        en = 1'b1;
        expected_product = multiplicand * multiplier;

        #20;
        BTNC = 1;
        #10;
        BTNC = 0;

        #100;
        if (product === expected_product)
            $display("PASS: %0d * %0d = %0d", multiplicand, multiplier, uut.product);
        else
            $display("FAIL: Expected %0d, Got %0d", expected_product, uut.product);

        $finish;
    end

endmodule
