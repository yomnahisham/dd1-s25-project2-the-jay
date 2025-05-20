`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 01:04:43 PM
// Design Name: 
// Module Name: SPMsim
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


module SPMsim(

    );

    // Declare the inputs as reg (for driving test signals)
    reg clk_out;
    reg rst;
    reg clr;
    reg [7:0] multiplicand;
    reg multiplierbit;

    // Declare the output as wire (since it's an output)
    wire product;

    // Instantiate the SPM module
    SPM uut (
        .clk(clk_out),
        .rst(rst),
        .clr(clr),
        .x(multiplicand),
        .y(multiplierbit),
        .p(product)
    );

    // Clock generation
    always begin
        #5 clk_out = ~clk_out; // Toggle clock every 5 time units
    end

    // Stimulus block (Test procedure)
    initial begin
        // Initialize the inputs
        clk_out = 0;
        rst = 0;
        clr = 0;
        multiplicand = 8'b00000000; // Initial multiplicand
        multiplierbit = 0; // Initial multiplier bit

        // Apply reset
        rst = 1;
        #5 rst = 0; // Reset pulse duration

        // Apply test cases
        $display("Running Test Case 1...");
        multiplicand = 8'b00001100; // Test multiplicand
        multiplierbit = 1;
        clr = 1; // Clear all registers
        #10 clr = 0;
        
        // Test case: Apply values and check the produc

    end

    // Monitor the output
    initial begin
        $monitor("At time %t: multiplicand = %b, multiplierbit = %b, product = %b", $time, multiplicand, multiplierbit, product);
    end

endmodule
