`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/07 02:12:32
// Design Name: 
// Module Name: lab03_1
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


module lab03_1(clk, rst, en, dir, led);
	input clk;
	input rst;
	input en;
	input dir;
	output[15:0] led;
	
	wire clk_d;
	reg [3:0] cnt;
	wire [3:0] cnt_next;
	reg [15:0]led;
	clock_divider c1(.clk(clk), .clk_div(clk_d));

	always@(posedge clk_d, posedge rst) begin 
		if(rst == 1) begin
			cnt = 15;
		end
		else if(en == 1) begin
			cnt = cnt_next;
		end
		else begin
			cnt = cnt;
		end
	end

	always@(posedge clk_d) begin
		led[15:0] = 15'b0;
		led[cnt] = 1'b1;
	end

	assign  cnt_next =  (dir) ? (cnt + 1'b1)%16 : (cnt - 1'b1)%16;
endmodule
