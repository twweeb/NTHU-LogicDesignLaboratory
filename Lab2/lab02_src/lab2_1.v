`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/28 21:25:39
// Design Name: 
// Module Name: lab2_1
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

module DFF (clk, init_out, next_out, out, rst_n);
	parameter n = 1;
	input clk,rst_n;
	input [n-1:0] next_out,init_out;
	output reg [n-1:0] out;
	always@(posedge clk, negedge rst_n) begin
		if(rst_n==0)begin
			out <= init_out;
		end
		else begin
			out <= next_out;
		end
	end
endmodule

module lab2_1(clk, rst_n, en, dir, in, data, out);
	input clk, rst_n, en, dir, in;
	input [3:0] data;
	output [3:0] out;
	
	wire [3:0]next_out;

	DFF #(4) DFF1(clk, 4'b0, next_out, out, rst_n);
	assign next_out = (en == 0) ? out : (in == 0) ? (dir == 1) ? out + 1'b1 : out - 1'b1 : data;
endmodule
