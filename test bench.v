module tb_fir_filter;

    reg clk = 0;
    reg reset;
    reg signed [15:0] x_in;
    wire signed [31:0] y_out;

    fir_filter uut (.clk(clk), .reset(reset), .x_in(x_in), .y_out(y_out));

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("fir_filter.vcd");
        $dumpvars(0, tb_fir_filter);

        reset = 1;
        x_in = 0;
        #10 reset = 0;

        // Apply input samples (impulse response)
        x_in = 16'sd1; #10;
        x_in = 16'sd0; #10;
        x_in = 16'sd0; #10;
        x_in = 16'sd0; #10;
        x_in = 16'sd0; #10;
        x_in = 16'sd0; #50;

        $finish;
    end

endmodule
