`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/07 22:29:48
// Design Name: 
// Module Name: lab03_3
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

module lab03_3(clk, rst, en, led);
	input clk;
	input rst;
	input en;
	output[15:0] led;
	
	wire mr1_clk, mr3_clk;
	reg [3:0] mr1, mr3;
	wire [3:0] mr1_next, mr3_next;
	reg [15:0]led;
	reg dir;
	wire [1:0]state,next_state;
	reg [1:0]next_state1;
	
	clock_divider #(.n(23)) c1(.clk(clk), .clk_div(mr1_clk));
	clock_divider #(.n(26)) c2(.clk(clk), .clk_div(mr3_clk));
	
	always@(*) begin 
		led[15:0] = 16'b0;
		led[mr1] = 1'b1;
		led[(mr3 + 1'b1)%16] = 1'b1;
		led[(mr3 - 1'b1)%16] = 1'b1;
		led[mr3] = 1'b1;
	end
	
	assign mr1_next = (dir) ? (mr1 + 1'b1)%16 : (mr1 - 1'b1)%16;
	assign mr3_next = (mr3 - 1'b1)%16;
	assign dir_next = (dir == 1 && (mr1 + 1'b1)%16 == (mr3 - 1'b1)%16) ? ~dir : 
	                  (dir == 0 && (mr1 - 1'b1)%16 == (mr3 + 1'b1)%16) ? ~dir : 
					  (dir == 1 && (mr1 + 1'b1)%16 == mr3) ? ~dir : dir;

	always@(posedge mr1_clk, posedge rst) begin 
		if(rst == 1) begin
			mr1 = 15;
			dir = 1;
		end
		else if(en == 1) begin
			mr1 = mr1_next;
			dir = dir_next;
		end
		else begin
			mr1 = mr1;
			dir = dir;
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