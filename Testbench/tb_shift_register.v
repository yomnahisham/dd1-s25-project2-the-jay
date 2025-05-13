module tb_shift_register();
    reg clk, reset, shift_en, shift_in, extend;
    wire [7:0] q;

    shift_register #(.x(8)) uut (.clk(clk), .rst(reset), .shift_en(shift_en), .shift_in(shift_in), .extend(extend), .q(q));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        shift_en = 0;
        shift_in = 0;
        extend = 0;
        
        repeat(2) @(posedge clk);
        reset = 0;
        @(posedge clk);
        
        shift_en = 1;
        
        // shift in pattern 8'b11001010 (LSB first)
        shift_in = 0; @(posedge clk);  // LSB
        shift_in = 1; @(posedge clk);
        shift_in = 0; @(posedge clk);
        shift_in = 1; @(posedge clk);
        shift_in = 0; @(posedge clk);
        shift_in = 0; @(posedge clk);
        shift_in = 1; @(posedge clk);
        shift_in = 1; @(posedge clk);  // MSB
        
        shift_en = 0;
        @(posedge clk);
        
        if (q !== 8'b11001010) begin
            $display("Time %t: Shift Register FAIL: expected 11001010, got %b", $time, q);
            $error("Test failed");
        end else begin
            $display("Time %t: Shift Register PASS: %b", $time, q);
        end

        //sign extension
        extend = 1;
        @(posedge clk); 
        @(posedge clk);  
        @(posedge clk);  
        extend = 0;
        
        repeat(2) @(posedge clk);
        $finish;
    end

    initial begin
        $monitor("Time %t: clk=%b reset=%b shift_en=%b shift_in=%b extend=%b q=%b",
                 $time, clk, reset, shift_en, shift_in, extend, q);
    end
endmodule