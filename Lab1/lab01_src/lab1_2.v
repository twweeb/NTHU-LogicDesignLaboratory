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

module my_add (e, d, a, b, c);
	input a, b, c;
	output e, d;

	assign e = (a&b)|(b&c)|(a&c);
	assign d = a^(b^c);
endmodule

module my_and (e, d, a, b, c);
	input a, b, c;
	output e, d;

	assign d = a&b;
	assign e = 0;
endmodule

module my_nor (e, d, a, b, c);
	input a, b, c;
	output e, d;

	assign d = !(a|b);
	assign e = 0;
endmodule

module my_xor (e, d, a, b, c);
	input a, b, c;
	output e, d;

	assign d = a^b;
	assign e = 0;
endmodule

module lab1_2 (a, b, c, aluctr, d, e);
	input a, b, c;
	input [1:0] aluctr;
	output d, e;
	
	wire d0,d1,d2,d3,e0,e1,e2,e3;

	my_add	m0(e0, d0, a, b, c);
	my_and	m1(e1, d1, a, b, c);
	my_nor	m2(e2, d2, a, b, c);
	my_xor	m3(e3, d3, a, b, c);
	
	assign d = (aluctr == 2'b00) ? d0 : (aluctr == 2'b01) ? d1 : (aluctr == 2'b10) ? d2 : d3;
	assign e = (aluctr == 2'b00) ? e0 : (aluctr == 2'b01) ? e1 : (aluctr == 2'b10) ? e2 : e3;

endmodule