`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 05:07:19 PM
// Module Name: wrapper
// Description: Wrapper module for shift-add multiplication system
//////////////////////////////////////////////////////////////////////////////////

module wrapper (
    input clk,
    input en,
    input rst,
    input clr,
    input BTNC,          // center button (start multiplication)
    input BTNL,          // left button (scroll left)
    input BTNR,          // right button (scroll right)
    input [7:0] multiplicand,
    input [7:0] multiplier,
    output [0:6] seg,
    output [3:0] an,
    output [15:0] product
);

// Button debounce and pulse generation
wire start;
//assign start = 1'b1; //TEMPORARY
//push_button btnc_inst (clk, rst, BTNC, start);

// Clock division for system timing
wire clk_out;
clkdivider clkout(
    .clk(clk),
    .rst(rst),
    .clk_out(clk_out)
);

// Wires for status signals
wire loading_done;
wire multiplication_done;
wire [7:0] multiplicand_reg;
wire [7:0] multiplier_reg;
//wire [15:0] product;
wire scroll_left, scroll_right;
wire mult_active;

// Control Unit
control_unit control_unit(
    .clk(clk_out),
    .rst(rst),
    .clr(clr),
    .BTNC(BTNC),
    .BTNL(BTNL),
    .BTNR(BTNR),
    .load_data(start),
    .start_mult(loading_done),
    .scroll_left(scroll_left),
    .scroll_right(scroll_right),
    .mult_done(multiplication_done)
    //.mult_active(mult_active)
);

// Counters for loading and multiplication
wire [3:0] count1;
counter #(4, 8) loading_counter(
    .clk(clk_out),
    .rst(rst),
    .en(1'b1),
    .count(count1),
    .done(loading_done)
);

wire [4:0] count2;
counter #(5, 16) multiplication_counter(
    .clk(clk_out),
    .rst(rst),
    .en(loading_done),
    .count(count2),
    .done(multiplication_done)
);

// Registers for inputs
parallel_register #(8) multiplicandreg(
    .clk(clk_out),
    .rst(rst),
    .load(1'b1),
    .data_in(multiplicand),
    .q(multiplicand_reg)
);

shift_register #(8) multiplierreg(
    .clk(clk_out),
    .rst(rst),
    .clr(clr),
    //.shift_en(mult_active),
    .extend(1'b1),
    .load(1'b1),
    .data_in(multiplier),
    .q(multiplier_reg)
);

// Multiplier (Shift-Add)
SPM spm(
    .clk(clk_out),
    .rst(rst),
    .clr(clr),
    .multiplicand(multiplicand_reg),
    .multiplier(multiplier_reg),
    .product(product)
);

// Display output on 7-segment
display display(
    .r(scroll_right), 
    .l(scroll_left), 
    .clk(clk_out), 
    .rst(rst),
    .binary(product),
    .seg(seg),
    .an(an)
);

endmodule
