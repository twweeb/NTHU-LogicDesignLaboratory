`timescale 1ns / 1ps

module Top(
    input wire clk,
    input wire vga_enable,
	inout wire PS2_DATA,
	inout wire PS2_CLK,
	input rst,
    output reg [6:0] DISPLAY,
    output reg [3:0] DIGIT,
	output wire [15:0] led,
    output audio_mclk, // master clock
    output audio_lrck, // left-right clock
    output audio_sck, // serial clock
    output audio_sdin, // serial audio data input
    output hs,
    output vs,
    output [3:0] r,
    output [3:0] g,
    output [3:0] b
    );
	
	parameter [8:0] LEFT_SHIFT_CODES  = 9'b0_0001_0010;
	parameter [8:0] RIGHT_SHIFT_CODES = 9'b0_0101_1001;
	parameter [8:0] KEY_CODES [0:1] = {
		9'b0_0010_1001, // space => 29
		9'b0_0110_1001 // right_1 => 69
	};
	reg [9:0] last_key;
	reg [3:0] key_num;
	wire [511:0] key_down;
	wire [8:0] last_change;
	wire been_ready;
	wire [31:0] SCORE;
	reg [3:0] display_num;
	
    reg game_status, trigger_start, JUMP, START, counter, JUMP_t, stop_s;
    
	wire rst_d, clk_d, clk_jump, clk_display, clkDiv22,
         px_dinosaur, px_ground, px_cactus, px_score;
    wire [8:0] row_addr;
    wire [9:0] col_addr;
    wire [3:0] speed;
    wire [15:0] audio_in_left, audio_in_right;
    wire [11:0] ibeatNum; // Beat counter
    wire [31:0] freqL0, freqR0, freqL1, freqR1; // Raw frequency, produced by music module
    wire [21:0] freq_outL, freq_outR; // Processed Frequency, adapted to the clock rate of Basys3

    assign freq_outL = 50000000 / ((counter) ? freqL0 : freqL1);
    assign freq_outR = 50000000 / ((counter) ? freqR0 : freqR1);
    assign led = (stop_s) ? 16'b0000_0000_1111_1111 : (game_status) ?  16'b1111_1111_1111_1111 : 16'b0000_0000_0000_0000;
	
	clock_divider #(.n(2)) c2(.clk(clk), .clk_div(clk_display));
	clock_divider #(.n(16)) c16(.clk(clk), .clk_div(clk_d));
	clock_divider #(.n(25)) c25(.clk(clk), .clk_div(clk_jump));
	clock_divider #(.n(22)) c22(.clk(clk), .clk_div(clkDiv22));
	clock_divider #(.n(13)) c13(.clk(clk), .clk_div(clk_sevendisplay));
	
	debounce dreset(.pb_debounced(rst_d), .pb(rst), .clk(clk_d));
	KeyboardDecoder key_de (.key_down(key_down), .last_change(last_change), .key_valid(been_ready), .PS2_DATA(PS2_DATA), .PS2_CLK(PS2_CLK), .rst(rst), .clk(clk_display));
	
	always@(posedge JUMP_t or negedge clk_jump) begin
		if(JUMP_t == 1) counter <= 1;
		else counter <= 0;
	end
	
    always @ (posedge clk_display) begin
		JUMP_t = JUMP_t;
        if (rst_d || game_status==1'b0) begin
		    JUMP_t = 0;
        end
        if (been_ready && key_down[last_change] == 1'b1 && (key_num == 4'b0000||key_num == 4'b0001)) begin
        	if (game_status==1'b0)begin
				START = 1'b1;
        	end
			else begin
			    JUMP_t = 1;
        	end
        end
		else begin
			START = 1'b0;
		    JUMP = counter;
			JUMP_t = 0;
		end
    end
	
    //Jump
    Jump jump (.fresh(vs), .row_addr(row_addr), .col_addr(col_addr), .clk(clk_display), .jump(JUMP), .RESET(rst_d), .START(START), .game_status(game_status), .px(px_dinosaur));

    //Ground
    Ground ground (.clk(clk_display), .fresh(vs), .row_addr(row_addr), .col_addr(col_addr), .game_status(game_status), .speed(speed), .px(px_ground));
    
    //Cactus
    Cactus cactus (.clk(clk_display), .RESET(rst_d), .START(START), .fresh(vs), .row_addr(row_addr), .col_addr(col_addr), .game_status(game_status), .speed(speed), .px(px_cactus));

    //Score
    Score score(.clk(clk_display), .RESET(rst_d), .row_addr(row_addr), .col_addr(col_addr), .START(START), .game_status(game_status), .score(SCORE), .px(px_score));

    //Vga
    Vga vga (.clk(clk_display), .clrn(vga_enable), .r(r), .g(g), .b(b), .hs(hs), .vs(vs), .row_addr(row_addr), .col_addr(col_addr), .px_dinosaur(px_dinosaur), .px_ground(px_ground), .px_cactus(px_cactus), .px_score(px_score));

    // Player Control
    player_control #(.LEN(512)) playerCtrl_00 (.clk(clkDiv22), .reset(rst_d), ._play(game_status), ._repeat(1), .ibeat(ibeatNum));

    // Music
    music music_data ( .ibeatNum(ibeatNum), .en(~game_status), .toneL(freqL0), .toneR(freqR0));
    music1 music_data1 ( .ibeatNum(ibeatNum), .en(~game_status), .toneL(freqL1), .toneR(freqR1));

    // Note generation
    note_gen noteGen_00(.clk(clk), .rst(rst_d), .note_div_left(freq_outL), .note_div_right(freq_outR), .audio_left(audio_in_left), .audio_right(audio_in_right), .volume(3));
	
    // Speaker controller
    speaker_control sc(.clk(clk), .rst(rst_d), .audio_in_left(audio_in_left), .audio_in_right(audio_in_right), .audio_mclk(audio_mclk), .audio_lrck(audio_lrck), .audio_sck(audio_sck), .audio_sdin(audio_sdin));

    //when the dinosaur and the cactus pattern has intersection parts, stop the game
    wire trigger_stop;
    assign trigger_stop = px_dinosaur && px_cactus;

    always @(posedge clk_display) begin
        if (START) begin //if button START is pressed
			stop_s <= 0;
            if(game_status==1'b0)begin
                trigger_start<=1'b1;
            end
        end

        if (trigger_stop) begin
            game_status<=1'b0;
			stop_s <= 1;
        end

        //only start the game in the blanking period
        if (vs==1'b0) begin
            if (trigger_start==1'b1) begin
                if (game_status==1'b0) begin
                    game_status<=1'b1;//begin the game
                end else begin
                    trigger_start<=1'b0;
                end
            end
        end

        //reset the game
        if (rst_d) begin//if button RESET is pressed
            game_status<=1'b0;
            trigger_start<=1'b0;
				stop_s <= 0;
        end
    end
	
	always @ (*) begin
		case (last_change)
			KEY_CODES[0] : key_num = 4'b0000;
			KEY_CODES[1] : key_num = 4'b0001;
			default		  : key_num = 4'b1111;
		endcase
	end

    always @ (posedge clk_sevendisplay, posedge rst_d) begin
    	if (rst_d) begin
    		display_num <= 4'b0000;
    		DIGIT <= 4'b1111;
    	end 
		else begin
    		case (DIGIT)
    			4'b1110 : begin
    					display_num <= SCORE[7:4];
    					DIGIT <= 4'b1101;
    				end
    			4'b1101 : begin
						display_num <= SCORE[11:8];
						DIGIT <= 4'b1011;
					end
    			4'b1011 : begin
						display_num <= SCORE[15:12];
						DIGIT <= 4'b0111;
					end
    			4'b0111 : begin
						display_num <= SCORE[3:0];
						DIGIT <= 4'b1110;
					end
    			default : begin
						display_num <= 4'd10;
						DIGIT <= 4'b1110;
					end				
    		endcase
    	end
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
endmodule

module debounce(pb_debounced, pb, clk);
    output pb_debounced;
    input pb;
    input clk;
    
    reg [3:0] shift_reg;
    
    always@(posedge clk)
    begin
        shift_reg[3:1] <= shift_reg[2:0];
        shift_reg[0] <= pb;
    end
    
    assign pb_debounced = ((shift_reg == 4'b1111) ? 1'b1 : 1'b0);
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