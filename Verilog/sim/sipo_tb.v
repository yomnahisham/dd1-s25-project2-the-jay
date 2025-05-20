`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2025 04:50:12 PM
// Design Name: 
// Module Name: sipo_tb
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


module sipo_tb(); 
parameter WIDTH = 8;

  // Testbench signals
  reg clk;
  reg rst;
  reg clr;
  reg shift_en;
  reg data_in;
  wire [WIDTH-1:0] q;

  // Instantiate the SIPO module
  SIPO #(WIDTH) uut (
    .clk(clk),
    .rst(rst),
    .clr(clr),
    .shift_en(shift_en),
    .data_in(data_in),
    .q(q)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;  // 10 ns clock period

  // Test sequence
  initial begin
    $display("Time\t rst clr shift_en data_in q");
    $monitor("%4t\t %b   %b   %b        %b      %b", $time, rst, clr, shift_en, data_in, q);

    // Initial state
    clr = 1; rst = 0; shift_en = 0; data_in = 0;
    #10;

    // Release reset
    clr = 0; 
    #10;

    // Set some random data and try shifting while shift_en=0
    data_in = 1; shift_en = 1;
    #20;

    // Trigger clear
    clr = 1;
    #10;
    clr = 0;

    // Enable shift and shift in 3 bits: 1, 0, 1
    shift_en = 1;

    data_in = 1; #10;
    data_in = 0; #10;
    data_in = 1; #10;

    // Stop shifting
    shift_en = 0;
    #20;

    // End of test
    $finish;
  end

endmodule