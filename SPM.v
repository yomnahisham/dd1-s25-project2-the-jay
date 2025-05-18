module SPM(
    input wire [7:0] multiplicand,
    input wire [7:0] multiplier,
    output reg [15:0] product
);

complement complement(
    .clk(clk_out),
    .rst(rst),
    .clr(clr),
    .data_in(multiplicand[7] & multiplier[0]),
    .data_out(product[7])
);

genvar i;
generate // generate 7 csa instances
    for (i = 6; i >= 0; i = i - 1) begin
        csa csa(
            .clk(clk_out),
            .rst(rst),
            .clr(clr),
            .x(multiplicand[i] & multiplier[0]),
            .y(product[i]),
            .sum(product[i])
        );
    end
endgenerate

endmodule