`timescale 1ns/100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/21 20:54:55
// Design Name: 
// Module Name: lab1_2
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

module lab1_2 (a, b, c, aluctr, d, e);
	input a, b, c;
	input [1:0] aluctr;
	output d, e;
	
	assign d = (aluctr == 2'b00) ? a^(b^c) : 
			   (aluctr == 2'b01) ? a&b : 
			   (aluctr == 2'b10) ? !(a|b) : a^b;
	assign e = (aluctr == 2'b00) ? (a&b)|(b&c)|(a&c) : 0;

endmodule