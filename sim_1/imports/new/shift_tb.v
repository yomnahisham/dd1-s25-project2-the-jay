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

  // Parameters
  parameter x = 5;
  reg clk, rst, clr, shift_en, extend, load;
  reg [x-1:0] data_in;
  wire [x-1:0] q;

  // Instantiate shift_register
  shift_register #(x) uut (
    .clk(clk),
    .rst(rst),
    .clr(clr),
    .shift_en(shift_en),
    .extend(extend),
    .load(load),
    .data_in(data_in),
    .q(q)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Variables for checking
  reg [x-1:0] expected_q [0:x];  // Stores expected values
  integer i;

  initial begin
    // Initialize
    clk = 0;
    rst = 1; clr = 0;
    shift_en = 0;
    extend = 0;
    load = 0;
    data_in = 5'b10101;
    #10;

    // Release reset
    rst = 0;
    #10;

    // Set expected values for LSB-first loading
    expected_q[0] = 5'b00000;  // After load triggered
    expected_q[1] = 5'b00001;
    expected_q[2] = 5'b00010;
    expected_q[3] = 5'b00101;
    expected_q[4] = 5'b01010;
    expected_q[5] = 5'b10101;

    // Start loading serially
    load = 1;
    #10;
    load = 0;

    // Observe shifting over time
    for (i = 1; i <= x; i = i + 1) begin
      #10;  // Wait for clock edge
      if (q !== expected_q[i]) begin
        $display("FAIL at cycle %0d: q = %b, expected = %b", i, q, expected_q[i]);
      end else begin
        $display("PASS at cycle %0d: q = %b", i, q);
      end
    end

    $display("Test completed.");
    $finish;
  end

endmodule
