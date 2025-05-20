`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 12:52:35 PM
// Design Name: 
// Module Name: double_dabble
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


module double_dabble(
    input  signed [15:0] binary,     
    output reg [19:0] BCD,        
    output reg sign         
);
    integer i;
    reg [15:0] abs_val;
    reg [35:0] shift_reg; 

    always @(*) begin
        if (binary < 0) begin
            sign = 1;
            abs_val = -binary;
        end else begin
            sign = 0;
            abs_val = binary;
        end

        shift_reg = 36'd0;
        shift_reg[15:0] = abs_val;

        for (i = 0; i < 16; i = i + 1) begin
            if (shift_reg[19:16] >= 5)
                shift_reg[19:16] = shift_reg[19:16] + 3;
            if (shift_reg[23:20] >= 5)
                shift_reg[23:20] = shift_reg[23:20] + 3;
            if (shift_reg[27:24] >= 5)
                shift_reg[27:24] = shift_reg[27:24] + 3;
            if (shift_reg[31:28] >= 5)
                shift_reg[31:28] = shift_reg[31:28] + 3;
            if (shift_reg[35:32] >= 5)
                shift_reg[35:32] = shift_reg[35:32] + 3;

            shift_reg = shift_reg << 1;
        end


        BCD = shift_reg[35:16];
    end
endmodule

