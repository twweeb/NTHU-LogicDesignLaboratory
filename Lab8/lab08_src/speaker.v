`define silence   32'd50000000

module speaker(
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
    
    // Modify these
    assign _led_vol = 5'b1_1111;
    assign DIGIT = 4'b0001;
    assign DISPLAY = 7'b111_1111;

    // Internal Signal
    wire [15:0] audio_in_left, audio_in_right;
    
    wire clkDiv22;
    wire [11:0] ibeatNum; // Beat counter
    wire [31:0] freqL, freqR; // Raw frequency, produced by music module
    wire [21:0] freq_outL, freq_outR; // Processed Frequency, adapted to the clock rate of Basys3

    assign freq_outL = 50000000 / (_mute ? `silence : freqL); // Note gen makes no sound, if freq_out = 50000000 / `silence = 1
    assign freq_outR = 50000000 / (_mute ? `silence : freqR);

    clock_divider #(.n(22)) clock_22(
        .clk(clk),
        .clk_div(clkDiv22)
    );

    // Player Control
    player_control #(.LEN(128)) playerCtrl_00 ( 
        .clk(clkDiv22),
        .reset(rst),
        ._play(1'b1),
        ._repeat(1'b1),
        .ibeat(ibeatNum)
    );

    // Music module
    // [in]  beat number and en
    // [out] left & right raw frequency
    music_example music_00 (
        .ibeatNum(ibeatNum),
        .en(1'b0),
        .toneL(freqL),
        .toneR(freqR)
    );

    // Note generation
    // [in]  processed frequency
    // [out] audio wave signal (using square wave here)
    note_gen noteGen_00(
        .clk(clk), // clock from crystal
        .rst(rst), // active high reset
        .note_div_left(freq_outL),
        .note_div_right(freq_outR),
        .audio_left(audio_in_left), // left sound audio
        .audio_right(audio_in_right),
        .volume(3'b000) // 3 bits for 5 levels
    );

    // Speaker controller
    speaker_control sc(
        .clk(clk),  // clock from the crystal
        .rst(rst),  // active high reset
        .audio_in_left(audio_in_left), // left channel audio data input
        .audio_in_right(audio_in_right), // right channel audio data input
        .audio_mclk(audio_mclk), // master clock
        .audio_lrck(audio_lrck), // left-right clock
        .audio_sck(audio_sck), // serial clock
        .audio_sdin(audio_sdin) // serial audio data input
    );

endmodule
