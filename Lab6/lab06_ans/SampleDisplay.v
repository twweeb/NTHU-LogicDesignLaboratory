module SampleDisplay(
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
		9'b0_0111_1101,  // right_9 => 7D
		9'b0_0101_1010 // enter => 5A
	};
	
	reg [7:0] nums,nextnums;
	reg [3:0] key_num;
	reg [9:0] last_key;
	wire shift_down;
	wire [511:0] key_down;
	wire [8:0] last_change;
	wire been_ready;
	reg[2:0] state,nextstate;
	parameter IDLE = 3'b000, GUESS_FIRST = 3'b001, GUESS_SECOND = 3'b010, WAIT_ENTER = 3'b011,CALC = 3'b100, DONE = 3'b101; 
	assign shift_down = (key_down[LEFT_SHIFT_CODES] == 1'b1 || key_down[RIGHT_SHIFT_CODES] == 1'b1) ? 1'b1 : 1'b0;
	reg[3:0] rangeMax0,rangeMax1,rangeMin0,rangeMin1,n_rangeMax0,n_rangeMax1,n_rangeMin0,n_rangeMin1;
	reg[6:0] nextcount;
	reg[6:0] goal;
	wire [3:0] BCD0,BCD1,BCD2,BCD3;
	reg [24:0] count_25,next_25;
	reg [15:0] next_led;
	wire start_d,enter,clk13,clk16;
	LED7SEG seven_seg (
		.DISPLAY(DISPLAY),
		.DIGIT(DIGIT),
		.clk(clk13),
		.BCD3(BCD3),
		.BCD2(BCD2),
		.BCD1(BCD1),
		.BCD0(BCD0)
	);
	assign BCD0 = (cheat&&(state!=IDLE))?4'b1111:(state == WAIT_ENTER || state == CALC)?nums[3:0]:(state == IDLE)?4'd10:rangeMax0;
	assign BCD1 = (cheat&&(state!=IDLE))?4'b1111:(state == WAIT_ENTER || state == CALC)?nums[7:4]:(state == IDLE)?4'd10:rangeMax1;
	assign BCD2 = (cheat&&(state!=IDLE))?goal%10:(state == WAIT_ENTER || state == CALC)?4'b1111:(state == IDLE)?4'd10:rangeMin0;
	assign BCD3 = (cheat&&(state!=IDLE))?goal/10:(state == WAIT_ENTER || state == CALC)?4'b1111:(state == IDLE)?4'd10:rangeMin1;
	KeyboardDecoder key_de (
		.key_down(key_down),
		.last_change(last_change),
		.key_valid(been_ready),
		.PS2_DATA(PS2_DATA),
		.PS2_CLK(PS2_CLK),
		.rst(rst),
		.clk(clk)
	);
	ClockDivider clk_div13(clk,clk13);
	ClockDivider #(16)clk_div16(clk,clk16);
	debounce startd(start_d,start,clk16);
	assign enter = been_ready & key_down[last_change] & last_change == KEY_CODES[20];
	always @ (posedge clk, posedge rst) begin
		if (rst) begin
			nums  <= 8'b11111111;
			state <= IDLE;
			rangeMax0 <= 4'd9;
			rangeMax1 <= 4'd9;
			rangeMin0 <= 4'd0;
			rangeMin1 <= 4'd0;
			goal <= 7'd0;
			count_25 <= 25'b0;
			LED <= 16'b0;
		end else begin
			goal <= nextcount;
			state <= nextstate;
			nums <= nextnums;
			rangeMax0 <= n_rangeMax0;
			rangeMax1 <= n_rangeMax1;
			rangeMin0 <= n_rangeMin0;
			rangeMin1 <= n_rangeMin1;
			count_25 <= next_25;
			LED <= next_led;
			/*if (been_ready && key_down[last_change] == 1'b1 && (nextstate == GUESS_SECOND || nextstate == WAIT_ENTER) ) begin
				if (key_num != 4'b1111)begin
					nums <= {nums[3:0], key_num};
				end
			end*/
		end
	end
	always @(*)begin
		n_rangeMax0 = rangeMax0;
		n_rangeMin0 = rangeMin0;
		n_rangeMax1 = rangeMax1;
		n_rangeMin1 = rangeMin1;
		nextnums = nums;
		nextstate = state;
		nextcount = goal;
		next_25 = 0;
		next_led = LED;
		case(state)
			IDLE:begin
				if(start_d)begin
					nextstate = GUESS_FIRST;
				end
				else begin
					if(goal < 99)
						nextcount = goal + 7'd1;
					else 
						nextcount = 7'd1;
				end
			end
			GUESS_FIRST:begin
				if(been_ready && key_down[last_change])begin
					if(key_num!=4'b1111)begin
						nextstate = WAIT_ENTER;
						nextnums = {nums[3:0], key_num};
					end
					else 
						nextstate = GUESS_FIRST;
				end
			end
			WAIT_ENTER:begin
				if(enter)begin
					nextstate = CALC;
				end
				else if(been_ready && key_down[last_change])begin
					nextstate = WAIT_ENTER;
					if(key_num!=4'b1111)
						nextnums = {nums[3:0], key_num};
				end

			end
			CALC:begin
				nextstate = GUESS_FIRST;
				nextnums = 8'b11111111;
				if(nums[7:4] ==4'b1111)begin
					nextstate = GUESS_FIRST;
				end
				else if(nums[7:4] > rangeMax1 ||(nums[7:4] == rangeMax1 && nums[3:0] > rangeMax0))begin
					nextstate = GUESS_FIRST;
				end
				else if(nums[7:4] < rangeMin1 ||(nums[7:4] == rangeMin1 && nums[3:0] < rangeMin0))begin
					nextstate = GUESS_FIRST;
				end
				else begin
					if(nums[7:4]==(goal/10) && nums[3:0] == (goal%10))begin
						nextstate = DONE;
						n_rangeMax0 = goal%10;
						n_rangeMax1 = goal/10;
						n_rangeMin0 = goal%10;
						n_rangeMin1 = goal/10;
					end
					else if(nums[7:4]>(goal/10) || (nums[7:4]==(goal/10)&&nums[3:0] > (goal%10)))begin
						n_rangeMax0 = nums[3:0];
						n_rangeMax1 = nums[7:4];
					end
					else begin
						n_rangeMin0 = nums[3:0];
						n_rangeMin1 = nums[7:4];
					end
				end
			end
			DONE:begin
				if(count_25 == 25'b1_1111_1111_1111_1111_1111_1111)begin
					nextstate = IDLE;
					nextcount = 7'd0;
					next_led = 16'd0;
					n_rangeMax0 = 4'd9;
					n_rangeMax1 = 4'd9;
					n_rangeMin0 = 4'd0;
					n_rangeMin1 = 4'd0;
				end
				else begin
					next_25 = count_25 + 25'd1;
					nextstate = DONE;
					next_led = 16'b1111_1111_1111_1111;
				end
			end
		endcase
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
			default		  : key_num = 4'b1111;
		endcase
	end
	
endmodule
