`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/21 18:44:55
// Design Name: 
// Module Name: myxor
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


module myxor(out,a,b);
    input a, b;
    output out;
	
	wire not_a, not_b, and_1, and_2;
    
	not not0(not_a, a);
	not not1(not_b, b);
	and and1(and_1, not_a, b);
	and and0(and_2, a, not_b);
	
	or or0(out, and_1, and_2);
endmodule