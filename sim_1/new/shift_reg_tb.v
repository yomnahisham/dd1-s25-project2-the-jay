`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 01:35:25 AM
// Design Name: 
// Module Name: shift_reg_tb
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


module shift_reg_tb();

    parameter WIDTH = 5;

    // Inputs
    reg clk;
    reg rst;
    reg clr;
    reg shift_en;
    reg extend;
    reg load;
    reg [7:0] data_in;

    // Output
    wire [7:0] q;

    // Instantiate DUT
    shift_register #(8) uut (
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
    initial clk = 0;
    always #5 clk = ~clk;  // 10 ns clock

    initial begin
        // Initialize all signals
        rst = 1; clr = 0;
        shift_en = 0;
        extend = 0;
        load = 0;
        data_in = 8'b11110101;

        #10;
        rst = 0;  // Release reset

        // Begin serial load
        #10;
        load = 1;
        #10;
        load = 0;

        // Wait for full loading (WIDTH cycles)
        #(8 * 10);
        $display("Loaded value = %b", q);

        // Perform logical shift (shift_en)
//        shift_en = 1;
//        #80;
//        //shift_en = 0;
//        $display("After logical shift = %b", q);

        // Perform arithmetic shift (extend)
        extend = 1;
        #80;
        $display("After arithmetic shift = %b", q);

        // Clear register
//        clr = 1;
//        #10;
//        clr = 0;
//        $display("After clear = %b", q);

        //$finish;
    end

endmodule
