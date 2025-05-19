`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 05:50:43 AM
// Design Name: 
// Module Name: simtop
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

module simtop();

    // Inputs
    reg clk;
    reg rst;
    reg clr;
    reg BTNC;
    reg [7:0] parallel_data_in;
    reg [7:0] serial_data_in;

    // Output
    wire [15:0] product;

    // Instantiate the top module
    top_module uut (
        .clk(clk),
        .rst(rst),
        .clr(clr),
        .BTNC(BTNC),
        .parallel_data_in(parallel_data_in),
        .serial_data_in(serial_data_in),
        .product(product)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 100 MHz (10 ns period)

    // Test procedure
    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        clr = 0;
        BTNC = 0;
        parallel_data_in = 0;
        serial_data_in = 0;

        // Reset pulse
        #20;
        rst = 0;

        // Load test data: multiplicand = 13 (0x0D), multiplier = 7 (0x07)
        parallel_data_in = 8'd13;
        serial_data_in   = 8'd7;

        // Simulate button press to start
        #10 BTNC = 1;
        #10 BTNC = 0;

        // Wait for computation (give time for 8 + 16 = 24 clock cycles)
        // After division, each clk_out cycle = ~100ns (due to clock divider),
        // So we wait ~3us to be safe.
        #3000;

        // Check result
        if (product === 13 * 7)
            $display("PASS: 13 * 7 = %0d", product);
        else
            $display("FAIL: Expected 91, Got %0d", product);

        // Add second test: 4 * 15 = 60
        parallel_data_in = 8'd4;
        serial_data_in   = 8'd15;

        #20 BTNC = 1;
        #10 BTNC = 0;

        #3000;

        if (product === 4 * 15)
            $display("PASS: 4 * 15 = %0d", product);
        else
            $display("FAIL: Expected 60, Got %0d", product);

        $finish;
    end

endmodule

