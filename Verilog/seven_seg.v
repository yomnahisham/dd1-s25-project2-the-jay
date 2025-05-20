`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 12:56:20 PM
// Design Name: 
// Module Name: seven_seg
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


// seven_seg.v
module seven_seg(
    input rst,
    input  [1:0] en,
    input  [3:0] num,
    output reg [0:6] segments,
    output reg [3:0] anode_active
);
    always @(*) begin
        if(rst)
            segments =  7'b0000001;
        else case (num)
            4'd0: segments = 7'b0000001;
            4'd1: segments = 7'b1001111;
            4'd2: segments = 7'b0010010;
            4'd3: segments = 7'b0000110;
            4'd4: segments = 7'b1001100;
            4'd5: segments = 7'b0100100;
            4'd6: segments = 7'b0100000;
            4'd7: segments = 7'b0001111;
            4'd8: segments = 7'b0000000;
            4'd9: segments = 7'b0001100;
            4'd14: segments = 7'b1111111; // blank for "+"
            4'd15: segments = 7'b1111110; // minus sign
            default: segments = 7'b1111111;
        endcase

        case (en)
            2'b00: anode_active = 4'b1110;
            2'b01: anode_active = 4'b1101;
            2'b10: anode_active = 4'b1011;
            2'b11: anode_active = 4'b0111;
            default: anode_active = 4'b1111;
        endcase
    end
endmodule
