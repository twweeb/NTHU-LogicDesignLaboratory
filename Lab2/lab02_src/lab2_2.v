`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/29 18:10:18
// Design Name: 
// Module Name: lab2_2
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
	always@(negedge clk or negedge rst_n) begin
		if(rst_n==0)begin
			out <= init_out;
		end
		else begin
			out <= next_out;
		end
	end
endmodule

module gc_1_counter (clk, rst_n, en, dir, gray, cout);
	input clk, rst_n, dir, en;
	output [3:0] gray;
	output cout;
	
	wire [3:0] next_bin, bin;
	
	DFF #(4) DFF1(clk, 4'b0, next_bin, bin, rst_n);
	
	assign next_bin = (en == 0) ? bin : (dir == 1) ? bin + 4'b1 : bin - 4'b1;
	assign cout = (en == 1'b1 && dir == 1'b1 && bin == 4'b1111) ? 1'b1:
			      (en == 1'b1 && dir == 1'b0 && bin == 4'b0) ? 1'b1 : 1'b0 ;
	assign gray = {bin[3], bin[2:0] ^ bin[3:1]};
endmodule

module gc_2_counter (clk, rst_n, en, dir, gray, cout);
	input clk, rst_n, dir, en;
	output [7:0] gray;
	output cout;
	
	wire cout_1, cout_2;
	gc_1_counter g1(clk, rst_n, en, dir, gray[3:0], cout_1);
	gc_1_counter g2(clk, rst_n, cout_1, dir, gray[7:4], cout_2);
	assign cout = cout_1&&cout_2;
endmodule

module lab2_2(clk, rst_n, en, dir, gray, cout);
	input clk, rst_n, en, dir;
	output [7:0] gray;
	output cout;
	
	gc_2_counter gray_gen(clk, rst_n, en, dir, gray, cout);
endmodule
