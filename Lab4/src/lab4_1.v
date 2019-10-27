`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/15 16:21:40
// Design Name: 
// Module Name: lab4_1
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


module lab4_1 (
input wire [15:0] SW,
input wire clk,
input wire reset,
output wire [3:0] DIGIT,
output wire [6:0] DISPLAY
);

	wire clk_d, reset_d;
	reg [3:0] value, DIGIT;
	wire [3:0] BCD0, BCD1, BCD2, BCD3;
	
	clock_divider #(.n(13)) c1(.clk(clk), .clk_div(clk_d));
	debounce dreset(.pb_debounced(reset_d), .pb(reset), .clk(clk_d));

	assign BCD0 = (reset_d == 1) ? 4'b0 : (SW[3:0] > 4'd9) ? 4'd9 : SW[3:0];
	assign BCD1 = (reset_d == 1) ? 4'b0 : (SW[7:4] > 4'd9) ? 4'd9 : SW[7:4];
	assign BCD2 = (reset_d == 1) ? 4'b0 : (SW[11:8] > 4'd9) ? 4'd9 : SW[11:8];
	assign BCD3 = (reset_d == 1) ? 4'b0 : (SW[15:12] > 4'd9) ? 4'd9 : SW[15:12];
	assign DISPLAY = (value == 4'd0) ? 7'b0000001 :
	                 (value == 4'd1) ? 7'b1001111 :
	                 (value == 4'd2) ? 7'b0010010 :
	                 (value == 4'd3) ? 7'b0000110 :
	                 (value == 4'd4) ? 7'b1001100 :
	                 (value == 4'd5) ? 7'b0100100 :
	                 (value == 4'd6) ? 7'b0100000 :
	                 (value == 4'd7) ? 7'b0001111 :
	                 (value == 4'd8) ? 7'b0000000 :
	                 (value == 4'd9) ? 7'b0000100 : 7'b0000001;

	always @(posedge clk_d) begin
		case (DIGIT)
		4'b1110: begin
			value = BCD1;
			DIGIT = 4'b1101;
		end
		4'b1101: begin
			value = BCD2;
			DIGIT = 4'b1011;
		end
		4'b1011: begin
			value = BCD3;
			DIGIT = 4'b0111;
		end
		4'b0111: begin
			value = BCD0;
			DIGIT = 4'b1110;
		end
		default: begin
			value = BCD0;
			DIGIT = 4'b1110;
		end
		endcase
	end

endmodule
