module sync (
    input SIG, CLK, 
    output SIG1);
reg SIG1, META;
always @ (posedge CLK) begin
    META <= SIG;
    SIG1 <= META;
end
endmodule