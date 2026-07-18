module clock_div(
    input clk,
    output reg clk25 = 0
);

always @(posedge clk)
    clk25 <= ~clk25;

endmodule