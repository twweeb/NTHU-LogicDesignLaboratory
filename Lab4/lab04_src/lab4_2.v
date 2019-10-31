`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/18 22:21:54
// Design Name: 
// Module Name: lab4_2
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

`define INIT 3'b000
`define COUNTUP 3'b001
`define COUNTDOWN 3'b010
`define PAUSEUP 3'b011
`define PAUSEDOWN 3'b100

module lab4_2 (
input wire en,
input wire reset,
input wire clk,
input wire dir,
input wire record,
output wire [3:0] DIGIT,
output wire [6:0] DISPLAY,
output wire max,
output wire min
);

	wire clk_count, clk_d, clk_fsm, 
	     dir_d, en_d , reset_d, record_d, out,
		 record_1pulse, en_1pulse, dir_1pulse, 
		 en_counter, dir_now;
	wire [2:0] next_state;
	wire [3:0] BCD0, BCD1;

	reg en_counter1, dir_now1;
	reg [2:0] state, next_state1;
	reg [3:0] value, DIGIT, BCD2, BCD3;

	clock_divider #(.n(25)) c25(.clk(clk), .clk_div(clk_count));
	clock_divider #(.n(23)) c23(.clk(clk), .clk_div(clk_fsm));
	clock_divider #(.n(13)) c13(.clk(clk), .clk_div(clk_d)); 

	debounce den(.pb_debounced(en_d), .pb(en), .clk(clk_d));
	debounce dreset(.pb_debounced(reset_d), .pb(reset), .clk(clk_d));
	debounce ddir(.pb_debounced(dir_d), .pb(dir), .clk(clk_d));
	debounce drecord(.pb_debounced(record_d), .pb(record), .clk(clk_d));
	
	onepulse orecord(.rst(reset_d), .clk(clk_fsm), .pb_debounced(record_d), .pb_1pulse(record_1pulse));
	onepulse oen(.rst(reset_d), .clk(clk_fsm), .pb_debounced(en_d), .pb_1pulse(en_1pulse));
	onepulse odir(.rst(reset_d), .clk(clk_fsm), .pb_debounced(dir_d), .pb_1pulse(dir_1pulse));
	TwoDigitBCDCounter c0(.clk(clk_count), .reset(reset_d), .en(en_counter), .dir(dir_now), .BCD0(BCD0), .BCD1(BCD1), .cout(out));

	assign en_counter = (reset_d==1) ? 0 :
						(state == `COUNTUP && BCD0 == 9 && BCD1 == 9) ? 0 :
						(state == `COUNTDOWN && BCD0 == 0 && BCD1 == 0) ? 0 : en_counter1;
	assign dir_now = (reset_d==1) ? 1 : dir_now1;
	assign max = (state != `INIT && BCD0==9 && BCD1==9 && dir_now == 1) ? 1 : 0;
	assign min = (state != `INIT && BCD0==0 && BCD1==0 && dir_now == 0) ? 1 : 0;
	assign next_state = (reset_d == 1) ? `INIT : next_state1;
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
	always@(*)begin
		case(state)
			`INIT: next_state1 = (en_1pulse == 1) ? `COUNTUP: `INIT; 
			`COUNTUP: next_state1 = (en_1pulse == 1) ? `PAUSEUP : (dir_1pulse == 1) ? `COUNTDOWN : `COUNTUP;
			`COUNTDOWN: next_state1 = (en_1pulse == 1) ? `PAUSEDOWN : (dir_1pulse == 1) ? `COUNTUP : `COUNTDOWN;
			`PAUSEUP:  next_state1 = (en_1pulse == 1) ? `COUNTUP : (dir_1pulse == 1) ? `PAUSEDOWN :  `PAUSEUP;
			`PAUSEDOWN:  next_state1 = (en_1pulse == 1) ? `COUNTDOWN : (dir_1pulse == 1) ? `PAUSEUP :  `PAUSEDOWN;
			default: next_state1 = `INIT;
		endcase
	end

	always@(*)begin
		case(state)
			`INIT: begin 
				en_counter1 = 0;
				dir_now1 = 1;
			end
			`COUNTUP: begin
				en_counter1 = 1;
				dir_now1 = 1;
			end
			`COUNTDOWN: begin
				en_counter1 = 1;
				dir_now1 = 0;
			end
			`PAUSEUP: begin
				en_counter1 = 0;
				dir_now1 = 1;
			end
			`PAUSEDOWN: begin
				en_counter1 = 0;
				dir_now1 = 0;
			end
			default:  begin 
				en_counter1 = 0;
				dir_now1 = 1;
			end
		endcase
	end

	always@(posedge clk_fsm, posedge reset_d)
	begin
		if(reset_d==1) begin
			state = `INIT;
		end
		else begin
			state = next_state1;
		end
	end
	
	always@(posedge record_1pulse, posedge reset_d) begin 
		if(reset_d == 1) begin
			BCD2 = 4'b0;
			BCD3 = 4'b0;
		end
		else begin
			BCD2 = BCD0;
			BCD3 = BCD1;
		end
	end

	always @(posedge clk_d) begin
		case(DIGIT)
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
			value = 4'd10;
			DIGIT = 4'b1110;
		end
		endcase
	end
endmodule

module TwoDigitBCDCounter(clk, reset, en, dir, BCD0, BCD1, cout);
	input clk, reset, en, dir;
	output [3:0] BCD0, BCD1;
	output cout;

	wire carry0;

	OneDigitBCDCounter c0(.clk(clk), .reset(reset), .en(en), .dir(dir), .BCD(BCD0), .cout(carry0));
	OneDigitBCDCounter c1(.clk(clk), .reset(reset), .en(carry0), .dir(dir), .BCD(BCD1), .cout(cout));
endmodule

module OneDigitBCDCounter(clk, reset, en, dir, BCD, cout);
	input clk, reset, en, dir;
	output [3:0]BCD;
	output reg cout;
	reg [3:0]BCD, outputs;

	always @* begin
		if(en==0) begin
			outputs <= BCD;
			cout <= 0;
		end
		else if(en==1 && dir==1) begin
			if(BCD>=4'b0000 && BCD<=4'b1000) begin
				{cout, outputs} = BCD+ 4'b0001;
			end
			else if(BCD==4'b1001) begin
				outputs <= 4'b0000;
				cout <= 1;
			end
			else begin
				outputs <= 4'b0000;
				cout <= 0;
			end
		end
		else if(en==1 && dir==0) begin
			if(BCD>=4'b0001 && BCD<=4'b1001) begin
				outputs <= BCD - 4'b0001;
				cout <= 0;
			end
			else if(BCD==4'b0000) begin
				outputs <= 4'b1001;
				cout <= 1;
			end
			else begin
				outputs <= 4'b0000;
				cout <= 0;
			end
		end
		else begin
			outputs <= 4'bxxxx;
			cout <= 1'bx; 
		end
	end

	always @(negedge clk, posedge reset)
	begin
		if(reset==1) BCD <= 4'b0000;
		else BCD <= outputs;
	end
endmodule
