`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/22 02:20:55
// Design Name: 
// Module Name: lab4_3
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

`define RESET 3'b000
`define SET 3'b001
`define COUNT 3'b010
`define PAUSE 3'b011
`define FINI 3'b100

module lab4_3 (
input wire en,
input wire reset,
input wire clk,
input wire mode,
input wire min_plus,
input wire sec_plus,
output wire [3:0] DIGIT,
output wire [6:0] DISPLAY,
output wire stop
);

	wire clk_count, clk_d, clk_fsm, reset_clk, out1, out2,
	     en_d , reset_d, min_plus_d, sec_plus_d,
		 en_1pulse, min_plus_1pulse, sec_plus_1pulse,
		 en_min, en_sec, min_dir, sec_dir;
	wire [2:0] next_state;
	wire [3:0] BCD0, BCD1, BCD2, BCD3;

	reg en_counter1, dir_now1, reset1;
	reg [2:0] state, next_state1;
	reg [3:0] value, DIGIT;

	clock_divider #(.n(22)) c20(.clk(clk), .clk_div(clk_count));
	clock_divider #(.n(23)) c23(.clk(clk), .clk_div(clk_fsm));
	clock_divider #(.n(13)) c13(.clk(clk), .clk_div(clk_d)); 

	debounce den(.pb_debounced(en_d), .pb(en), .clk(clk_d));
	debounce dreset(.pb_debounced(reset_d), .pb(reset), .clk(clk_d));
	debounce dmin(.pb_debounced(min_plus_d), .pb(min_plus), .clk(clk_d));
	debounce dsec(.pb_debounced(sec_plus_d), .pb(sec_plus), .clk(clk_d));
	
	onepulse oen(.rst(reset_d), .clk(clk_count), .pb_debounced(en_d), .pb_1pulse(en_1pulse));
	onepulse omin(.rst(reset_d), .clk(clk_count), .pb_debounced(min_plus_d), .pb_1pulse(min_plus_1pulse));
	onepulse osec(.rst(reset_d), .clk(clk_count), .pb_debounced(sec_plus_d), .pb_1pulse(sec_plus_1pulse));
	
	TimeCounter min(.clk(clk_count), .reset(reset_clk), .en(en_min), .dir(min_dir), .Tenth(BCD2), .Unit(BCD3), .cout(out2));
	TimeCounter sec(.clk(clk_count), .reset(reset_clk), .en(en_sec), .dir(sec_dir), .Tenth(BCD0), .Unit(BCD1), .cout(out1));

	assign min_dir = (state == `SET) ? (out1 == 1) ? 1 : min_plus_1pulse : 0;
	assign sec_dir = (state == `SET) ? sec_plus_1pulse : 0;
	assign en_min = (out1 == 1) ? out1 : (state == `SET) ? min_plus_1pulse : 0;
	assign en_sec = (state == `SET) ? sec_plus_1pulse : en_counter1;
	assign stop = (state != `SET && state != `RESET && {BCD0,BCD1,BCD2,BCD3} == 16'b0) ? 1 : 0; 
	assign reset_clk = reset_d | reset1;
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
			`RESET: next_state1 = `SET;
			`SET: next_state1 = (mode == 1) ? `PAUSE: `SET; 
			`COUNT: next_state1 = (mode == 0) ? `RESET : (en_1pulse == 1) ? `PAUSE : (stop == 1) ? `FINI : `COUNT;
			`PAUSE: next_state1 = (mode == 0) ? `RESET : (en_1pulse == 1) ? `COUNT : `PAUSE;
			`FINI:  next_state1 = (mode == 0) ? `RESET : `FINI;
			default: next_state1 = `RESET;
		endcase
	end
	
	always@(*)begin
		case(state)
			`RESET: begin 
				en_counter1 = 0;
				reset1 = 1;
			end
			`SET: begin 
				en_counter1 = 0;
				reset1 = 0;
			end
			`COUNT: begin
				en_counter1 = 1;
				reset1 = 0;
			end
			`PAUSE: begin
				en_counter1 = 0;
				reset1 = 0;
			end
			`FINI: begin
				en_counter1 = 0;
				reset1 = 0;
			end
			default:  begin 
				en_counter1 = 0;
				reset1 = 0;
			end
		endcase
	end

	always@(posedge clk_count, posedge reset_d)
	begin
		if(reset_d==1) begin
			state = `SET;
		end
		else begin
			state = next_state1;
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

module TimeCounter(clk, reset, en, dir, Tenth, Unit, cout);
	input clk, reset, en, dir;
	output [3:0] Tenth, Unit;
	output cout;

	wire carry0;

	UnitDigitCounter c0(.clk(clk), .reset(reset), .en(en), .dir(dir), .BCD(Tenth), .cout(carry0));
	TenthDigitCounter c1(.clk(clk), .reset(reset), .en(carry0), .dir(dir), .BCD(Unit), .cout(cout));
endmodule

module UnitDigitCounter(clk, reset, en, dir, BCD, cout);
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

module TenthDigitCounter(clk, reset, en, dir, BCD, cout);
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
			if(BCD>=4'b0000 && BCD<=4'b0100) begin
				{cout, outputs} = BCD+ 4'b0001;
			end
			else if(BCD==4'b0101) begin
				outputs <= 4'b0000;
				cout <= 1;
			end
			else begin
				outputs <= 4'b0000;
				cout <= 0;
			end
		end
		else if(en==1 && dir==0) begin
			if(BCD>=4'b0001 && BCD<=4'b0101) begin
				outputs <= BCD - 4'b0001;
				cout <= 0;
			end
			else if(BCD==4'b0000) begin
				outputs <= 4'b0101;
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