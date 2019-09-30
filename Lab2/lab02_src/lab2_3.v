`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/30 03:15:37
// Design Name: 
// Module Name: lab2_3
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
	always@(posedge clk or negedge rst_n) begin
		if(rst_n==0)begin
			out <= init_out;
		end
		else begin
			out <= next_out;
		end
	end
endmodule

module lab2_3 (clk, rst_n, out);
	input clk, rst_n;
	output out;
	wire [5:0] F;
	
	DFF #(1) DFF0(clk, 1'b1, F[5]^F[0], F[0] ,rst_n);
	DFF #(1) DFF1(clk, 1'b0, F[0], F[1] ,rst_n);
	DFF #(1) DFF2(clk, 1'b0, F[1], F[2] ,rst_n);
	DFF #(1) DFF3(clk, 1'b0, F[2], F[3] ,rst_n);
	DFF #(1) DFF4(clk, 1'b0, F[3], F[4] ,rst_n);
	DFF #(1) DFF5(clk, 1'b0, F[4], F[5] ,rst_n);
	
	assign out = F[5];
endmodule
