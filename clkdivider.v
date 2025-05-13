module clkdivider #(parameter n = 50000000)(
    input clk, rst, output reg clk_out)
;

reg [31:0] count;

always @ (posedge clk or posedge rst) begin
   if (rst) begin
       count <= 0;
       clk_out <= 0;
   end
   else begin
       if (count == n-1) begin
           count <= 0;
           clk_out <= ~clk_out;
       end
       else
           count <= count + 1;
   end
end
endmodule
