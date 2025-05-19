`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 12:59:07 PM
// Design Name: 
// Module Name: fsm
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

module fsm (
    input clk, rst, y,
    output z
    );
    
    reg [1:0] state, nextState;
    
    parameter [1:0] A = 2'b00, B = 2'b01, C = 2'b10;
    
    always @ (y or state) begin
        case(state)
            A:
                if (y == 0) nextState = A;
                else nextState = B;
            B:
                if (y == 0) nextState = A;
                else nextState = C;
            C:
                if (y == 0) nextState = A;
                else nextState = C;
        endcase
    end
    
    always @ (posedge clk or posedge rst) begin
        if (rst) state <= A;
        else state <= nextState;
    end
    
    assign z = (state == B);
    
endmodule