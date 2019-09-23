`timescale 1ns/100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/21 21:08:54
// Design Name: 
// Module Name: lab1_3
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

module lab1_3 (a, b, c, aluctr, d, e);
	input a, b, c;
	input [1:0] aluctr;
	output reg d, e;
	
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
				d = !(a|b);
				e = 0;
			end
			2'b11:begin
				d = a^b;
				e = 0;
			end
        endcase
    end
endmodule