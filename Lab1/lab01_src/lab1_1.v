`timescale 1ns/100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/21 19:15:33
// Design Name: 
// Module Name: lab1_1
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
	wire and0, and1, and2, xor0;
	
	and and_0(and0, a, b);
	and and_1(and1, b, c);
	and and_2(and2, a, c);
	myxor myxor_0(xor0, b, c);
	or or_0(e, and0, and1, and2);
	myxor myxor_1(d, a, xor0);
endmodule

module my_and (e, d, a, b, c);
	input a, b, c;
	output e, d;

	and and_0(d, a, b);
	assign e = 0;
endmodule

module my_nor (e, d, a, b, c);
	input a, b, c;
	output e, d;

	wire or0;
	or or_0(or0, a, b);
	not not_0(d, or0);
	assign e = 0;
endmodule

module my_xor (e, d, a, b, c);
	input a, b, c;
	output e, d;

	myxor myxor0(d, a, b);
	assign e = 0;
endmodule

module lab1_1 (a, b, c, aluctr, d, e);
	input a, b, c;
	input [1:0] aluctr;
	output d, e;
	
	wire d0,d1,d2,d3,e0,e1,e2,e3;

	my_add	m0(e0, d0, a, b, c);
	my_and	m1(e1, d1, a, b, c);
	my_nor	m2(e2, d2, a, b, c);
	my_xor	m3(e3, d3, a, b, c);
	
	mux4_to_1 mux0(d, d0, d1, d2, d3, aluctr);
	mux4_to_1 mux1(e, e0, e1, e2, e3, aluctr);

endmodule