module control_unit(
    input wire clk,           // system clock
    input wire rst,           // reset signal
    input wire BTNC,          // center button (start multiplication)
    input wire BTNL,          // left button (scroll left)
    input wire BTNR,          // right button (scroll right)
    input wire [7:0] SW,      // switches for multiplier input
    input wire [7:0] SW2,     // switches for multiplicand input
    output wire load_data,    // signal to load data into registers
    output wire start_mult,   // signal to start multiplication
    output wire scroll_left,  // signal to scroll display left
    output wire scroll_right, // signal to scroll display right
    output wire mult_done,    // signal indicating multiplication is complete
    output wire [7:0] multiplier_out,    // output of multiplier register
    output wire [7:0] multiplicand_out,  // output of multiplicand register
    output wire shift_en,     // enable signal for multiplier shift
    output wire extend,       // signal to enable sign extension
    output wire mult_active   // signal indicating multiplication is in progress
);

    // button processing
    pushbutton btnc_inst (.clk(clk), .rst(rst), .button_in(BTNC), .button_out(start_mult));
    pushbutton btnl_inst (.clk(clk), .rst(rst), .button_in(BTNL), .button_out(scroll_left));
    pushbutton btnr_inst (.clk(clk), .rst(rst), .button_in(BTNR), .button_out(scroll_right));

    // state machine for control
    reg [2:0] state, next_state;
    parameter IDLE = 3'b000;
    parameter LOAD = 3'b001;
    parameter MULT = 3'b010;
    parameter DONE = 3'b011;

    // state register
    always @(posedge clk or posedge rst) 
        if (rst)
            state <= IDLE;
        else
            state <= next_state;

    // next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (start_mult)
                    next_state = LOAD;
                else
                    next_state = IDLE;
            end
            LOAD: begin
                next_state = MULT;
            end
            MULT: begin
                if (mult_done)  // wait for multiplier to signal completion
                    next_state = DONE;
                else
                    next_state = MULT;
            end
            DONE: begin
                if (start_mult)
                    next_state = LOAD;
                else
                    next_state = DONE;
            end
            default: next_state = IDLE;
        endcase
    end

    // output logic
    assign load_data = (state == LOAD);
    assign mult_active = (state == MULT);
    assign shift_en = (state == MULT);  // enable shifting during multiplication
    assign extend = (state == MULT);    // enable sign extension during multiplication

    // instantiate registers for initial values
    parallel_register #(.x(8)) multiplicand_reg (.clk(clk), .rst(rst), .load(load_data), .data_in(SW2), .q(multiplicand_out));
    parallel_register #(.x(8)) multiplier_reg (.clk(clk), .rst(rst), .load(load_data), .data_in(SW), .q(multiplier_out));

endmodule 