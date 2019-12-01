`define silence   32'd50000000
`define INIT   2'b00
`define MUSIC0   2'b01
`define MUSIC1   2'b10

module lab08(
    clk, // clock from crystal
    rst, // active high reset: BTNC
    _play, // SW: Play/Pause
    _mute, // SW: Mute
    _repeat, // SW: Repeat
    _music, // SW: Music
    _volUP, // BTN: Vol up
    _volDOWN, // BTN: Vol down
    _led_vol, // LED: volume
    audio_mclk, // master clock
    audio_lrck, // left-right clock
    audio_sck, // serial clock
    audio_sdin, // serial audio data input
    DISPLAY, // 7-seg
    DIGIT // 7-seg
);

    // I/O declaration
    input clk;  // clock from the crystal
    input rst;  // active high reset
    input _play, _mute, _repeat, _music, _volUP, _volDOWN;
    output [4:0] _led_vol;
    output audio_mclk; // master clock
    output audio_lrck; // left-right clock
    output audio_sck; // serial clock
    output audio_sdin; // serial audio data input
    output [6:0] DISPLAY;
    output [3:0] DIGIT;

    // Internal Signal
    wire [15:0] audio_in_left, audio_in_right;
    wire clkDiv22, clkDiv13, v_up_d, v_down_d, v_up_1pulse, v_down_1pulse, rst_d;
    wire [11:0] ibeatNum; // Beat counter
    wire [31:0] freqL0, freqR0, freqL1, freqR1; // Raw frequency, produced by music module
    wire [21:0] freq_outL, freq_outR; // Processed Frequency, adapted to the clock rate of Basys3
	
	reg [2:0] volume;
	reg [1:0] state, next_state;
	reg [31:0] value;
	reg [3:0] DIGIT;
	reg reset1;
	
    // Note gen makes no sound, if freq_out = 50000000 / `silence = 1
    assign freq_outL = 50000000 / (_mute ? `silence : (_music) ? freqL1 : freqL0);
    assign freq_outR = 50000000 / (_mute ? `silence : (_music) ? freqR1 : freqR0);

    clock_divider #(.n(22)) clock_22(.clk(clk),.clk_div(clkDiv22));
    clock_divider #(.n(13)) clock_13(.clk(clk),.clk_div(clkDiv13));
	debounce reset_d(.pb_debounced(rst_d), .pb(rst) ,.clk(clkDiv13));
	debounce vol_up_d(.pb_debounced(v_up_d), .pb(_volUP) ,.clk(clkDiv13));
	debounce vol_down_d(.pb_debounced(v_down_d), .pb(_volDOWN) ,.clk(clkDiv13));
	onepulse vol_up_o(.signal(v_up_d), .clk(clkDiv13), .op(v_up_1pulse));
	onepulse vol_down_o(.signal(v_down_d), .clk(clkDiv13), .op(v_down_1pulse));

	always@(posedge clkDiv13, posedge rst_d)begin
	    if(rst_d)
		    volume = 3;
	    else if(v_up_1pulse)
		    volume = (volume == 5) ? 5 : volume + 1;
		else if(v_down_1pulse)
		    volume = (volume == 1) ? 1 : volume - 1;
		else
		    volume = (volume>0) ? volume : 3;
	end
	
	always@(*) begin
		case(state)
			`INIT: begin 
				reset1 = 1;
				next_state = (_music) ? `MUSIC1 : `MUSIC0;
			end
			`MUSIC0: begin 
				reset1 = 0;
				next_state = (_music) ? `INIT : `MUSIC0;
			end
			`MUSIC1: begin
				reset1 = 0;
				next_state = (_music) ? `MUSIC1 : `INIT;
			end
			default:  begin 
				reset1 = 0;
				next_state = `INIT;
			end
		endcase
	end
	always@(posedge clkDiv13, posedge rst_d)
	begin
		if(rst_d==1) begin
			state = `INIT;
		end
		else begin
			state = next_state;
		end
	end
	
	
	assign DISPLAY = (value == 32'd524) ? 7'b1110010 : // C sharp
					 (value == 32'd588) ? 7'b1000010 : // D sharp
					 (value == 32'd660) ? 7'b0010000 : // E sharp
					 (value == 32'd698) ? 7'b0111000 : // F sharp
					 (value == 32'd784) ? 7'b0000100 : // G sharp
					 (value == 32'd880) ? 7'b0000010 : // A sharp
					 (value == 32'd988) ? 7'b1100000 : // B sharp
					 (value == 32'd262) ? 7'b1110010 : // C
					 (value == 32'd294) ? 7'b1000010 : // D
					 (value == 32'd330) ? 7'b0010000 : // E
					 (value == 32'd349) ? 7'b0111000 : // F
					 (value == 32'd392) ? 7'b0000100 : // G
					 (value == 32'd440) ? 7'b0000010 : // A
					 (value == 32'd494) ? 7'b1100000 : // B
					 7'b1111110;
					 
					 
	always @(posedge clkDiv13) begin
		case(DIGIT)
		4'b1110: begin
			value = 0;
			DIGIT = 4'b1101;
		end
		4'b1101: begin
			value = 0;
			DIGIT = 4'b1011;
		end
		4'b1011: begin
			value = 0;
			DIGIT = 4'b0111;
		end
		4'b0111: begin
			value = (_music) ? freqR1 : freqR0;
			DIGIT = 4'b1110;
		end
		default: begin
			value = 4'd10;
			DIGIT = 4'b1110;
		end
		endcase
	end
	
	assign _led_vol = (volume == 1) ? 5'b0_0001 : 
	                  (volume == 2) ? 5'b0_0011 : 
					  (volume == 3) ? 5'b0_0111 : 
					  (volume == 4) ? 5'b0_1111 : 
					  (volume == 5) ? 5'b1_1111 : 5'b0_0111;

    // Player Control
    player_control #(.LEN(512)) playerCtrl_00 (.clk(clkDiv22), .reset(rst_d|reset1), ._play(_play), ._repeat(_repeat), .ibeat(ibeatNum));

    // Music module
    music music_data ( .ibeatNum(ibeatNum), .en(~_play), .toneL(freqL0), .toneR(freqR0));
    music1 music_data1 ( .ibeatNum(ibeatNum), .en(~_play), .toneL(freqL1), .toneR(freqR1));

    // Note generation
    note_gen noteGen_00(.clk(clk), .rst(rst_d), .note_div_left(freq_outL), .note_div_right(freq_outR), .audio_left(audio_in_left), .audio_right(audio_in_right), .volume(volume));
	
    // Speaker controller
    speaker_control sc(.clk(clk), .rst(rst_d), .audio_in_left(audio_in_left), .audio_in_right(audio_in_right), .audio_mclk(audio_mclk), .audio_lrck(audio_lrck), .audio_sck(audio_sck), .audio_sdin(audio_sdin));

endmodule
