`timescale 1ns/100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/22 00:05:02
// Design Name: 
// Module Name: lab1_b1
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

module lab1_b1 (a, b, c, aluctr, d, e);
    parameter n = 1;
	input [n-1:0] a, b;
	input c;
	input [1:0] aluctr;
	output reg [n-1:0] d;
	output reg e;
	
	wire comp_e;
	assign comp_e = (a>b)? 1 : (a<b)? 0 : (c == 0) ? 0 : 1;
	
    always@(*)begin
        case(aluctr)
			2'b00:begin
				{e, d} = a + b + c;
			end
			2'b01:begin
				d = a&b;
				e = 0;
			end
			2'b10:begin
				d = 0;
				e = comp_e;
			end
			2'b11:begin
				d = a^b;
				e = 0;
			end
        endcase
    end
endmodule