module tb_parallel_register();
    reg clk, reset, load;
    reg [7:0] data_in;
    wire [7:0] q;
 
    parallel_register #(.x(8)) uut (.clk(clk), .rst(reset), .load(load), .data_in(data_in), .q(q));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1; load = 0; data_in = 8'b00000000;
        #20;
        reset = 0;

        data_in = 8'b10110110;
        load = 1;
        #10;
        load = 0;
        #10;
        if (q !== 8'b10110110) begin
            $error("Parallel Load FAIL: expected 10110110, got %b", q);
        end else begin
            $display("Parallel Load PASS: %b", q);
        end

        data_in = 8'b01010101;
        #20;
        if (q !== 8'b10110110) begin
            $error("Hold FAIL: q should remain 10110110, got %b", q);
        end else begin
            $display("Hold PASS: %b remains unchanged", q);
        end

        $finish;
    end

    initial begin
        $monitor("Time %t: clk=%b reset=%b load=%b data_in=%b q=%b",
                 $time, clk, reset, load, data_in, q);
    end
endmodule 