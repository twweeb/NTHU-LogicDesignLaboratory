`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/07 01:29:18
// Design Name: 
// Module Name: clock_divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_divider(clk, clk_div);
	parameter n = 26;
	input clk;
	output clk_div;
	
	reg [n-1:0] cnt;
	wire [n-1:0] cnt_next;
	
	always@(posedge clk) begin
		cnt <= cnt_next;
	end
	
	assign cnt_next = cnt + 1'b1;
	assign clk_div = cnt[n-1];
endmodule