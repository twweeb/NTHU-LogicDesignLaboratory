`timescale 1ns/100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/22 00:39:51
// Design Name: 
// Module Name: lab1_b2
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

module lab1_b2 (a, b, c, aluctr, d, e);
	input [3:0] a,b;
	input [1:0] aluctr;
	input c;
	output reg [3:0] d;
	output reg e;
	
	wire[3:0] d0,d1,d2,d3;
	wire e0,e1,e2,e3;
	
	lab1_b1 #(4) m0(a, b, c, aluctr, d0, e0);
	lab1_b1 #(4) m1(a, b, e0, aluctr, d1, e1);
	lab1_b1 #(4) m2(a, b, e1, aluctr, d2, e2);
	lab1_b1 #(4) m3(a, b, e2, aluctr, d3, e3);
	
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
