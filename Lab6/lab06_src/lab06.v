`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/11 01:51:41
// Design Name: 
// Module Name: lab06
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
`define GUESS 3'b001
`define INPUT 3'b010
`define CHECK 3'b011
`define SUCCESS 3'b100

module lab06(
output wire [6:0] DISPLAY,
output wire [3:0] DIGIT,
output reg [15:0] LED,
inout wire PS2_DATA,
inout wire PS2_CLK,
input wire rst,
input wire clk,
input wire start,
input wire cheat
);
	
	parameter [8:0] LEFT_SHIFT_CODES  = 9'b0_0001_0010;
	parameter [8:0] RIGHT_SHIFT_CODES = 9'b0_0101_1001;
	parameter [8:0] KEY_CODES [0:20] = {
		9'b0_0100_0101,	// 0 => 45
		9'b0_0001_0110,	// 1 => 16
		9'b0_0001_1110,	// 2 => 1E
		9'b0_0010_0110,	// 3 => 26
		9'b0_0010_0101,	// 4 => 25
		9'b0_0010_1110,	// 5 => 2E
		9'b0_0011_0110,	// 6 => 36
		9'b0_0011_1101,	// 7 => 3D
		9'b0_0011_1110,	// 8 => 3E
		9'b0_0100_0110,	// 9 => 46
		
		9'b0_0111_0000, // right_0 => 70
		9'b0_0110_1001, // right_1 => 69
		9'b0_0111_0010, // right_2 => 72
		9'b0_0111_1010, // right_3 => 7A
		9'b0_0110_1011, // right_4 => 6B
		9'b0_0111_0011, // right_5 => 73
		9'b0_0111_0100, // right_6 => 74
		9'b0_0110_1100, // right_7 => 6C
		9'b0_0111_0101, // right_8 => 75
		9'b0_0111_1101, // right_9 => 7D
		
		9'b0_0101_1010  // enter => 5A
	};
	
	reg [15:0] nums;
	reg [3:0] key_num, display_num, DIGIT,
	          min1, min0, max1, max0, goal1, goal0,
			  next_min1, next_min0, next_max1, next_max0, next_goal1, next_goal0,
			  next_D0, next_D1, next_D2, next_D3, D0, D1, D2, D3;
	reg [9:0] last_key;
	reg [2:0] state, next_state;
	reg [6:0] DISPLAY;
	
	wire shift_down, clk_d, clk_led, clk_display, clk_used,
	     rst_d, cheat_d, start_d, rst_1pulse, start_1pulse;
	wire [3:0] random;
	wire [511:0] key_down;
	wire [8:0] last_change;
	wire been_ready;
	
	assign clk_used = (state == `SUCCESS) ? clk_led : clk;
	assign shift_down = (key_down[LEFT_SHIFT_CODES] == 1'b1 || key_down[RIGHT_SHIFT_CODES] == 1'b1) ? 1'b1 : 1'b0;
	
	clock_divider #(.n(16)) c16(.clk(clk), .clk_div(clk_d));
	clock_divider #(.n(26)) c26(.clk(clk), .clk_div(clk_led));
	clock_divider #(.n(13)) c13(.clk(clk), .clk_div(clk_display));
	
	debounce dreset(.pb_debounced(rst_d), .pb(rst), .clk(clk_d));
	debounce dcheat(.pb_debounced(cheat_d), .pb(cheat), .clk(clk_d));
	debounce dstart(.pb_debounced(start_d), .pb(start), .clk(clk_d));
	OnePulse oreset(.signal(rst_d), .signal_single_pulse(rst_1pulse), .clock(clk_d));
	OnePulse ostart(.signal(start_d), .signal_single_pulse(start_1pulse), .clock(clk_d));
	LFSR genRand(.random(random), .clk(clk), .rst(rst_1pulse));
	KeyboardDecoder key_de (.key_down(key_down), .last_change(last_change), .key_valid(been_ready), .PS2_DATA(PS2_DATA), .PS2_CLK(PS2_CLK), .rst(rst), .clk(clk));
    
	always@(*) begin 
		LED[15:0] = (state == `SUCCESS) ? 16'b1111_1111_1111_1111 : 16'b0000_0000_0000_0000;
	end
	
    always @ (*) begin
    	case (display_num)
    		0 : DISPLAY = 7'b1000000;	//0000
			1 : DISPLAY = 7'b1111001;   //0001                                                
			2 : DISPLAY = 7'b0100100;   //0010                                                
			3 : DISPLAY = 7'b0110000;   //0011                                             
			4 : DISPLAY = 7'b0011001;   //0100                                               
			5 : DISPLAY = 7'b0010010;   //0101                                               
			6 : DISPLAY = 7'b0000010;   //0110
			7 : DISPLAY = 7'b1111000;   //0111
			8 : DISPLAY = 7'b0000000;   //1000
			9 : DISPLAY = 7'b0010000;	//1001
			10: DISPLAY = 7'b0111111;   //-
			default : DISPLAY = 7'b1111111;
    	endcase
    end
	
	always@(*)begin
		case(state)
			`INIT: begin
				next_state = (start_1pulse) ? `GUESS : `INIT;
				next_min1  = 4'b0;
				next_min0  = 4'b0;
				next_max1  = 4'b1001;
				next_max0  = 4'b1001;
				next_D0    = 4'd10;
				next_D1    = 4'd10;
				next_D2    = 4'd10;
				next_D3    = 4'd10;
				next_goal1 = (start_1pulse) ? random%4'd10 : goal1;
				next_goal0 = (start_1pulse) ? ~random%4'd10 : goal0;
			end
			
			`GUESS: begin
				next_state = (key_num != 4'b1111) ? `INPUT : `GUESS;
				next_min1  = min1;
				next_min0  = min0;
				next_max1  = max1;
				next_max0  = max0;
				next_D0    = max0;
				next_D1    = max1;
				next_D2    = min0;
				next_D3    = min1;
				next_goal1 = goal1;
				next_goal0 = goal0;
			end
			
			`INPUT: begin
				next_state = (key_num == 4'b1110) ? `CHECK : `INPUT;
				next_min1  = min1;
				next_min0  = min0;
				next_max1  = max1;
				next_max0  = max0;
				next_D0    = nums[3:0];
				next_D1    = nums[7:4];
				next_D2    = 4'd11;
				next_D3    = 4'd11;
				next_goal1 = goal1;
				next_goal0 = goal0;
			end
			
			`CHECK: begin
				next_state = (nums[7:0] == {goal1,goal0}) ? `SUCCESS : `GUESS;
				next_min1 = (nums[7:4] != 4'b1111 && nums[7:0] > {min1,min0} && nums[7:0] < {goal1,goal0}) ? nums[7:4] : min1;
				next_min0 = (nums[7:4] != 4'b1111 && nums[7:0] > {min1,min0} && nums[7:0] < {goal1,goal0}) ? nums[3:0] : min0;
				next_max1 = (nums[7:4] != 4'b1111 && nums[7:0] < {max1,max0} && nums[7:0] > {goal1,goal0}) ? nums[7:4] : max1;
				next_max0 = (nums[7:4] != 4'b1111 && nums[7:0] < {max1,max0} && nums[7:0] > {goal1,goal0}) ? nums[3:0] : max0;
				next_D0    = (nums[7:0] == {goal1,goal0}) ? goal0 : max0;
				next_D1    = (nums[7:0] == {goal1,goal0}) ? goal1 : max1;
				next_D2    = (nums[7:0] == {goal1,goal0}) ? goal0 : min0;
				next_D3    = (nums[7:0] == {goal1,goal0}) ? goal1 : min1;
				next_goal1 = goal1;
				next_goal0 = goal0;
			end
			
			`SUCCESS: begin
				next_state = `INIT;
				next_min1  = 4'b0;
				next_min0  = 4'b0;
				next_max1  = 4'b1001;
				next_max0  = 4'b1001;
				next_D0    = goal0;
				next_D1    = goal1;
				next_D2    = goal0;
				next_D3    = goal1;
				next_goal1 = goal1;
				next_goal0 = goal0;
			end
			
			default: begin
				next_state = `INIT;
				next_min1  = 4'b0;
				next_min0  = 4'b0;
				next_max1  = 4'b1001;
				next_max0  = 4'b1001;
				next_D0    = 4'd10;
				next_D1    = 4'd10;
				next_D2    = 4'd10;
				next_D3    = 4'd10;
				next_goal1 = 4'b0;
				next_goal0 = 4'b0;
			end
		endcase
	end

	always@(posedge clk_used, posedge rst_1pulse) begin
		if(rst_1pulse == 1) begin
			state = `INIT;
			min1 = 4'b0;
			min0 = 4'b0;
			max1 = 4'b1001;
			max0 = 4'b1001;
			goal1 = 4'b0;
			goal0 = 4'b0;
			D0 = next_D0;
			D1 = next_D1;
			D2 = next_D2;
			D3 = next_D3;
		end
		else begin
			state = next_state;
			min1 = next_min1;
			min0 = next_min0;
			max1 = next_max1;
			max0 = next_max0;
			goal1 = next_goal1;
			goal0 = next_goal0;
			D0 = next_D0;
			D1 = next_D1;
			D2 = next_D2;
			D3 = next_D3;
		end
	end
	
    always @ (posedge clk_display, posedge rst_1pulse) begin
    	if (rst_1pulse) begin
    		display_num <= 4'b0000;
    		DIGIT <= 4'b1111;
    	end 
		else begin
    		case (DIGIT)
    			4'b1110 : begin
    					display_num <= (cheat_d) ? 4'd11 : D1;
    					DIGIT <= 4'b1101;
    				end
    			4'b1101 : begin
						display_num <= (cheat_d) ? goal0 : D2;
						DIGIT <= 4'b1011;
					end
    			4'b1011 : begin
						display_num <= (cheat_d) ? goal1 : D3;
						DIGIT <= 4'b0111;
					end
    			4'b0111 : begin
						display_num <= (cheat_d) ? 4'd11 : D0;
						DIGIT <= 4'b1110;
					end
    			default : begin
						display_num <= (state == `INIT) ? 4'd10 : nums[3:0];
						DIGIT <= 4'b1110;
					end				
    		endcase
    	end
    end
    
	always @ (posedge clk, posedge rst_1pulse) begin
		if (rst_1pulse || state == `GUESS ) begin
			nums <= 8'b1111_1111;
		end else begin
			nums <= nums;
			if (state == `INPUT && been_ready && key_down[last_change] == 1'b1) begin
				if (key_num != 4'b1111 && key_num!= 4'b1110)begin
					if (shift_down == 1'b1) begin
						nums <= {key_num, nums[7:4]};
						
					end 
					else begin
						nums <= {nums[3:0], key_num};
					end
				end
			end
		end
	end
	
	always @ (*) begin
		case (last_change)
			KEY_CODES[00] : key_num = 4'b0000;
			KEY_CODES[01] : key_num = 4'b0001;
			KEY_CODES[02] : key_num = 4'b0010;
			KEY_CODES[03] : key_num = 4'b0011;
			KEY_CODES[04] : key_num = 4'b0100;
			KEY_CODES[05] : key_num = 4'b0101;
			KEY_CODES[06] : key_num = 4'b0110;
			KEY_CODES[07] : key_num = 4'b0111;
			KEY_CODES[08] : key_num = 4'b1000;
			KEY_CODES[09] : key_num = 4'b1001;
			KEY_CODES[10] : key_num = 4'b0000;
			KEY_CODES[11] : key_num = 4'b0001;
			KEY_CODES[12] : key_num = 4'b0010;
			KEY_CODES[13] : key_num = 4'b0011;
			KEY_CODES[14] : key_num = 4'b0100;
			KEY_CODES[15] : key_num = 4'b0101;
			KEY_CODES[16] : key_num = 4'b0110;
			KEY_CODES[17] : key_num = 4'b0111;
			KEY_CODES[18] : key_num = 4'b1000;
			KEY_CODES[19] : key_num = 4'b1001;
			KEY_CODES[20] : key_num = 4'b1110;
			default		  : key_num = 4'b1111;
		endcase
	end
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

module OnePulse (
	output reg signal_single_pulse,
	input wire signal,
	input wire clock
	);
	
	reg signal_delay;

	always @(posedge clock) begin
		if (signal == 1'b1 & signal_delay == 1'b0)
		  signal_single_pulse <= 1'b1;
		else
		  signal_single_pulse <= 1'b0;

		signal_delay <= signal;
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

module KeyboardDecoder(
	output reg [511:0] key_down,
	output wire [8:0] last_change,
	output reg key_valid,
	inout wire PS2_DATA,
	inout wire PS2_CLK,
	input wire rst,
	input wire clk
    );
    
    parameter [1:0] INIT			= 2'b00;
    parameter [1:0] WAIT_FOR_SIGNAL = 2'b01;
    parameter [1:0] GET_SIGNAL_DOWN = 2'b10;
    parameter [1:0] WAIT_RELEASE    = 2'b11;
    
	parameter [7:0] IS_INIT			= 8'hAA;
    parameter [7:0] IS_EXTEND		= 8'hE0;
    parameter [7:0] IS_BREAK		= 8'hF0;
    
    reg [9:0] key;		// key = {been_extend, been_break, key_in}
    reg [1:0] state;
    reg been_ready, been_extend, been_break;
    
    wire [7:0] key_in;
    wire is_extend;
    wire is_break;
    wire valid;
    wire err;
    
    wire [511:0] key_decode = 1 << last_change;
    assign last_change = {key[9], key[7:0]};
    
    KeyboardCtrl_0 inst (
		.key_in(key_in),
		.is_extend(is_extend),
		.is_break(is_break),
		.valid(valid),
		.err(err),
		.PS2_DATA(PS2_DATA),
		.PS2_CLK(PS2_CLK),
		.rst(rst),
		.clk(clk)
	);
	
	OnePulse op (
		.signal_single_pulse(pulse_been_ready),
		.signal(been_ready),
		.clock(clk)
	);
    
    always @ (posedge clk, posedge rst) begin
    	if (rst) begin
    		state <= INIT;
    		been_ready  <= 1'b0;
    		been_extend <= 1'b0;
    		been_break  <= 1'b0;
    		key <= 10'b0_0_0000_0000;
    	end else begin
    		state <= state;
			been_ready  <= been_ready;
			been_extend <= (is_extend) ? 1'b1 : been_extend;
			been_break  <= (is_break ) ? 1'b1 : been_break;
			key <= key;
    		case (state)
    			INIT : begin
    					if (key_in == IS_INIT) begin
    						state <= WAIT_FOR_SIGNAL;
    						been_ready  <= 1'b0;
							been_extend <= 1'b0;
							been_break  <= 1'b0;
							key <= 10'b0_0_0000_0000;
    					end else begin
    						state <= INIT;
    					end
    				end
    			WAIT_FOR_SIGNAL : begin
    					if (valid == 0) begin
    						state <= WAIT_FOR_SIGNAL;
    						been_ready <= 1'b0;
    					end else begin
    						state <= GET_SIGNAL_DOWN;
    					end
    				end
    			GET_SIGNAL_DOWN : begin
						state <= WAIT_RELEASE;
						key <= {been_extend, been_break, key_in};
						been_ready  <= 1'b1;
    				end
    			WAIT_RELEASE : begin
    					if (valid == 1) begin
    						state <= WAIT_RELEASE;
    					end else begin
    						state <= WAIT_FOR_SIGNAL;
    						been_extend <= 1'b0;
    						been_break  <= 1'b0;
    					end
    				end
    			default : begin
    					state <= INIT;
						been_ready  <= 1'b0;
						been_extend <= 1'b0;
						been_break  <= 1'b0;
						key <= 10'b0_0_0000_0000;
    				end
    		endcase
    	end
    end
    
    always @ (posedge clk, posedge rst) begin
    	if (rst) begin
    		key_valid <= 1'b0;
    		key_down <= 511'b0;
    	end else if (key_decode[last_change] && pulse_been_ready) begin
    		key_valid <= 1'b1;
    		if (key[8] == 0) begin
    			key_down <= key_down | key_decode;
    		end else begin
    			key_down <= key_down & (~key_decode);
    		end
    	end else begin
    		key_valid <= 1'b0;
			key_down <= key_down;
    	end
    end
endmodule

module LFSR(random, clk, rst);
	input clk;
	input rst;
	output [3:0] random;
	reg [3:0] random;
	
	always @(posedge clk or posedge rst) begin
		if (rst == 1'b1) random[3:0] <= 4'b1000;
		else begin
			random[2:0] <= random[3:1];
			random[3] <= random[1] ^ random[0];
		end
	end
endmodule