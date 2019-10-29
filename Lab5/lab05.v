`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/28 00:01:55
// Design Name: 
// Module Name: lab05
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

`define INIT 2'b00
`define DEPOSIT 2'b01
`define BUY 2'b10
`define CHANGE 2'b11

module lab05(clk, rst, money_5, money_10, cancel, drink_A, drink_B, drop_money, enough_A, enough_B, DIGIT, DISPLAY);
	input clk;
	input rst;
	input money_5;
	input money_10;
	input cancel;
	input drink_A;
	input drink_B;
	output reg[9:0] drop_money;
	output reg enough_A;
	output reg enough_B;
	output [3:0] DIGIT;
	output [6:0] DISPLAY;
	
	wire clk_display, clk_button, clk_d, clk_used,
	     cancel_d, money_10_d, money_5_d, drink_A_d, drink_B_d,
	     cancel_1pulse, money_10_1pulse, money_5_1pulse, drink_A_1pulse, drink_B_1pulse,
		 en, en_wait, done, done_wait;
	reg [9:0] drop_money_next;
	reg [7:0] A_c, A_c_next, B_c, B_c_next, money_in, money_in_next;
	reg [1:0] state, next_state;
	reg [3:0] value, DIGIT, D0, D1, D2, D3,
	          D0_next, D1_next, D2_next, D3_next;
	reg enough_A_next, enough_B_next;
	
	clock_divider #(.n(26)) c26(.clk(clk), .clk_div(clk_display));
	clock_divider #(.n(16)) c16(.clk(clk), .clk_div(clk_button));
	clock_divider #(.n(13)) c13(.clk(clk), .clk_div(clk_d)); 
	
	debounce dcancel(.pb_debounced(cancel_d), .pb(cancel), .clk(clk_button));
	debounce dmoney_10(.pb_debounced(money_10_d), .pb(money_10), .clk(clk_button));
	debounce dmoney_5(.pb_debounced(money_5_d), .pb(money_5), .clk(clk_button));
	debounce dA(.pb_debounced(drink_A_d), .pb(drink_A), .clk(clk_button));
	debounce dB(.pb_debounced(drink_B_d), .pb(drink_B), .clk(clk_button));

	onepulse ocancel(.rst(rst), .clk(clk_button), .pb_debounced(cancel_d), .pb_1pulse(cancel_1pulse));
	onepulse omoney_10(.rst(rst), .clk(clk_button), .pb_debounced(money_10_d), .pb_1pulse(money_10_1pulse));
	onepulse omoney_5(.rst(rst), .clk(clk_button), .pb_debounced(money_5_d), .pb_1pulse(money_5_1pulse));
	onepulse oA(.rst(rst), .clk(clk_button), .pb_debounced(drink_A_d), .pb_1pulse(drink_A_1pulse));
	onepulse oB(.rst(rst), .clk(clk_button), .pb_debounced(drink_B_d), .pb_1pulse(drink_B_1pulse));
	
	counter #(.n(26)) display_cnt(clk, en, done);
	counter #(.n(29)) wait_cnt(clk, en_wait, done_wait);

	assign clk_used = (state == `DEPOSIT) ? clk_button : clk_display;
	assign en_wait = (state == `DEPOSIT) ? 
	                 (~money_5_1pulse && ~money_10_1pulse && ~drink_A_1pulse && ~drink_B_1pulse) ? 1 : 0 : 0;
	assign en = (state == `BUY) ? 1 : 0 ;
	assign DISPLAY = (value == 4'd0) ? 7'b0000001 :
					 (value == 4'd1) ? 7'b1001111 :
					 (value == 4'd2) ? 7'b0010010 :
					 (value == 4'd3) ? 7'b0000110 :
					 (value == 4'd4) ? 7'b1001100 :
					 (value == 4'd5) ? 7'b0100100 :
					 (value == 4'd6) ? 7'b0100000 :
					 (value == 4'd7) ? 7'b0001111 :
					 (value == 4'd8) ? 7'b0000000 :
					 (value == 4'd9) ? 7'b0000100 :
					 (value == 4'd10) ? 7'b1110010 : // c
					 (value == 4'd11) ? 7'b1100010 : // o
					 (value == 4'd12) ? 7'b0000010 : // a
					 (value == 4'd13) ? 7'b1100000 : // b
					 (value == 4'd14) ? 7'b0110000 : // e
					 (value == 4'd15) ? 7'b1111010 : // r
					 7'b0000001;
	//cock, beer
	always@(*)begin
		case(state)
			`INIT: begin
				drop_money_next = drop_money;
				money_in_next = 0;
				A_c_next = 8'd0;
				B_c_next = 8'd0;
				enough_A_next=0;
				enough_B_next=0;
				D0_next = D0;
				D1_next = D1;
				D2_next = D2;
				D3_next = D3;
				next_state = `DEPOSIT;
			end
			
			`DEPOSIT: begin
				money_in_next = money_in;
				A_c_next = A_c;
				B_c_next = B_c;
				enough_A_next=0;
				enough_B_next=0;
				drop_money_next = 10'b0000000000;
				
				if (money_5_1pulse == 1 && money_in <= 8'd90) money_in_next = money_in + 8'd5;
				else if (money_10_1pulse == 1 && money_in <= 8'd85) money_in_next = money_in + 8'd10;
				
				if (money_in >= 20) enough_A_next = 1;
				if (money_in >= 25) enough_B_next = 1;

				if (drink_A_1pulse == 1) begin
					A_c_next = 8'd1;
					B_c_next = 8'd0;
					D0_next = 4'd10; // c
					D1_next = 4'd11; // o
					D2_next = 4'd10; // c
					D3_next = 4'd12; // a
				end
				else if (drink_B_1pulse == 1) begin
					A_c_next = 8'd0;
					B_c_next = 8'd1;
					D0_next = 4'd13; // b
					D1_next = 4'd14; // e
					D2_next = 4'd14; // e
					D3_next = 4'd15; // r
				end

				if (done_wait == 1) next_state = `CHANGE;
				else if (cancel_1pulse) next_state = `CHANGE;
				else if (drink_A_1pulse == 1 && A_c == 1 && enough_A == 1) next_state = `BUY;
				else if (drink_B_1pulse == 1 && B_c == 1 && enough_B == 1) next_state = `BUY;
				else next_state = `DEPOSIT;
			end
			
			`BUY: begin
				money_in_next = money_in - (A_c*20 + B_c*25);
				A_c_next = 0;
				B_c_next = 0;
				enough_A_next = 0;
				enough_B_next = 0;
				D0_next = D0;
				D1_next = D1;
				D2_next = D2;
				D3_next = D3;
				if(done == 1) next_state = `CHANGE;
				else next_state = `BUY;
				drop_money_next = 10'b0000000000;
			end
			
			`CHANGE: begin
				D0_next = 4'd0;
				D1_next = 4'd0;
				D2_next = 4'd0;
				D3_next = 4'd0;
				enough_A_next = 0;
				enough_B_next = 0;
				money_in_next = money_in;
				A_c_next = 0;
				B_c_next = 0;
				if(money_in > 0) begin
					if(money_in >= 8'd10) begin
						money_in_next = money_in - 8'd10;
						drop_money_next = 10'b1111111111;
						if(money_in_next == 0) next_state = `INIT;
						else next_state = `CHANGE;
					end
					else if(money_in >= 8'd5) begin
						money_in_next = money_in-8'd5;
						drop_money_next = 10'b1111100000;
						if(money_in_next == 0) next_state = `INIT;
						else next_state = `CHANGE;
					end
				end
				else begin
					money_in_next = 0;
					drop_money_next = 10'b0000000000;
					next_state = `INIT;
				end
			end
			
			default: begin
				next_state = `INIT;
				A_c_next = 0;
				B_c_next = 0;
				enough_A_next=0;
				enough_B_next=0;
				money_in_next=0;
				drop_money_next = 10'b0000000000;
				D0_next = 0;
				D1_next = 0;
				D2_next = 0;
				D3_next = 0;
			end
		endcase
	end

	always@(posedge clk_used, posedge rst) begin
		if(rst==1) begin
			state <= `DEPOSIT;
			money_in <= 0;	//the money that was put in
			A_c <= 8'd0;
			B_c <= 8'd0;
			enough_A <= 0;
			enough_B <= 0;
			drop_money <= 10'b0000000000;
			D0 <= 0;
			D1 <= 0;
			D2 <= 0;
			D3 <= 0;
		end
		else begin
			state <= next_state;
			money_in <= money_in_next;
			A_c <= A_c_next;
			B_c <= B_c_next;
			enough_A <= enough_A_next;
			enough_B <= enough_B_next;
			drop_money <= drop_money_next;
			D0 <= D0_next;
			D1 <= D1_next;
			D2 <= D2_next;
			D3 <= D3_next;
		end
	end

	always @(posedge clk_d) begin
		case(DIGIT)
		4'b1110: begin
			value = (state == `BUY) ? D2 : money_in/8'd10;
			DIGIT = 4'b1101;
		end
		4'b1101: begin
			value = (state == `BUY) ? D1 : (A_c*20 + B_c*25)%8'd10;
			DIGIT = 4'b1011;
		end
		4'b1011: begin
			value =  (state == `BUY) ? D0 : (A_c*20 + B_c*25)/8'd10;
			DIGIT = 4'b0111;
		end
		4'b0111: begin
			value =  (state == `BUY) ? D3 : money_in%8'd10;
			DIGIT = 4'b1110;
		end
		default: begin
			value = 8'd10;
			DIGIT = 4'b1110;
		end
		endcase
	end
endmodule

module clock_divider(clk, clk_div);
	parameter n = 26;
	input clk;
	output clk_div;
	
	reg [n-1:0] cnt;
	wire [n-1:0] cnt_next;
	
	always@(posedge clk) begin
		cnt <= cnt_next;
	end
	
	assign cnt_next = cnt + 1'b1;
	assign clk_div = cnt[n-1];
endmodule

module debounce(pb_debounced, pb, clk);
	output pb_debounced;
	input pb;
	input clk;

	reg [3:0] shift_reg;

	always@(posedge clk)
	begin
		shift_reg[3:0] = {shift_reg[2:0], pb};
	end

	assign pb_debounced = ((shift_reg == 4'b1111) ? 1'b1 : 1'b0);
endmodule

module onepulse(
input wire rst,
input wire clk,
input wire pb_debounced,
output reg pb_1pulse);
	reg pb_1pulse_next;
	reg pb_debounced_delay;

	always@* begin
		pb_1pulse_next = pb_debounced & ~pb_debounced_delay;
	end

	always @(posedge clk, posedge rst) begin
		if(rst == 1'b1) begin
			pb_1pulse <= 1'b0;
			pb_debounced_delay <= 1'b0;
		end
		else begin
			pb_1pulse <= pb_1pulse_next;
			pb_debounced_delay <= pb_debounced;
		end 
	end
endmodule

module counter(clk, en, done);
	parameter n = 26;
	input clk, en;
	output done;
	
	reg [n:0] cnt;
	wire [n:0] cnt_next;
	
	always@(posedge clk) begin
		if(en == 1) cnt <= cnt_next;
		else cnt <= 0;
	end
	
	assign cnt_next = cnt + 1'b1;
	assign done = cnt[n];
endmodule