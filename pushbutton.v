module pushbutton(
    input wire clk,           // System clock
    input wire rst,           // Reset signal
    input wire button_in,     // Raw button input
    output wire button_out    // Debounced and edge-detected output
);

    // Debounced button signal
    wire button_debounced;

    // Instantiate debouncer
    debouncer debouncer_inst (
        .clk(clk),
        .rst(rst),
        .in(button_in),
        .out(button_debounced)
    );

    // Instantiate rising edge detector
    rising_edge_detector red_inst (
        .clk(clk),
        .rst(rst),
        .w(button_debounced),
        .z(button_out)
    );

endmodule 