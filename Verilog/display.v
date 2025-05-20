`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 01:12:16 PM
// Design Name: 
// Module Name: display
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


module display(
    input r, l, clk, rst, clr,
    input [15:0] binary, 
    output [0:6] seg,
    output [3:0] an
); 

//get number in BCD
wire [19:0] BCD; 
wire sign; 
double_dabble d (binary, BCD, sign); 

////get 1 signal for each push of pushbuttons: 
//wire l, r; 
//push_button pr(clk, rst, right, r);
//push_button pl(clk, rst, left, l);

//counter to alternate anodes
wire clkout;
clkdivider #(250000) clk100hz(clk, rst, clkout);

wire done;
wire [1:0] count;
counter #(2, 4) bn2 (clkout, rst, 1'b1, count, done);

wire [3:0] ones, tens, hunds, thous, tenth; 
assign {tenth, thous, hunds, tens, ones} =  (rst) ? 0 : BCD; 

reg [3:0] dig0, dig1, dig2; 
// slide-window offset (sample on clkout, not clk)
reg [1:0] offset;
localparam MAX_OFF = 2'd2;

always @(posedge clkout or posedge rst) begin
  if (rst || clr) begin
    offset <= 2'd0;
    //{dig0, dig1, dig2} <= 0; 
  end else if (l && offset < MAX_OFF) begin
    offset <= offset + 1;
  end else if (r && offset > 0) begin
    offset <= offset - 1;
  end
end

always @(binary) begin
    if(rst) begin
        dig0 = 0; dig1 = 0; dig2 = 0;
    end
    case (offset)
        2'b00: begin dig0 = ones;  dig1 = tens;   dig2 = hunds;  end
        2'b01: begin dig0 = tens;  dig1 = hunds;  dig2 = thous;  end
        2'b10: begin dig0 = hunds; dig1 = thous;  dig2 = tenth;  end
        default: begin dig0 = 0; dig1 = 0; dig2 = 0; end
    endcase
end

//assign sign to 4 bit 
wire [4:0] s = (sign == 1) ? 15 : 14;


//manage display
reg [3:0] num; 
always @(posedge clkout) begin
    if (rst || clr)
        num <= 14;
  case (count)
      2'b11 : num <= s;
      2'b00 : num <= dig0;
      2'b01 : num <= dig1;
      2'b10 : num <= dig2;
  endcase
end
seven_seg display (rst, count, num, seg, an); 

endmodule 

