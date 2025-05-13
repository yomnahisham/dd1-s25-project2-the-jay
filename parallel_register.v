module parallel_register #(parameter x = 4)(
  input clk, rst, load,
  input [x-1:0] data_in,
  output reg [x-1:0] q
);

always @(posedge clk or posedge rst) begin
  if(rst) q <= {x{1'b0}};
  else if (load) q <= data_in; 
end
endmodule