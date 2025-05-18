module wrapper (
    input clk,
    input rst,
    input clr,
    input start,   // signal to start
    input [7:0] multiplicand, // 8-bit multiplicand
    input [7:0] multiplier,   // 8-bit multiplier
    output [15:0] product     // 16-bit product
);

control_unit control_unit(
    .clk(clk_out),
    .rst(rst),
    .clr(clr),           
    .BTNC(),          
    .BTNL(),
    .BTNR(),         
    .load_data(start),    
    .start_mult(),   
    .scroll_left(),  
    .scroll_right(), 
    .mult_done(multiplication_done),    
    .shift_en(),     
    .extend(),       
    .mult_active()   
);


wire clk_out;
clkdivider clk_out(
    .clk(clk),
    .rst(rst),
    .clk_out(clk_out)
);

wire loading_done;
counter #(4, 8) loading_counter(
    .clk(clk_out),
    .rst(rst),
    .en(start),
    .count(loading_done)
);

wire multiplication_done;
counter #(5, 16) multiplication_counter(
    .clk(clk_out),
    .rst(rst),
    .en(loading_done),
    .count(multiplication_done)
);

wire multiplicand_reg;
parallel_register #(8) multiplicand_reg(
    .clk(clk_out),
    .rst(rst),
    .load(start),
    .data_in(multiplicand),
    .q(multiplicand_reg)
);

wire multiplier_reg;
parallel_register #(8) multiplier_reg(
    .clk(clk_out),
    .rst(rst),
    .load(start),
    .data_in(multiplier),
    .q(multiplier_reg)
);



SPM spm(
    .clk(clk),
    .rst(rst),
    .clr(clr),
    .start(loading_done),
    .extend(1'b0), // SURE 0?
    .multiplicand(),
    .multiplier(),
    .loading_done(),
    .multiplication_done(),
    .product()
);
    
endmodule