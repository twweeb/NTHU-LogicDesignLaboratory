module ClockDivider(clk, clk_r);
    parameter n = 13;

    input clk;
    output clk_r;
    reg[n - 1:0] cnt;

    always @(posedge clk) begin
        cnt <= cnt + 1;
    end

    assign clk_r = cnt[n - 1];

endmodule
