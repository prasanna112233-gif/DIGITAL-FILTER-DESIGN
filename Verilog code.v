module fir_filter (
    input clk,
    input reset,
    input signed [15:0] x_in,  // Input sample
    output reg signed [31:0] y_out  // Filtered output
);

    parameter N = 4;  // Number of taps
    reg signed [15:0] x_reg [0:N-1];  // Input sample shift register
    reg signed [15:0] coeff [0:N-1];  // Filter coefficients

    integer i;
    reg signed [31:0] acc;

    initial begin
        // Example low-pass filter coefficients
        coeff[0] = 16'sd2;
        coeff[1] = 16'sd4;
        coeff[2] = 16'sd4;
        coeff[3] = 16'sd2;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < N; i = i + 1)
                x_reg[i] <= 0;
            y_out <= 0;
        end else begin
            // Shift samples
            for (i = N-1; i > 0; i = i - 1)
                x_reg[i] <= x_reg[i-1];
            x_reg[0] <= x_in;

            // MAC operation
            acc = 0;
            for (i = 0; i < N; i = i + 1)
                acc = acc + x_reg[i] * coeff[i];
            y_out <= acc;
        end
    end

endmodule
