`timescale 1ns / 1ps
module LFSR(random, clk, rst);
	input clk;
	input rst;
	output [3:0] random;
	reg [3:0] random;
	
	always @(posedge clk or posedge rst) begin
		if (rst == 1'b1) random[3:0] <= 4'b1000;
		else begin
			random[2:0] <= random[3:1];
			random[3] <= random[1] ^ random[0];
		end
	end
endmodule