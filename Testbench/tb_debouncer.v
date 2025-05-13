module tb_debouncer();
    reg clk, rst, in;
    wire out;
    
    debouncer dut (.clk(clk), .rst(rst), .in(in), .out(out));
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end
    
    initial begin
        rst = 0;
        in = 0;
        
        #10;
        rst = 1;
        #20;
        if (out !== 0) begin
            $display("Test 1 Failed: Output should be 0 during reset");
            $finish;
        end
        rst = 0;
        #10;
        
        in = 1;
        #60; 
        if (out !== 1) begin
            $display("Test 2 Failed: Output should be 1 after 3 stable cycles");
            $finish;
        end
        
        in = 0;
        #20;
        if (out !== 0) begin
            $display("Test 3 Failed: Output should be 0 after initial low");
            $finish;
        end
        
        in = 1; 
        #10;
        in = 0; 
        #10;
        in = 1; 
        #10;
        in = 0; 
        #10;
        in = 1; 

        #60;
        if (out !== 1) begin
            $display("Test 3 Failed: Output should be 1 after stable high");
            $finish;
        end

        in = 0;
        #60; 
        if (out !== 0) begin
            $display("Test 4 Failed: Output should be 0 after stable low");
            $finish;
        end
        
        in = 1;
        #60;
        if (out !== 1) begin
            $display("Test 4 Failed: Output should be 1 after stable high");
            $finish;
        end
        
        in = 1;
        #30;
        rst = 1;
        #10;
        if (out !== 0) begin
            $display("Test 5 Failed: Output should be 0 during reset");
            $finish;
        end
        
        $display("All tests passed successfully!");
        $finish;
    end
    
endmodule