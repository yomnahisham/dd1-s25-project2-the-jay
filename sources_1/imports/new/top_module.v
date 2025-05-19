module top_module (
    input clk,
    input rst,
    input clr,
    input BTNC,
    input [7:0] parallel_data_in,
    input [7:0] serial_data_in,
);

wire start;
push_button start_button (
    .clk(clk),
    .rst(rst),
    .x(BTNC),
    .z(start)
);

wire clock_out;
clock_divider clk_div (
    .clk(clk),
    .rst(rst),
    .clr(clr),
    .clk_out(clk_out)
);

wire load_done;
counter #(8) load_counter (
    .clk(clk_out),
    .rst(rst),
    .clr(clr),
    .enable(start),
    .done(load_done)
);

wire multiplication_done;
counter #(16) multiplication_counter (
    .clk(clk_out),
    .rst(rst),
    .clr(clr),
    .enable(load_done),
    .done(multiplication_done)
);

wire [7:0] multiplicand;
parallel_register #(8) multiplicand (
    .clk(clk_out),
    .rst(rst),
    .clr(clr),
    .load(load_data),
    .data_in(parallel_data_in),
    .data_out(multiplicand)
);

wire [7:0] multiplier;
shift_register #(8) multiplier (
    .clk(clk_out),
    .rst(rst),
    .clr(clr),
    .extend(load_done),
    .load(load_data),
    .data_in(serial_data_in),
    .q(multiplier)
);

wire [15:0] product;
SPM multiplier (
    .clk(clk_out),
    .rst(rst),
    .clr(clr),
    .multiplicand(multiplicand),
    .multiplier(multiplier),
    .product(product)
);
    
endmodule