module debounce(clk,pb,pb_debounced);
input clk;
input pb;
output pb_debounced;

wire clk1;
    clock_divider #(13) clk_13(.clk(clk),.clk_div(clk1));

reg [3:0] shift_reg;

always @(posedge clk1) begin
    shift_reg[3:1] <= shift_reg[2:0];
    shift_reg[0] <= pb;
end

assign pb_debounced = ((shift_reg == 4'b1111) ? 1'b1 : 1'b0);

endmodule
