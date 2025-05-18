module csa (
    input clk,
    input rst,
    input clr,
    input x,
    input y,
    output sum
);

reg d;

always@(posedge clk) begin
    if (rst || clr) begin
        sum <= 1'b0;
    end else begin
        sum <= d ^ y ^ x; // Sum = A XOR B XOR Cin
        d <=  ((y ^ d) & x) ^ (y & d); // Carry = (A AND B) OR (Cin AND (A XOR B))
        //d <= (x & y) ^ (x & d) ^ (y & d); // Carry = (A AND B) OR (Cin AND (A XOR B))
    end
end
    
endmodule