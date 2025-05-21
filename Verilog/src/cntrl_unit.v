`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 05:03:32 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input  clk,           // system clock
    input  rst,           // reset signal
    input  clr,           // clear signal
    input  BTNC,          // center button (start multiplication)
    input  BTNL,          // left button (scroll left)
    input  BTNR,          // right button (scroll right)
    input loading_done, 
    output  reg load_data,    // signal to load data into registers
    input  start_mult,   // signal to start multiplication
    output  scroll_left,  // signal to scroll display left
    output  scroll_right,  // signal to scroll display right
    input  mult_done,    // signal indicating multiplication is complete
    output  mult_active,   // signal indicating multiplication is in progress
    output done
);

   
    // button processing
//   push_button btnc_inst (clk, rst, BTNC, start_mult);
    push_button btnl_inst (clk, rst, BTNL, scroll_left);
    push_button btnr_inst (clk, rst, BTNR, scroll_right);


    // state machine for control
    reg [2:0] state, next_state;
    parameter IDLE = 3'b000;
    parameter LOAD = 3'b001;
    parameter MULT = 3'b010;
    parameter DONE = 3'b011;

    // state register
    always @(posedge clk) 
        if (rst || clr)
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
            if (loading_done) next_state = MULT;
            else    next_state = LOAD;
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
    always @(*) begin
        load_data = (state == LOAD); 
    end
    
    assign mult_active = (state == MULT);
    assign extend = (state == MULT);    // enable sign extension during multiplication
    assign done = (state== DONE); 
endmodule 