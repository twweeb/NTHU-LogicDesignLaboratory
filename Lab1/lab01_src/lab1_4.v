`timescale 1ns/100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/21 22:23:04
// Design Name: 
// Module Name: lab1_4
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

module four_bit_adder (d, e, a, b, c);
	input [3:0] a,b;
	input c;
	output [3:0] d;
	output e;
	
	wire t1, t2, t3;
	lab1_3 o1(a[0], b[0], c, 2'b00, d[0], t1);
	lab1_3 o2(a[1], b[1], t1, 2'b00, d[1], t2);
	lab1_3 o3(a[2], b[2], t2, 2'b00, d[2], t3);
	lab1_3 o4(a[3], b[3], t3, 2'b00, d[3], e);
endmodule

module four_bit_and (d, e, a, b, c);
	input [3:0] a,b;
	input c;
	output [3:0] d;
	output e;
	
	lab1_3 o1(a[0], b[0], c, 2'b01, d[0], e);
	lab1_3 o2(a[1], b[1], c, 2'b01, d[1], e);
	lab1_3 o3(a[2], b[2], c, 2'b01, d[2], e);
	lab1_3 o4(a[3], b[3], c, 2'b01, d[3], e);
endmodule

module four_bit_nor (d, e, a, b, c);
	input [3:0] a,b;
	input c;
	output [3:0] d;
	output e;
	
	lab1_3 o1(a[0], b[0], c, 2'b10, d[0], e);
	lab1_3 o2(a[1], b[1], c, 2'b10, d[1], e);
	lab1_3 o3(a[2], b[2], c, 2'b10, d[2], e);
	lab1_3 o4(a[3], b[3], c, 2'b10, d[3], e);
endmodule

module four_bit_xor (d, e, a, b, c);
	input [3:0] a,b;
	input c;
	output [3:0] d;
	output e;
	
	lab1_3 o1(a[0], b[0], c, 2'b11, d[0], e);
	lab1_3 o2(a[1], b[1], c, 2'b11, d[1], e);
	lab1_3 o3(a[2], b[2], c, 2'b11, d[2], e);
	lab1_3 o4(a[3], b[3], c, 2'b11, d[3], e);
endmodule

module lab1_4 (a, b, c, aluctr, d, e);
	input [3:0] a,b;
	input [1:0] aluctr;
	input c;
	output reg [3:0] d;
	output reg e;
	
	wire[3:0] d0,d1,d2,d3;
	wire e0,e1,e2,e3;
	
	four_bit_adder m0(d0, e0, a, b, c);
	four_bit_and m1(d1, e1, a, b, c);
	four_bit_nor m2(d2, e2, a, b, c);
	four_bit_xor m3(d3, e3, a, b, c);
	
    always@(*)begin
        case(aluctr)
			2'b00:begin
				e = e0;
				d = d0;
			end
			2'b01:begin
				e = e1;
				d = d1;
			end
			2'b10:begin
				e = e2;
				d = d2;
			end
			2'b11:begin
				e = e3;
				d = d3;
			end
        endcase
    end
endmodule