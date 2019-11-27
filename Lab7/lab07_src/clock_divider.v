`timescale 1ns / 1ps

module clock_divider(clk, clk_div);

parameter n = 25;

input clk;
output clk_div;

reg [n-1 : 0] counter;
wire [n-1 : 0]counter_next;

always@(posedge clk)
begin
  counter <= counter_next;
end

assign counter_next = counter + 1'b1;
assign clk_div = counter[n-1];

endmodule
