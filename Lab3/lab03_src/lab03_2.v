`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/07 20:15:03
// Design Name: 
// Module Name: lab03_2
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


module lab03_2(clk, rst, en, dir, led);
	input clk;
	input rst;
	input en;
	input dir;
	output[15:0] led;
	
	wire clk_fast, clk_slow, mr1_clk, mr3_clk;
	reg [3:0] mr1, mr3;
	wire [3:0] mr1_next, mr3_next;
	reg [15:0]led;
	
	clock_divider #(.n(26)) c1(.clk(clk), .clk_div(clk_slow));
	clock_divider #(.n(23)) c2(.clk(clk), .clk_div(clk_fast));

	always@(*) begin 
		led[15:0] = 16'b0;
		led[mr1] = 1'b1;
		led[(mr3 + 1'b1)%16] = 1'b1;
		led[(mr3 - 1'b1)%16] = 1'b1;
		led[mr3] = 1'b1;
	end

	assign mr1_next = (dir) ? (mr1 + 1'b1)%16 : (mr1 - 1'b1)%16;
	assign mr3_next = (dir) ? (mr3 + 1'b1)%16 : (mr3 - 1'b1)%16;
	assign mr1_clk  = (dir) ? clk_slow : clk_fast;
	assign mr3_clk  = (dir) ? clk_fast : clk_slow;
	
	always@(posedge mr1_clk, posedge rst) begin
		if(rst == 1) begin
			mr1 = 15;
		end
		else if(en == 1) begin
			mr1 = mr1_next;
		end
		else begin
			mr1 = mr1;
		end
	end
	
	always@(posedge mr3_clk, posedge rst) begin
		if(rst == 1) begin
			mr3 = 14;
		end
		else if(en == 1) begin
			mr3 = mr3_next;
		end
		else begin
			mr3 = mr3;
		end
	end
endmodule