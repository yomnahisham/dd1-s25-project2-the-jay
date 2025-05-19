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


module fsm(input clk, rst, w, output z);
   reg [1:0] state, nextState;
   parameter [1:0] A=2'b00, B=2'b01, C=2'b10; // States Encoding
   // Next state generation (combinational logic)
   always @ (w or state)
       case (state)
           A: if (w==0) nextState = A;
               else nextState = B;
           B: if (w==0) nextState = A;
               else nextState = C;
           C: if(w==0)nextState = A;
               else nextState = C;
           default: nextState = A; // if we dont include default it will become sequen, because our num of states are < then the possible cases
       endcase
   // State register -- always the same we only change the next state logic and the output logic
   // Update state FF's with the triggering edge of the clock
   always @ (posedge clk or posedge rst) begin
       if(rst) state <= A;
       else state <= nextState;
   end
   // output generation (combinational logic)
   assign z = (state == B);
endmodule
