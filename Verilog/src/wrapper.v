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
    input rst,
    input clr,
    input BTNC,          // center button (start multiplication)
    input BTNL,          // left button (scroll left)
    input BTNR,          // right button (scroll right)
    input [7:0] multiplicand,
    input [7:0] multiplier,
    output done,
    output [0:6] seg,
    output [3:0] an
);

// Button debounce and pulse generation
wire go;
push_button btnc_inst(.clk(clk_out), .rst(rst), .x(BTNC), .na(go));


// Clock division for system timing
wire clk_out;
clkdivider #(200000) clkout(
    .clk(clk),
    .rst(rst),
    .clk_out(clk_out)
);

// Wires for status signals
wire loading_done, mult_active, loading;
wire multiplication_done;
wire [7:0] multiplicand_reg;
wire [7:0] multiplier_reg;
wire scroll_left, scroll_right;

// Counters for loading and multiplication
wire [3:0] count1;
counter #(4, 6) loading_counter(
    .clk(clk_out),
    .rst(rst),
    .en(loading),
    .count(count1),
    .done(loading_done)
);

// Control Unit
control_unit control_unit(
    .clk(clk_out),
    .rst(rst),
    .clr(clr),
    .BTNC(BTNC),
    .BTNL(BTNL),
    .BTNR(BTNR),
    .loading_done(loading_done),
    .load_data(loading),
    .start_mult(go),
    .scroll_left(scroll_left),
    .scroll_right(scroll_right),
    .mult_done(multiplication_done),
    .mult_active(mult_active)
);


//Loads multiplicand to PIPO register once after go
parallel_register #(8) multiplicandreg(
    .clk(clk_out),
    .rst(rst),
    .load(go),
    .data_in(multiplicand),
    .q(multiplicand_reg)
);

//Shifts in Multiplier starting from when go is pressed untill 8 clk cycles are passed 
//shoud also extend sign, hence extend always = 1
shift_register #(8) multiplierreg(
    .clk(clk_out),
    .rst(rst),
    .clr(clr),
    .shift_en(1'b1), //should stay shifting forever
    .extend(1'b1),
    .load(loading),
    .data_in(multiplier),
    .q(multiplier_reg)
);

wire [4:0] count2;
counter #(5, 15) multiplication_counter(
    .clk(clk_out),
    .rst(rst),
    .en(mult_active),
    .count(count2),
    .done(multiplication_done)
);

//takes ouput bit of product
wire tprod;
// Multiplier (Shift-Add)
SPM spm(
    .clk(clk_out),
    .rst(rst),
    .clr(clr || loading ),
    .x(multiplicand_reg),
    .y(multiplier_reg[0]), // Q0 changes each clk cycle with shift reg
    .p(tprod)
);

wire [15:0] product;
SIPO #(16) productreg(
    .clk(clk_out),
    .rst(rst),
    .clr(loading),
    .shift_en(mult_active),
    .data_in(tprod),
    .q(product)
);

// Display output on 7-segment
display display(
    .r(scroll_right), 
    .l(scroll_left), 
    .clk(clk), 
    .rst(rst),
    .clr(clr),
    .binary(product),
    .seg(seg),
    .an(an)
);


assign done = multiplication_done;

endmodule
