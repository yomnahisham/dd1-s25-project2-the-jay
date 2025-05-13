module counter #(parameter bits = 4, parameter max_count = 15)(
    input wire clk,           // Clock input
    input wire rst,           // Reset input
    input wire en,            // Enable input
    output reg [bits-1:0] count,  // Counter output
    output wire done          // Done signal when max count reached
);

    // Counter logic
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= {bits{1'b0}};
        else if (en) begin
            if (count == max_count)
                count <= {bits{1'b0}};
            else
                count <= count + 1'b1;
        end
    end

    // Done signal when max count reached
    assign done = (count == max_count);

endmodule 