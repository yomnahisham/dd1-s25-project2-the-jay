module shift_register #(parameter x = 4)(
  input clk, rst, shift_en, shift_in, extend,
  output reg [x-1:0] q
);

always @(posedge clk or posedge rst) begin
  if(rst) q <= {x{1'b0}};
  else if (shift_en) q <= {shift_in, q[x-1:1]}; 
  else if (extend) q <= {q[x-1], q[x-1:1]};  // sign extension,repeat MSB
end
endmodule