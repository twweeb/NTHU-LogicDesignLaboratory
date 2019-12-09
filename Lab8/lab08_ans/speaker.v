module clock_divider(clk, clk_div);   
    parameter n = 26;     
    input clk;   
    output clk_div;   
    
    reg [n-1:0] num;
    wire [n-1:0] next_num;
    
    always@(posedge clk)begin
    	num<=next_num;
    end
    
    assign next_num = num +1;
    assign clk_div = num[n-1];
    
endmodule

module onepulse(signal, clk, op);
    input signal, clk;
    output op;
    
    reg op;
    reg delay;
    
    always @(posedge clk) begin
        if((signal == 1) & (delay == 0)) op <= 1;
        else op <= 0; 
        delay = signal;
    end
endmodule

module debounce(pb_debounced, pb ,clk);
    output pb_debounced;
    input pb;
    input clk;
    
    reg [6:0] shift_reg;
    always @(posedge clk) begin
        shift_reg[6:1] <= shift_reg[5:0];
        shift_reg[0] <= pb;
    end
    
    assign pb_debounced = shift_reg == 7'b111_1111 ? 1'b1 : 1'b0;
endmodule


module PlayerCtrl (
	input clk,
	input reset,
	input _play,
	input _repeat,
	output reg [11:0] ibeat
);
	parameter LEN = 4095;

	always @(posedge clk, posedge reset) begin
		if (reset)
			ibeat <= 0;
		else begin

			if(ibeat < LEN) begin
				ibeat <= (_play) ? (ibeat + 1) : ibeat;
			end
			// About to end: decide whether to proceed
			else if (ibeat == LEN)begin
				ibeat <= (_repeat) ? 0 : (LEN + 1);
			end
			else if (ibeat > LEN) begin
				ibeat <= ibeat;
			end
			else ibeat <= 0;
		end
	end

endmodule

module note_gen(
  clk, // clock from crystal
  rst, // active high reset
  note_div, // div for note generation
  note_div_right,
  audio_left,
  audio_right,
  volume
);

  // I/O declaration
  input clk; // clock from crystal
  input rst; // active low reset
  input [21:0] note_div, note_div_right; // div for note generation
  output [15:0] audio_left, audio_right;
  input [2:0] volume;

  // Declare internal signals
  reg [21:0] clk_cnt_next, clk_cnt;
  reg [21:0] clk_cnt_next_2, clk_cnt_2;
  reg b_clk, b_clk_next;
  reg c_clk, c_clk_next;

  parameter [15:0] min [7:0] = {
    16'h0000,
    16'h0000,
    16'h0000,
    16'h8001,
    16'hA000,
    16'hC000,
    16'hE000,
    16'hF800
  };
  parameter [15:0] max [7:0] = {
    16'h0000,
    16'h0000,
    16'h0000,
    16'h7FFF,
    16'h6000,
    16'h4000,
    16'h2000,
    16'h0800
  };

  // Note frequency generation
  always @(posedge clk or posedge rst)
    if (rst == 1'b1)
    begin
      clk_cnt <= 22'd0;
      clk_cnt_2 <= 22'd0;
      b_clk <= 1'b0;
      c_clk <= 1'b0;
    end
    else
    begin
      clk_cnt <= clk_cnt_next;
      clk_cnt_2 <= clk_cnt_next_2;
      b_clk <= b_clk_next;
      c_clk <= c_clk_next;
    end
    
  always @*
    if (clk_cnt == note_div)
    begin
      clk_cnt_next = 22'd0;
      b_clk_next = ~b_clk;
    end
    else
    begin
      clk_cnt_next = clk_cnt + 1'b1;
      b_clk_next = b_clk;
    end

  always @*
    if (clk_cnt_2 == note_div_right)
    begin
      clk_cnt_next_2 = 22'd0;
      c_clk_next = ~c_clk;
    end
    else
    begin
      clk_cnt_next_2 = clk_cnt_2 + 1'b1;
      c_clk_next = c_clk;
    end

  // Assign the amplitude of the note
  //assign audio_left = (b_clk == 1'b0) ? 16'hE000 : 16'h2000;
  //assign audio_right = (c_clk == 1'b0) ? 16'hE000 : 16'h2000;
  //assign audio_left = (note_div == 22'd1000) ? 16'h0000 : (b_clk == 1'b0) ? 16'h8001 : 16'h7FFF;
  assign audio_left = (note_div == 22'd1000) ? 16'h0000 : (b_clk == 1'b0) ? min[volume] : max[volume];
  assign audio_right = (note_div_right == 22'd1000) ? 16'h0000 : (c_clk == 1'b0) ? min[volume] : max[volume];
endmodule

module speaker_control(
  clk,  // clock from the crystal
  rst,  // active high reset
  audio_in_left, // left channel audio data input
  audio_in_right, // right channel audio data input
  audio_mclk, // master clock
  audio_lrck, // left-right clock, Word Select clock, or sample rate clock
  audio_sck, // serial clock
  audio_sdin // serial audio data input
);

// I/O declaration
input clk;  // clock from the crystal
input rst;  // active high reset
input [15:0] audio_in_left; // left channel audio data input
input [15:0] audio_in_right; // right channel audio data input
output audio_mclk; // master clock
output audio_lrck; // left-right clock
output audio_sck; // serial clock
output audio_sdin; // serial audio data input
reg audio_sdin;

// Declare internal signal nodes 
wire [8:0] clk_cnt_next;
reg [8:0] clk_cnt;
reg [15:0] audio_left, audio_right;

// Counter for the clock divider
assign clk_cnt_next = clk_cnt + 1'b1;

always @(posedge clk or posedge rst)
  if (rst == 1'b1)
    clk_cnt <= 9'd0;
  else
    clk_cnt <= clk_cnt_next;

// Assign divided clock output
assign audio_mclk = clk_cnt[1];
assign audio_lrck = clk_cnt[8];
assign audio_sck = 1'b1; // use internal serial clock mode

// audio input data buffer
always @(posedge clk_cnt[8] or posedge rst)
  if (rst == 1'b1)
  begin
    audio_left <= 16'd0;
    audio_right <= 16'd0;
  end
  else
  begin
    audio_left <= audio_in_left;
    audio_right <= audio_in_right;
  end

always @*
  case (clk_cnt[8:4])
    5'b00000: audio_sdin = audio_right[0];
    5'b00001: audio_sdin = audio_left[15];
    5'b00010: audio_sdin = audio_left[14];
    5'b00011: audio_sdin = audio_left[13];
    5'b00100: audio_sdin = audio_left[12];
    5'b00101: audio_sdin = audio_left[11];
    5'b00110: audio_sdin = audio_left[10];
    5'b00111: audio_sdin = audio_left[9];
    5'b01000: audio_sdin = audio_left[8];
    5'b01001: audio_sdin = audio_left[7];
    5'b01010: audio_sdin = audio_left[6];
    5'b01011: audio_sdin = audio_left[5];
    5'b01100: audio_sdin = audio_left[4];
    5'b01101: audio_sdin = audio_left[3];
    5'b01110: audio_sdin = audio_left[2];
    5'b01111: audio_sdin = audio_left[1];
    5'b10000: audio_sdin = audio_left[0];
    5'b10001: audio_sdin = audio_right[15];
    5'b10010: audio_sdin = audio_right[14];
    5'b10011: audio_sdin = audio_right[13];
    5'b10100: audio_sdin = audio_right[12];
    5'b10101: audio_sdin = audio_right[11];
    5'b10110: audio_sdin = audio_right[10];
    5'b10111: audio_sdin = audio_right[9];
    5'b11000: audio_sdin = audio_right[8];
    5'b11001: audio_sdin = audio_right[7];
    5'b11010: audio_sdin = audio_right[6];
    5'b11011: audio_sdin = audio_right[5];
    5'b11100: audio_sdin = audio_right[4];
    5'b11101: audio_sdin = audio_right[3];
    5'b11110: audio_sdin = audio_right[2];
    5'b11111: audio_sdin = audio_right[1];
    default: audio_sdin = 1'b0;
  endcase

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/26 19:54:13
// Design Name: 
// Module Name: Music
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
`define hhc  32'd1047 // C5
`define hhcs 32'd1109       // C5#
`define hhd  32'd1175 // D5
`define hhe  32'd1319 // E5
`define hc  32'd524   // C4
`define hcs 32'd554         // C4#
`define hd  32'd588   // D4
`define he  32'd660   // E4
`define hf  32'd698   // F4
`define hfs 32'd740         // F4#
`define hg  32'd784   // G4
`define ha  32'd880   // A4 
`define hb  32'd988   // B4 
`define c   32'd262   // C3
`define cs  32'd277         // C3#
`define d   32'd294   // D3
`define e   32'd330   // E3
`define f   32'd349   // F3
`define fs  32'd370         // F3#
`define g   32'd392   // G3
`define gs  32'd415         // G3#
`define a   32'd440   // A3
`define b   32'd494   // B3
`define sil   32'd50000 //slience (over freq.)

module Music_BC (
	input [11:0] ibeatNum,
	input en,
	output reg [31:0] toneL,
    output reg [31:0] toneR
);

    always @* begin
        if(en == 0) begin
        case(ibeatNum)
        12'd0: toneR = `sil;	12'd1: toneR = `sil;
        12'd2: toneR = `sil;	12'd3: toneR = `sil;
        12'd4: toneR = `sil;	12'd5: toneR = `sil;
        12'd6: toneR = `sil;	12'd7: toneR = `sil;
        12'd8: toneR = `sil;	12'd9: toneR = `sil;
        12'd10: toneR = `sil;	12'd11: toneR = `sil;
        12'd12: toneR = `sil;	12'd13: toneR = `sil;
        12'd14: toneR = `sil;	12'd15: toneR = `sil;
        12'd16: toneR = `sil;	12'd17: toneR = `sil;
        12'd18: toneR = `sil;	12'd19: toneR = `sil;
        12'd20: toneR = `sil;	12'd21: toneR = `sil;
        12'd22: toneR = `sil;	12'd23: toneR = `sil;
        12'd24: toneR = `sil;	12'd25: toneR = `sil;
        12'd26: toneR = `sil;	12'd27: toneR = `sil;
        12'd28: toneR = `sil;	12'd29: toneR = `sil;
        12'd30: toneR = `sil;	12'd31: toneR = `sil;
        12'd32: toneR = `sil;	12'd33: toneR = `sil;
        12'd34: toneR = `sil;	12'd35: toneR = `sil;
        12'd36: toneR = `sil;	12'd37: toneR = `sil;
        12'd38: toneR = `sil;	12'd39: toneR = `sil;
        12'd40: toneR = `sil;	12'd41: toneR = `sil;
        12'd42: toneR = `sil;	12'd43: toneR = `sil;
        12'd44: toneR = `sil;	12'd45: toneR = `sil;
        12'd46: toneR = `sil;	12'd47: toneR = `sil;
        12'd48: toneR = `sil;	12'd49: toneR = `sil;
        12'd50: toneR = `sil;	12'd51: toneR = `sil;
        12'd52: toneR = `sil;	12'd53: toneR = `sil;
        12'd54: toneR = `sil;	12'd55: toneR = `sil;
        12'd56: toneR = `sil;	12'd57: toneR = `sil;
        12'd58: toneR = `sil;	12'd59: toneR = `sil;
        12'd60: toneR = `sil;	12'd61: toneR = `sil;
        12'd62: toneR = `sil;	12'd63: toneR = `sil;
        12'd64: toneR = `sil;	12'd65: toneR = `sil;
        12'd66: toneR = `sil;	12'd67: toneR = `sil;
        12'd68: toneR = `sil;	12'd69: toneR = `sil;
        12'd70: toneR = `sil;	12'd71: toneR = `sil;
        12'd72: toneR = `sil;	12'd73: toneR = `sil;
        12'd74: toneR = `sil;	12'd75: toneR = `sil;
        12'd76: toneR = `sil;	12'd77: toneR = `sil;
        12'd78: toneR = `sil;	12'd79: toneR = `sil;
        12'd80: toneR = `sil;	12'd81: toneR = `sil;
        12'd82: toneR = `sil;	12'd83: toneR = `sil;
        12'd84: toneR = `sil;	12'd85: toneR = `sil;
        12'd86: toneR = `sil;	12'd87: toneR = `sil;
        12'd88: toneR = `sil;	12'd89: toneR = `sil;
        12'd90: toneR = `sil;	12'd91: toneR = `sil;
        12'd92: toneR = `sil;	12'd93: toneR = `sil;
        12'd94: toneR = `sil;	12'd95: toneR = `sil;
        12'd96: toneR = `sil;	12'd97: toneR = `sil;
        12'd98: toneR = `sil;	12'd99: toneR = `sil;
        12'd100: toneR = `sil;	12'd101: toneR = `sil;
        12'd102: toneR = `sil;	12'd103: toneR = `sil;
        12'd104: toneR = `sil;	12'd105: toneR = `sil;
        12'd106: toneR = `sil;	12'd107: toneR = `sil;
        12'd108: toneR = `sil;	12'd109: toneR = `sil;
        12'd110: toneR = `sil;	12'd111: toneR = `sil;
        12'd112: toneR = `sil;	12'd113: toneR = `sil;
        12'd114: toneR = `sil;	12'd115: toneR = `sil;
        12'd116: toneR = `sil;	12'd117: toneR = `sil;
        12'd118: toneR = `sil;	12'd119: toneR = `sil;
        12'd120: toneR = `sil;	12'd121: toneR = `sil;
        12'd122: toneR = `sil;	12'd123: toneR = `sil;
        12'd124: toneR = `sil;	12'd125: toneR = `sil;
        12'd126: toneR = `sil;	12'd127: toneR = `sil;
        12'd128: toneR = `c;	12'd129: toneR = `c;
        12'd130: toneR = `c;	12'd131: toneR = `c;
        12'd132: toneR = `c;	12'd133: toneR = `c;
        12'd134: toneR = `c;	12'd135: toneR = `c;
        12'd136: toneR = `e;	12'd137: toneR = `e;
        12'd138: toneR = `e;	12'd139: toneR = `e;
        12'd140: toneR = `e;	12'd141: toneR = `e;
        12'd142: toneR = `e;	12'd143: toneR = `e;
        12'd144: toneR = `g;	12'd145: toneR = `g;
        12'd146: toneR = `g;	12'd147: toneR = `g;
        12'd148: toneR = `g;	12'd149: toneR = `g;
        12'd150: toneR = `g;	12'd151: toneR = `g;
        12'd152: toneR = `g;	12'd153: toneR = `g;
        12'd154: toneR = `g;	12'd155: toneR = `g;
        12'd156: toneR = `g;	12'd157: toneR = `g;
        12'd158: toneR = `g;	12'd159: toneR = `g;
        12'd160: toneR = `e;	12'd161: toneR = `e;
        12'd162: toneR = `e;	12'd163: toneR = `e;
        12'd164: toneR = `e;	12'd165: toneR = `e;
        12'd166: toneR = `e;	12'd167: toneR = `e;
        12'd168: toneR = `gs;	12'd169: toneR = `gs;
        12'd170: toneR = `gs;	12'd171: toneR = `gs;
        12'd172: toneR = `gs;	12'd173: toneR = `gs;
        12'd174: toneR = `gs;	12'd175: toneR = `gs;
        12'd176: toneR = `b;	12'd177: toneR = `b;
        12'd178: toneR = `b;	12'd179: toneR = `b;
        12'd180: toneR = `b;	12'd181: toneR = `b;
        12'd182: toneR = `b;	12'd183: toneR = `b;
        12'd184: toneR = `a;	12'd185: toneR = `a;
        12'd186: toneR = `a;	12'd187: toneR = `a;
        12'd188: toneR = `a;	12'd189: toneR = `a;
        12'd190: toneR = `a;	12'd191: toneR = `a;
        12'd192: toneR = `a;	12'd193: toneR = `a;
        12'd194: toneR = `a;	12'd195: toneR = `a;
        12'd196: toneR = `a;	12'd197: toneR = `a;
        12'd198: toneR = `a;	12'd199: toneR = `a;
        12'd200: toneR = `e;	12'd201: toneR = `e;
        12'd202: toneR = `e;	12'd203: toneR = `e;
        12'd204: toneR = `e;	12'd205: toneR = `e;
        12'd206: toneR = `e;	12'd207: toneR = `e;
        12'd208: toneR = `a;	12'd209: toneR = `a;
        12'd210: toneR = `a;	12'd211: toneR = `a;
        12'd212: toneR = `a;	12'd213: toneR = `a;
        12'd214: toneR = `a;	12'd215: toneR = `a;
        12'd216: toneR = `a;	12'd217: toneR = `a;
        12'd218: toneR = `a;	12'd219: toneR = `a;
        12'd220: toneR = `a;	12'd221: toneR = `a;
        12'd222: toneR = `a;	12'd223: toneR = `a;
        12'd224: toneR = `a;	12'd225: toneR = `a;
        12'd226: toneR = `a;	12'd227: toneR = `a;
        12'd228: toneR = `a;	12'd229: toneR = `a;
        12'd230: toneR = `a;	12'd231: toneR = `a;
        12'd232: toneR = `hc;	12'd233: toneR = `hc;
        12'd234: toneR = `hc;	12'd235: toneR = `hc;
        12'd236: toneR = `hc;	12'd237: toneR = `hc;
        12'd238: toneR = `hc;	12'd239: toneR = `hc;
        12'd240: toneR = `g;	12'd241: toneR = `g;
        12'd242: toneR = `g;	12'd243: toneR = `g;
        12'd244: toneR = `g;	12'd245: toneR = `g;
        12'd246: toneR = `g;	12'd247: toneR = `g;
        12'd248: toneR = `e;	12'd249: toneR = `e;
        12'd250: toneR = `e;	12'd251: toneR = `e;
        12'd252: toneR = `e;	12'd253: toneR = `e;
        12'd254: toneR = `e;	12'd255: toneR = `e;
        12'd256: toneR = `f;	12'd257: toneR = `f;
        12'd258: toneR = `f;	12'd259: toneR = `f;
        12'd260: toneR = `f;	12'd261: toneR = `f;
        12'd262: toneR = `f;	12'd263: toneR = `f;
        12'd264: toneR = `a;	12'd265: toneR = `a;
        12'd266: toneR = `a;	12'd267: toneR = `a;
        12'd268: toneR = `a;	12'd269: toneR = `a;
        12'd270: toneR = `a;	12'd271: toneR = `a;
        12'd272: toneR = `a;	12'd273: toneR = `a;
        12'd274: toneR = `a;	12'd275: toneR = `a;
        12'd276: toneR = `a;	12'd277: toneR = `a;
        12'd278: toneR = `a;	12'd279: toneR = `a;
        12'd280: toneR = `hc;	12'd281: toneR = `hc;
        12'd282: toneR = `hc;	12'd283: toneR = `hc;
        12'd284: toneR = `hc;	12'd285: toneR = `hc;
        12'd286: toneR = `hc;	12'd287: toneR = `hc;
        12'd288: toneR = `g;	12'd289: toneR = `g;
        12'd290: toneR = `g;	12'd291: toneR = `g;
        12'd292: toneR = `g;	12'd293: toneR = `g;
        12'd294: toneR = `sil;	12'd295: toneR = `sil;
        12'd296: toneR = `g;	12'd297: toneR = `g;
        12'd298: toneR = `g;	12'd299: toneR = `g;
        12'd300: toneR = `g;	12'd301: toneR = `g;
        12'd302: toneR = `g;	12'd303: toneR = `g;
        12'd304: toneR = `g;	12'd305: toneR = `g;
        12'd306: toneR = `g;	12'd307: toneR = `g;
        12'd308: toneR = `g;	12'd309: toneR = `g;
        12'd310: toneR = `sil;	12'd311: toneR = `sil;
        12'd312: toneR = `g;	12'd313: toneR = `g;
        12'd314: toneR = `g;	12'd315: toneR = `g;
        12'd316: toneR = `g;	12'd317: toneR = `g;
        12'd318: toneR = `g;	12'd319: toneR = `g;
        12'd320: toneR = `g;	12'd321: toneR = `g;
        12'd322: toneR = `g;	12'd323: toneR = `g;
        12'd324: toneR = `g;	12'd325: toneR = `g;
        12'd326: toneR = `sil;	12'd327: toneR = `sil;
        12'd328: toneR = `g;	12'd329: toneR = `g;
        12'd330: toneR = `g;	12'd331: toneR = `g;
        12'd332: toneR = `g;	12'd333: toneR = `g;
        12'd334: toneR = `g;	12'd335: toneR = `g;
        12'd336: toneR = `e;	12'd337: toneR = `e;
        12'd338: toneR = `e;	12'd339: toneR = `e;
        12'd340: toneR = `e;	12'd341: toneR = `e;
        12'd342: toneR = `e;	12'd343: toneR = `e;
        12'd344: toneR = `g;	12'd345: toneR = `g;
        12'd346: toneR = `g;	12'd347: toneR = `g;
        12'd348: toneR = `g;	12'd349: toneR = `g;
        12'd350: toneR = `g;	12'd351: toneR = `g;
        12'd352: toneR = `b;	12'd353: toneR = `b;
        12'd354: toneR = `b;	12'd355: toneR = `b;
        12'd356: toneR = `b;	12'd357: toneR = `b;
        12'd358: toneR = `b;	12'd359: toneR = `b;
        12'd360: toneR = `b;	12'd361: toneR = `b;
        12'd362: toneR = `b;	12'd363: toneR = `b;
        12'd364: toneR = `b;	12'd365: toneR = `b;
        12'd366: toneR = `b;	12'd367: toneR = `b;
        12'd368: toneR = `b;	12'd369: toneR = `b;
        12'd370: toneR = `b;	12'd371: toneR = `b;
        12'd372: toneR = `b;	12'd373: toneR = `b;
        12'd374: toneR = `b;	12'd375: toneR = `b;
        12'd376: toneR = `b;	12'd377: toneR = `b;
        12'd378: toneR = `b;	12'd379: toneR = `b;
        12'd380: toneR = `b;	12'd381: toneR = `b;
        12'd382: toneR = `b;	12'd383: toneR = `b;
        12'd384: toneR = `c;	12'd385: toneR = `c;
        12'd386: toneR = `c;	12'd387: toneR = `c;
        12'd388: toneR = `c;	12'd389: toneR = `c;
        12'd390: toneR = `c;	12'd391: toneR = `c;
        12'd392: toneR = `e;	12'd393: toneR = `e;
        12'd394: toneR = `e;	12'd395: toneR = `e;
        12'd396: toneR = `e;	12'd397: toneR = `e;
        12'd398: toneR = `e;	12'd399: toneR = `e;
        12'd400: toneR = `g;	12'd401: toneR = `g;
        12'd402: toneR = `g;	12'd403: toneR = `g;
        12'd404: toneR = `g;	12'd405: toneR = `g;
        12'd406: toneR = `g;	12'd407: toneR = `g;
        12'd408: toneR = `g;	12'd409: toneR = `g;
        12'd410: toneR = `g;	12'd411: toneR = `g;
        12'd412: toneR = `g;	12'd413: toneR = `g;
        12'd414: toneR = `g;	12'd415: toneR = `g;
        12'd416: toneR = `e;	12'd417: toneR = `e;
        12'd418: toneR = `e;	12'd419: toneR = `e;
        12'd420: toneR = `e;	12'd421: toneR = `e;
        12'd422: toneR = `e;	12'd423: toneR = `e;
        12'd424: toneR = `gs;	12'd425: toneR = `gs;
        12'd426: toneR = `gs;	12'd427: toneR = `gs;
        12'd428: toneR = `gs;	12'd429: toneR = `gs;
        12'd430: toneR = `gs;	12'd431: toneR = `gs;
        12'd432: toneR = `b;	12'd433: toneR = `b;
        12'd434: toneR = `b;	12'd435: toneR = `b;
        12'd436: toneR = `b;	12'd437: toneR = `b;
        12'd438: toneR = `b;	12'd439: toneR = `b;
        12'd440: toneR = `a;	12'd441: toneR = `a;
        12'd442: toneR = `a;	12'd443: toneR = `a;
        12'd444: toneR = `a;	12'd445: toneR = `a;
        12'd446: toneR = `a;	12'd447: toneR = `a;
        12'd448: toneR = `a;	12'd449: toneR = `a;
        12'd450: toneR = `a;	12'd451: toneR = `a;
        12'd452: toneR = `a;	12'd453: toneR = `a;
        12'd454: toneR = `a;	12'd455: toneR = `a;
        12'd456: toneR = `e;	12'd457: toneR = `e;
        12'd458: toneR = `e;	12'd459: toneR = `e;
        12'd460: toneR = `e;	12'd461: toneR = `e;
        12'd462: toneR = `e;	12'd463: toneR = `e;
        12'd464: toneR = `a;	12'd465: toneR = `a;
        12'd466: toneR = `a;	12'd467: toneR = `a;
        12'd468: toneR = `a;	12'd469: toneR = `a;
        12'd470: toneR = `a;	12'd471: toneR = `a;
        12'd472: toneR = `a;	12'd473: toneR = `a;
        12'd474: toneR = `a;	12'd475: toneR = `a;
        12'd476: toneR = `a;	12'd477: toneR = `a;
        12'd478: toneR = `a;	12'd479: toneR = `a;
        12'd480: toneR = `a;	12'd481: toneR = `a;
        12'd482: toneR = `a;	12'd483: toneR = `a;
        12'd484: toneR = `a;	12'd485: toneR = `a;
        12'd486: toneR = `a;	12'd487: toneR = `a;
        12'd488: toneR = `he;	12'd489: toneR = `he;
        12'd490: toneR = `he;	12'd491: toneR = `he;
        12'd492: toneR = `he;	12'd493: toneR = `he;
        12'd494: toneR = `he;	12'd495: toneR = `he;
        12'd496: toneR = `hc;	12'd497: toneR = `hc;
        12'd498: toneR = `hc;	12'd499: toneR = `hc;
        12'd500: toneR = `hc;	12'd501: toneR = `hc;
        12'd502: toneR = `hc;	12'd503: toneR = `hc;
        12'd504: toneR = `a;	12'd505: toneR = `a;
        12'd506: toneR = `a;	12'd507: toneR = `a;
        12'd508: toneR = `a;	12'd509: toneR = `a;
        12'd510: toneR = `a;	12'd511: toneR = `a;
        12'd512: toneR = `c;	12'd513: toneR = `c;
        12'd514: toneR = `c;	12'd515: toneR = `c;
        12'd516: toneR = `c;	12'd517: toneR = `c;
        12'd518: toneR = `c;	12'd519: toneR = `c;
        12'd520: toneR = `e;	12'd521: toneR = `e;
        12'd522: toneR = `e;	12'd523: toneR = `e;
        12'd524: toneR = `e;	12'd525: toneR = `e;
        12'd526: toneR = `e;	12'd527: toneR = `e;
        12'd528: toneR = `a;	12'd529: toneR = `a;
        12'd530: toneR = `a;	12'd531: toneR = `a;
        12'd532: toneR = `a;	12'd533: toneR = `a;
        12'd534: toneR = `a;	12'd535: toneR = `a;
        12'd536: toneR = `hc;	12'd537: toneR = `hc;
        12'd538: toneR = `hc;	12'd539: toneR = `hc;
        12'd540: toneR = `hc;	12'd541: toneR = `hc;
        12'd542: toneR = `hc;	12'd543: toneR = `hc;
        12'd544: toneR = `d;	12'd545: toneR = `d;
        12'd546: toneR = `d;	12'd547: toneR = `d;
        12'd548: toneR = `d;	12'd549: toneR = `d;
        12'd550: toneR = `d;	12'd551: toneR = `d;
        12'd552: toneR = `g;	12'd553: toneR = `g;
        12'd554: toneR = `g;	12'd555: toneR = `g;
        12'd556: toneR = `g;	12'd557: toneR = `g;
        12'd558: toneR = `g;	12'd559: toneR = `g;
        12'd560: toneR = `b;	12'd561: toneR = `b;
        12'd562: toneR = `b;	12'd563: toneR = `b;
        12'd564: toneR = `b;	12'd565: toneR = `b;
        12'd566: toneR = `b;	12'd567: toneR = `b;
        12'd568: toneR = `sil;	12'd569: toneR = `sil;
        12'd570: toneR = `sil;	12'd571: toneR = `sil;
        12'd572: toneR = `sil;	12'd573: toneR = `sil;
        12'd574: toneR = `sil;	12'd575: toneR = `sil;
        12'd576: toneR = `c;	12'd577: toneR = `c;
        12'd578: toneR = `c;	12'd579: toneR = `c;
        12'd580: toneR = `c;	12'd581: toneR = `c;
        12'd582: toneR = `c;	12'd583: toneR = `c;
        12'd584: toneR = `c;	12'd585: toneR = `c;
        12'd586: toneR = `c;	12'd587: toneR = `c;
        12'd588: toneR = `c;	12'd589: toneR = `c;
        12'd590: toneR = `c;	12'd591: toneR = `c;
        12'd592: toneR = `c;	12'd593: toneR = `c;
        12'd594: toneR = `c;	12'd595: toneR = `c;
        12'd596: toneR = `c;	12'd597: toneR = `c;
        12'd598: toneR = `c;	12'd599: toneR = `c;
        12'd600: toneR = `c;	12'd601: toneR = `c;
        12'd602: toneR = `c;	12'd603: toneR = `c;
        12'd604: toneR = `c;	12'd605: toneR = `c;
        12'd606: toneR = `c;	12'd607: toneR = `c;
        default: toneR = `sil;
        endcase
        end else begin
            toneR = `sil;
        end
    end

    always @(*) begin
        if(en==0)begin
        case(ibeatNum)
        12'd0: toneL = `c;  	12'd1: toneL = `c;
        12'd2: toneL = `c;  	12'd3: toneL = `c;
        12'd4: toneL = `c;	    12'd5: toneL = `c;
        12'd6: toneL = `c;  	12'd7: toneL = `c;
        12'd8: toneL = `sil;	12'd9: toneL = `sil;
        12'd10: toneL = `sil;	12'd11: toneL = `sil;
        12'd12: toneL = `sil;	12'd13: toneL = `sil;
        12'd14: toneL = `sil;	12'd15: toneL = `sil;
        12'd16: toneL = `c;	    12'd17: toneL = `c;
        12'd18: toneL = `c;	    12'd19: toneL = `c;
        12'd20: toneL = `c;	    12'd21: toneL = `c;
        12'd22: toneL = `c;	    12'd23: toneL = `c;
        12'd24: toneL = `sil;	12'd25: toneL = `sil;
        12'd26: toneL = `sil;	12'd27: toneL = `sil;
        12'd28: toneL = `sil;	12'd29: toneL = `sil;
        12'd30: toneL = `sil;	12'd31: toneL = `sil;
        12'd32: toneL = `c;	    12'd33: toneL = `c;
        12'd34: toneL = `c;	    12'd35: toneL = `c;
        12'd36: toneL = `c;	    12'd37: toneL = `c;
        12'd38: toneL = `c;	    12'd39: toneL = `c;
        12'd40: toneL = `sil;	12'd41: toneL = `sil;
        12'd42: toneL = `sil;	12'd43: toneL = `sil;
        12'd44: toneL = `sil;	12'd45: toneL = `sil;
        12'd46: toneL = `sil;	12'd47: toneL = `sil;
        12'd48: toneL = `c;	    12'd49: toneL = `c;
        12'd50: toneL = `c;	    12'd51: toneL = `c;
        12'd52: toneL = `c;	    12'd53: toneL = `c;
        12'd54: toneL = `c;	    12'd55: toneL = `c;
        12'd56: toneL = `sil;	12'd57: toneL = `sil;
        12'd58: toneL = `sil;	12'd59: toneL = `sil;
        12'd60: toneL = `sil;	12'd61: toneL = `sil;
        12'd62: toneL = `sil;	12'd63: toneL = `sil;
        12'd64: toneL = `c;	    12'd65: toneL = `c;
        12'd66: toneL = `c;	    12'd67: toneL = `c;
        12'd68: toneL = `c;	    12'd69: toneL = `c;
        12'd70: toneL = `c;	    12'd71: toneL = `c;
        12'd72: toneL = `sil;	12'd73: toneL = `sil;
        12'd74: toneL = `sil;	12'd75: toneL = `sil;
        12'd76: toneL = `sil;	12'd77: toneL = `sil;
        12'd78: toneL = `sil;	12'd79: toneL = `sil;
        12'd80: toneL = `c;	    12'd81: toneL = `c;
        12'd82: toneL = `c;	    12'd83: toneL = `c;
        12'd84: toneL = `c;	    12'd85: toneL = `c;
        12'd86: toneL = `c;	    12'd87: toneL = `c;
        12'd88: toneL = `sil;	12'd89: toneL = `sil;
        12'd90: toneL = `sil;	12'd91: toneL = `sil;
        12'd92: toneL = `sil;	12'd93: toneL = `sil;
        12'd94: toneL = `sil;	12'd95: toneL = `sil;
        12'd96: toneL = `d;	    12'd97: toneL = `d;
        12'd98: toneL = `d; 	12'd99: toneL = `d;
        12'd100: toneL = `d;	12'd101: toneL = `d;
        12'd102: toneL = `d;	12'd103: toneL = `d;
        12'd104: toneL = `g;	12'd105: toneL = `g;
        12'd106: toneL = `g;	12'd107: toneL = `g;
        12'd108: toneL = `g;	12'd109: toneL = `g;
        12'd110: toneL = `g;	12'd111: toneL = `g;
        12'd112: toneL = `hf;	12'd113: toneL = `hf;
        12'd114: toneL = `hf;	12'd115: toneL = `hf;
        12'd116: toneL = `hf;	12'd117: toneL = `hf;
        12'd118: toneL = `hf;	12'd119: toneL = `hf;
        12'd120: toneL = `he;	12'd121: toneL = `he;
        12'd122: toneL = `he;	12'd123: toneL = `he;
        12'd124: toneL = `he;	12'd125: toneL = `he;
        12'd126: toneL = `he;	12'd127: toneL = `he;
        12'd128: toneL = `he;	12'd129: toneL = `he;
        12'd130: toneL = `he;	12'd131: toneL = `he;
        12'd132: toneL = `he;	12'd133: toneL = `he;
        12'd134: toneL = `he;	12'd135: toneL = `he;
        12'd136: toneL = `he;	12'd137: toneL = `he;
        12'd138: toneL = `he;	12'd139: toneL = `he;
        12'd140: toneL = `he;	12'd141: toneL = `he;
        12'd142: toneL = `he;	12'd143: toneL = `he;
        12'd144: toneL = `hf;	12'd145: toneL = `hf;
        12'd146: toneL = `hf;	12'd147: toneL = `hf;
        12'd148: toneL = `hf;	12'd149: toneL = `hf;
        12'd150: toneL = `hf;	12'd151: toneL = `hf;
        12'd152: toneL = `he;	12'd153: toneL = `he;
        12'd154: toneL = `he;	12'd155: toneL = `he;
        12'd156: toneL = `he;	12'd157: toneL = `he;
        12'd158: toneL = `he;	12'd159: toneL = `he;
        12'd160: toneL = `he;	12'd161: toneL = `he;
        12'd162: toneL = `he;	12'd163: toneL = `he;
        12'd164: toneL = `he;	12'd165: toneL = `he;
        12'd166: toneL = `he;	12'd167: toneL = `he;
        12'd168: toneL = `hd;	12'd169: toneL = `hd;
        12'd170: toneL = `hd;	12'd171: toneL = `hd;
        12'd172: toneL = `hd;	12'd173: toneL = `hd;
        12'd174: toneL = `hd;	12'd175: toneL = `hd;
        12'd176: toneL = `hd;	12'd177: toneL = `hd;
        12'd178: toneL = `hd;	12'd179: toneL = `hd;
        12'd180: toneL = `hd;	12'd181: toneL = `hd;
        12'd182: toneL = `hd;	12'd183: toneL = `hd;
        12'd184: toneL = `hc;	12'd185: toneL = `hc;
        12'd186: toneL = `hc;	12'd187: toneL = `hc;
        12'd188: toneL = `hc;	12'd189: toneL = `hc;
        12'd190: toneL = `hc;	12'd191: toneL = `hc;
        12'd192: toneL = `hc;	12'd193: toneL = `hc;
        12'd194: toneL = `hc;	12'd195: toneL = `hc;
        12'd196: toneL = `hc;	12'd197: toneL = `hc;
        12'd198: toneL = `hc;	12'd199: toneL = `hc;
        12'd200: toneL = `hc;	12'd201: toneL = `hc;
        12'd202: toneL = `hc;	12'd203: toneL = `hc;
        12'd204: toneL = `hc;	12'd205: toneL = `hc;
        12'd206: toneL = `hc;	12'd207: toneL = `hc;
        12'd208: toneL = `hd;	12'd209: toneL = `hd;
        12'd210: toneL = `hd;	12'd211: toneL = `hd;
        12'd212: toneL = `hd;	12'd213: toneL = `hd;
        12'd214: toneL = `hd;	12'd215: toneL = `hd;
        12'd216: toneL = `he;	12'd217: toneL = `he;
        12'd218: toneL = `he;	12'd219: toneL = `he;
        12'd220: toneL = `he;	12'd221: toneL = `he;
        12'd222: toneL = `he;	12'd223: toneL = `he;
        12'd224: toneL = `he;	12'd225: toneL = `he;
        12'd226: toneL = `he;	12'd227: toneL = `he;
        12'd228: toneL = `he;	12'd229: toneL = `he;
        12'd230: toneL = `he;	12'd231: toneL = `he;
        12'd232: toneL = `hc;	12'd233: toneL = `hc;
        12'd234: toneL = `hc;	12'd235: toneL = `hc;
        12'd236: toneL = `hc;	12'd237: toneL = `hc;
        12'd238: toneL = `hc;	12'd239: toneL = `hc;
        12'd240: toneL = `hc;	12'd241: toneL = `hc;
        12'd242: toneL = `hc;	12'd243: toneL = `hc;
        12'd244: toneL = `hc;	12'd245: toneL = `hc;
        12'd246: toneL = `hc;	12'd247: toneL = `hc;
        12'd248: toneL = `g;	12'd249: toneL = `g;
        12'd250: toneL = `g;	12'd251: toneL = `g;
        12'd252: toneL = `g;	12'd253: toneL = `g;
        12'd254: toneL = `g;	12'd255: toneL = `g;
        12'd256: toneL = `a;	12'd257: toneL = `a;
        12'd258: toneL = `a;	12'd259: toneL = `a;
        12'd260: toneL = `a;	12'd261: toneL = `a;
        12'd262: toneL = `a;	12'd263: toneL = `a;
        12'd264: toneL = `a;	12'd265: toneL = `a;
        12'd266: toneL = `a;	12'd267: toneL = `a;
        12'd268: toneL = `a;	12'd269: toneL = `a;
        12'd270: toneL = `a;	12'd271: toneL = `a;
        12'd272: toneL = `hc;	12'd273: toneL = `hc;
        12'd274: toneL = `hc;	12'd275: toneL = `hc;
        12'd276: toneL = `hc;	12'd277: toneL = `hc;
        12'd278: toneL = `hc;	12'd279: toneL = `hc;
        12'd280: toneL = `hg;	12'd281: toneL = `hg;
        12'd282: toneL = `hg;	12'd283: toneL = `hg;
        12'd284: toneL = `hg;	12'd285: toneL = `hg;
        12'd286: toneL = `hg;	12'd287: toneL = `hg;
        12'd288: toneL = `hg;	12'd289: toneL = `hg;
        12'd290: toneL = `hg;	12'd291: toneL = `hg;
        12'd292: toneL = `hg;	12'd293: toneL = `hg;
        12'd294: toneL = `hg;	12'd295: toneL = `hg;
        12'd296: toneL = `hc;	12'd297: toneL = `hc;
        12'd298: toneL = `hc;	12'd299: toneL = `hc;
        12'd300: toneL = `hc;	12'd301: toneL = `hc;
        12'd302: toneL = `hc;	12'd303: toneL = `hc;
        12'd304: toneL = `he;	12'd305: toneL = `he;
        12'd306: toneL = `he;	12'd307: toneL = `he;
        12'd308: toneL = `he;	12'd309: toneL = `he;
        12'd310: toneL = `he;	12'd311: toneL = `he;
        12'd312: toneL = `he;	12'd313: toneL = `he;
        12'd314: toneL = `he;	12'd315: toneL = `he;
        12'd316: toneL = `he;	12'd317: toneL = `he;
        12'd318: toneL = `he;	12'd319: toneL = `he;
        12'd320: toneL = `he;	12'd321: toneL = `he;
        12'd322: toneL = `he;	12'd323: toneL = `he;
        12'd324: toneL = `he;	12'd325: toneL = `he;
        12'd326: toneL = `he;	12'd327: toneL = `he;
        12'd328: toneL = `he;	12'd329: toneL = `he;
        12'd330: toneL = `he;	12'd331: toneL = `he;
        12'd332: toneL = `he;	12'd333: toneL = `he;
        12'd334: toneL = `he;	12'd335: toneL = `he;
        12'd336: toneL = `he;	12'd337: toneL = `he;
        12'd338: toneL = `he;	12'd339: toneL = `he;
        12'd340: toneL = `he;	12'd341: toneL = `he;
        12'd342: toneL = `he;	12'd343: toneL = `he;
        12'd344: toneL = `he;	12'd345: toneL = `he;
        12'd346: toneL = `he;	12'd347: toneL = `he;
        12'd348: toneL = `he;	12'd349: toneL = `he;
        12'd350: toneL = `he;	12'd351: toneL = `he;
        12'd352: toneL = `d;	12'd353: toneL = `d;
        12'd354: toneL = `d;	12'd355: toneL = `d;
        12'd356: toneL = `d;	12'd357: toneL = `d;
        12'd358: toneL = `d;	12'd359: toneL = `d;
        12'd360: toneL = `g;	12'd361: toneL = `g;
        12'd362: toneL = `g;	12'd363: toneL = `g;
        12'd364: toneL = `g;	12'd365: toneL = `g;
        12'd366: toneL = `g;	12'd367: toneL = `g;
        12'd368: toneL = `hf;	12'd369: toneL = `hf;
        12'd370: toneL = `hf;	12'd371: toneL = `hf;
        12'd372: toneL = `hf;	12'd373: toneL = `hf;
        12'd374: toneL = `hf;	12'd375: toneL = `hf;
        12'd376: toneL = `he;	12'd377: toneL = `he;
        12'd378: toneL = `he;	12'd379: toneL = `he;
        12'd380: toneL = `he;	12'd381: toneL = `he;
        12'd382: toneL = `he;	12'd383: toneL = `he;
        12'd384: toneL = `he;	12'd385: toneL = `he;
        12'd386: toneL = `he;	12'd387: toneL = `he;
        12'd388: toneL = `he;	12'd389: toneL = `he;
        12'd390: toneL = `he;	12'd391: toneL = `he;
        12'd392: toneL = `he;	12'd393: toneL = `he;
        12'd394: toneL = `he;	12'd395: toneL = `he;
        12'd396: toneL = `he;	12'd397: toneL = `he;
        12'd398: toneL = `he;	12'd399: toneL = `he;
        12'd400: toneL = `hf;	12'd401: toneL = `hf;
        12'd402: toneL = `hf;	12'd403: toneL = `hf;
        12'd404: toneL = `hf;	12'd405: toneL = `hf;
        12'd406: toneL = `hf;	12'd407: toneL = `hf;
        12'd408: toneL = `he;	12'd409: toneL = `he;
        12'd410: toneL = `he;	12'd411: toneL = `he;
        12'd412: toneL = `he;	12'd413: toneL = `he;
        12'd414: toneL = `he;	12'd415: toneL = `he;
        12'd416: toneL = `he;	12'd417: toneL = `he;
        12'd418: toneL = `he;	12'd419: toneL = `he;
        12'd420: toneL = `he;	12'd421: toneL = `he;
        12'd422: toneL = `he;	12'd423: toneL = `he;
        12'd424: toneL = `hd;	12'd425: toneL = `hd;
        12'd426: toneL = `hd;	12'd427: toneL = `hd;
        12'd428: toneL = `hd;	12'd429: toneL = `hd;
        12'd430: toneL = `hd;	12'd431: toneL = `hd;
        12'd432: toneL = `hd;	12'd433: toneL = `hd;
        12'd434: toneL = `hd;	12'd435: toneL = `hd;
        12'd436: toneL = `hd;	12'd437: toneL = `hd;
        12'd438: toneL = `hd;	12'd439: toneL = `hd;
        12'd440: toneL = `hc;	12'd441: toneL = `hc;
        12'd442: toneL = `hc;	12'd443: toneL = `hc;
        12'd444: toneL = `hc;	12'd445: toneL = `hc;
        12'd446: toneL = `hc;	12'd447: toneL = `hc;
        12'd448: toneL = `hc;	12'd449: toneL = `hc;
        12'd450: toneL = `hc;	12'd451: toneL = `hc;
        12'd452: toneL = `hc;	12'd453: toneL = `hc;
        12'd454: toneL = `hc;	12'd455: toneL = `hc;
        12'd456: toneL = `hc;	12'd457: toneL = `hc;
        12'd458: toneL = `hc;	12'd459: toneL = `hc;
        12'd460: toneL = `hc;	12'd461: toneL = `hc;
        12'd462: toneL = `hc;	12'd463: toneL = `hc;
        12'd464: toneL = `hd;	12'd465: toneL = `hd;
        12'd466: toneL = `hd;	12'd467: toneL = `hd;
        12'd468: toneL = `hd;	12'd469: toneL = `hd;
        12'd470: toneL = `hd;	12'd471: toneL = `hd;
        12'd472: toneL = `he;	12'd473: toneL = `he;
        12'd474: toneL = `he;	12'd475: toneL = `he;
        12'd476: toneL = `he;	12'd477: toneL = `he;
        12'd478: toneL = `he;	12'd479: toneL = `he;
        12'd480: toneL = `he;	12'd481: toneL = `he;
        12'd482: toneL = `he;	12'd483: toneL = `he;
        12'd484: toneL = `he;	12'd485: toneL = `he;
        12'd486: toneL = `he;	12'd487: toneL = `he;
        12'd488: toneL = `ha;	12'd489: toneL = `ha;
        12'd490: toneL = `ha;	12'd491: toneL = `ha;
        12'd492: toneL = `ha;	12'd493: toneL = `ha;
        12'd494: toneL = `ha;	12'd495: toneL = `ha;
        12'd496: toneL = `ha;	12'd497: toneL = `ha;
        12'd498: toneL = `ha;	12'd499: toneL = `ha;
        12'd500: toneL = `ha;	12'd501: toneL = `ha;
        12'd502: toneL = `ha;	12'd503: toneL = `ha;
        12'd504: toneL = `ha;	12'd505: toneL = `ha;
        12'd506: toneL = `ha;	12'd507: toneL = `ha;
        12'd508: toneL = `ha;	12'd509: toneL = `ha;
        12'd510: toneL = `ha;	12'd511: toneL = `ha;
        12'd512: toneL = `he;	12'd513: toneL = `he;
        12'd514: toneL = `he;	12'd515: toneL = `he;
        12'd516: toneL = `he;	12'd517: toneL = `he;
        12'd518: toneL = `he;	12'd519: toneL = `he;
        12'd520: toneL = `he;	12'd521: toneL = `he;
        12'd522: toneL = `he;	12'd523: toneL = `he;
        12'd524: toneL = `he;	12'd525: toneL = `he;
        12'd526: toneL = `he;	12'd527: toneL = `he;
        12'd528: toneL = `ha;	12'd529: toneL = `ha;
        12'd530: toneL = `ha;	12'd531: toneL = `ha;
        12'd532: toneL = `ha;	12'd533: toneL = `ha;
        12'd534: toneL = `ha;	12'd535: toneL = `ha;
        12'd536: toneL = `hc;	12'd537: toneL = `hc;
        12'd538: toneL = `hc;	12'd539: toneL = `hc;
        12'd540: toneL = `hc;	12'd541: toneL = `hc;
        12'd542: toneL = `hc;	12'd543: toneL = `hc;
        12'd544: toneL = `hc;	12'd545: toneL = `hc;
        12'd546: toneL = `hc;	12'd547: toneL = `hc;
        12'd548: toneL = `hc;	12'd549: toneL = `hc;
        12'd550: toneL = `hc;	12'd551: toneL = `hc;
        12'd552: toneL = `hd;	12'd553: toneL = `hd;
        12'd554: toneL = `hd;	12'd555: toneL = `hd;
        12'd556: toneL = `hd;	12'd557: toneL = `hd;
        12'd558: toneL = `hd;	12'd559: toneL = `hd;
        12'd560: toneL = `hd;	12'd561: toneL = `hd;
        12'd562: toneL = `hd;	12'd563: toneL = `hd;
        12'd564: toneL = `hd;	12'd565: toneL = `hd;
        12'd566: toneL = `hd;	12'd567: toneL = `hd;
        12'd568: toneL = `hc;	12'd569: toneL = `hc;
        12'd570: toneL = `hc;	12'd571: toneL = `hc;
        12'd572: toneL = `hc;	12'd573: toneL = `hc;
        12'd574: toneL = `hc;	12'd575: toneL = `hc;
        12'd576: toneL = `hc;	12'd577: toneL = `hc;
        12'd578: toneL = `hc;	12'd579: toneL = `hc;
        12'd580: toneL = `hc;	12'd581: toneL = `hc;
        12'd582: toneL = `hc;	12'd583: toneL = `hc;
        12'd584: toneL = `hc;	12'd585: toneL = `hc;
        12'd586: toneL = `hc;	12'd587: toneL = `hc;
        12'd588: toneL = `hc;	12'd589: toneL = `hc;
        12'd590: toneL = `hc;	12'd591: toneL = `hc;
        12'd592: toneL = `hc;	12'd593: toneL = `hc;
        12'd594: toneL = `hc;	12'd595: toneL = `hc;
        12'd596: toneL = `hc;	12'd597: toneL = `hc;
        12'd598: toneL = `hc;	12'd599: toneL = `hc;
        12'd600: toneL = `hc;	12'd601: toneL = `hc;
        12'd602: toneL = `hc;	12'd603: toneL = `hc;
        12'd604: toneL = `hc;	12'd605: toneL = `hc;
        12'd606: toneL = `hc;	12'd607: toneL = `hc;

        default : toneL = `sil;
        endcase
        end
        else begin
            toneL = `sil;
        end
    end
endmodule


module Music_JB (
	input [11:0] ibeatNum,
	input en,
	output reg [31:0] toneL,
    output reg [31:0] toneR
);
    // Every eighth note accounts for 8 clocks
    always @* begin
        if(en == 0) begin
            case(ibeatNum)
            12'd0: toneR = `a;	12'd1: toneR = `a;
            12'd2: toneR = `a;	12'd3: toneR = `a;
            12'd4: toneR = `a;	12'd5: toneR = `a;
            12'd6: toneR = `a;	12'd7: toneR = `a;
            12'd8: toneR = `sil;	12'd9: toneR = `sil;
            12'd10: toneR = `sil;	12'd11: toneR = `sil;
            12'd12: toneR = `sil;	12'd13: toneR = `sil;
            12'd14: toneR = `sil;	12'd15: toneR = `sil;
            12'd16: toneR = `a;	12'd17: toneR = `a;
            12'd18: toneR = `a;	12'd19: toneR = `a;
            12'd20: toneR = `a;	12'd21: toneR = `a;
            12'd22: toneR = `a;	12'd23: toneR = `a;
            12'd24: toneR = `sil;	12'd25: toneR = `sil;
            12'd26: toneR = `sil;	12'd27: toneR = `sil;
            12'd28: toneR = `sil;	12'd29: toneR = `sil;
            12'd30: toneR = `sil;	12'd31: toneR = `sil;
            12'd32: toneR = `a;	12'd33: toneR = `a;
            12'd34: toneR = `a;	12'd35: toneR = `a;
            12'd36: toneR = `a;	12'd37: toneR = `a;
            12'd38: toneR = `a;	12'd39: toneR = `a;
            12'd40: toneR = `sil;	12'd41: toneR = `sil;
            12'd42: toneR = `sil;	12'd43: toneR = `sil;
            12'd44: toneR = `sil;	12'd45: toneR = `sil;
            12'd46: toneR = `sil;	12'd47: toneR = `sil;
            12'd48: toneR = `a;	12'd49: toneR = `a;
            12'd50: toneR = `a;	12'd51: toneR = `a;
            12'd52: toneR = `a;	12'd53: toneR = `a;
            12'd54: toneR = `a;	12'd55: toneR = `a;
            12'd56: toneR = `sil;	12'd57: toneR = `sil;
            12'd58: toneR = `sil;	12'd59: toneR = `sil;
            12'd60: toneR = `sil;	12'd61: toneR = `sil;
            12'd62: toneR = `sil;	12'd63: toneR = `sil;
            12'd64: toneR = `d;	12'd65: toneR = `d;
            12'd66: toneR = `d;	12'd67: toneR = `d;
            12'd68: toneR = `d;	12'd69: toneR = `d;
            12'd70: toneR = `d;	12'd71: toneR = `d;
            12'd72: toneR = `a;	12'd73: toneR = `a;
            12'd74: toneR = `a;	12'd75: toneR = `a;
            12'd76: toneR = `a;	12'd77: toneR = `a;
            12'd78: toneR = `a;	12'd79: toneR = `a;
            12'd80: toneR = `fs;	12'd81: toneR = `fs;
            12'd82: toneR = `fs;	12'd83: toneR = `fs;
            12'd84: toneR = `fs;	12'd85: toneR = `fs;
            12'd86: toneR = `fs;	12'd87: toneR = `fs;
            12'd88: toneR = `a;	12'd89: toneR = `a;
            12'd90: toneR = `a;	12'd91: toneR = `a;
            12'd92: toneR = `a;	12'd93: toneR = `a;
            12'd94: toneR = `a;	12'd95: toneR = `a;
            12'd96: toneR = `d;	12'd97: toneR = `d;
            12'd98: toneR = `d;	12'd99: toneR = `d;
            12'd100: toneR = `d;	12'd101: toneR = `d;
            12'd102: toneR = `d;	12'd103: toneR = `d;
            12'd104: toneR = `a;	12'd105: toneR = `a;
            12'd106: toneR = `a;	12'd107: toneR = `a;
            12'd108: toneR = `a;	12'd109: toneR = `a;
            12'd110: toneR = `a;	12'd111: toneR = `a;
            12'd112: toneR = `fs;	12'd113: toneR = `fs;
            12'd114: toneR = `fs;	12'd115: toneR = `fs;
            12'd116: toneR = `fs;	12'd117: toneR = `fs;
            12'd118: toneR = `fs;	12'd119: toneR = `fs;
            12'd120: toneR = `a;	12'd121: toneR = `a;
            12'd122: toneR = `a;	12'd123: toneR = `a;
            12'd124: toneR = `a;	12'd125: toneR = `a;
            12'd126: toneR = `a;	12'd127: toneR = `a;
            12'd128: toneR = `d;	12'd129: toneR = `d;
            12'd130: toneR = `d;	12'd131: toneR = `d;
            12'd132: toneR = `d;	12'd133: toneR = `d;
            12'd134: toneR = `d;	12'd135: toneR = `d;
            12'd136: toneR = `a;	12'd137: toneR = `a;
            12'd138: toneR = `a;	12'd139: toneR = `a;
            12'd140: toneR = `a;	12'd141: toneR = `a;
            12'd142: toneR = `a;	12'd143: toneR = `a;
            12'd144: toneR = `fs;	12'd145: toneR = `fs;
            12'd146: toneR = `fs;	12'd147: toneR = `fs;
            12'd148: toneR = `fs;	12'd149: toneR = `fs;
            12'd150: toneR = `fs;	12'd151: toneR = `fs;
            12'd152: toneR = `a;	12'd153: toneR = `a;
            12'd154: toneR = `a;	12'd155: toneR = `a;
            12'd156: toneR = `a;	12'd157: toneR = `a;
            12'd158: toneR = `a;	12'd159: toneR = `a;
            12'd160: toneR = `d;	12'd161: toneR = `d;
            12'd162: toneR = `d;	12'd163: toneR = `d;
            12'd164: toneR = `d;	12'd165: toneR = `d;
            12'd166: toneR = `d;	12'd167: toneR = `d;
            12'd168: toneR = `a;	12'd169: toneR = `a;
            12'd170: toneR = `a;	12'd171: toneR = `a;
            12'd172: toneR = `a;	12'd173: toneR = `a;
            12'd174: toneR = `a;	12'd175: toneR = `a;
            12'd176: toneR = `fs;	12'd177: toneR = `fs;
            12'd178: toneR = `fs;	12'd179: toneR = `fs;
            12'd180: toneR = `fs;	12'd181: toneR = `fs;
            12'd182: toneR = `fs;	12'd183: toneR = `fs;
            12'd184: toneR = `a;	12'd185: toneR = `a;
            12'd186: toneR = `a;	12'd187: toneR = `a;
            12'd188: toneR = `a;	12'd189: toneR = `a;
            12'd190: toneR = `a;	12'd191: toneR = `a;
            12'd192: toneR = `d;	12'd193: toneR = `d;
            12'd194: toneR = `d;	12'd195: toneR = `d;
            12'd196: toneR = `d;	12'd197: toneR = `d;
            12'd198: toneR = `d;	12'd199: toneR = `d;
            12'd200: toneR = `b;	12'd201: toneR = `b;
            12'd202: toneR = `b;	12'd203: toneR = `b;
            12'd204: toneR = `b;	12'd205: toneR = `b;
            12'd206: toneR = `b;	12'd207: toneR = `b;
            12'd208: toneR = `g;	12'd209: toneR = `g;
            12'd210: toneR = `g;	12'd211: toneR = `g;
            12'd212: toneR = `g;	12'd213: toneR = `g;
            12'd214: toneR = `g;	12'd215: toneR = `g;
            12'd216: toneR = `b;	12'd217: toneR = `b;
            12'd218: toneR = `b;	12'd219: toneR = `b;
            12'd220: toneR = `b;	12'd221: toneR = `b;
            12'd222: toneR = `b;	12'd223: toneR = `b;
            12'd224: toneR = `b;	12'd225: toneR = `b;
            12'd226: toneR = `b;	12'd227: toneR = `b;
            12'd228: toneR = `b;	12'd229: toneR = `b;
            12'd230: toneR = `b;	12'd231: toneR = `b;
            12'd232: toneR = `a;	12'd233: toneR = `a;
            12'd234: toneR = `a;	12'd235: toneR = `a;
            12'd236: toneR = `a;	12'd237: toneR = `a;
            12'd238: toneR = `a;	12'd239: toneR = `a;
            12'd240: toneR = `fs;	12'd241: toneR = `fs;
            12'd242: toneR = `fs;	12'd243: toneR = `fs;
            12'd244: toneR = `fs;	12'd245: toneR = `fs;
            12'd246: toneR = `fs;	12'd247: toneR = `fs;
            12'd248: toneR = `a;	12'd249: toneR = `a;
            12'd250: toneR = `a;	12'd251: toneR = `a;
            12'd252: toneR = `a;	12'd253: toneR = `a;
            12'd254: toneR = `a;	12'd255: toneR = `a;
            12'd256: toneR = `d;	12'd257: toneR = `d;
            12'd258: toneR = `d;	12'd259: toneR = `d;
            12'd260: toneR = `d;	12'd261: toneR = `d;
            12'd262: toneR = `d;	12'd263: toneR = `d;
            12'd264: toneR = `d;	12'd265: toneR = `d;
            12'd266: toneR = `d;	12'd267: toneR = `d;
            12'd268: toneR = `d;	12'd269: toneR = `d;
            12'd270: toneR = `d;	12'd271: toneR = `d;
            12'd272: toneR = `b;	12'd273: toneR = `b;
            12'd274: toneR = `b;	12'd275: toneR = `b;
            12'd276: toneR = `b;	12'd277: toneR = `b;
            12'd278: toneR = `b;	12'd279: toneR = `b;
            12'd280: toneR = `b;	12'd281: toneR = `b;
            12'd282: toneR = `b;	12'd283: toneR = `b;
            12'd284: toneR = `b;	12'd285: toneR = `b;
            12'd286: toneR = `b;	12'd287: toneR = `b;
            12'd288: toneR = `a;	12'd289: toneR = `a;
            12'd290: toneR = `a;	12'd291: toneR = `a;
            12'd292: toneR = `a;	12'd293: toneR = `a;
            12'd294: toneR = `a;	12'd295: toneR = `a;
            12'd296: toneR = `g;	12'd297: toneR = `g;
            12'd298: toneR = `g;	12'd299: toneR = `g;
            12'd300: toneR = `g;	12'd301: toneR = `g;
            12'd302: toneR = `g;	12'd303: toneR = `g;
            12'd304: toneR = `fs;	12'd305: toneR = `fs;
            12'd306: toneR = `fs;	12'd307: toneR = `fs;
            12'd308: toneR = `fs;	12'd309: toneR = `fs;
            12'd310: toneR = `fs;	12'd311: toneR = `fs;
            12'd312: toneR = `f;	12'd313: toneR = `f;
            12'd314: toneR = `f;	12'd315: toneR = `f;
            12'd316: toneR = `f;	12'd317: toneR = `f;
            12'd318: toneR = `f;	12'd319: toneR = `f;
            12'd320: toneR = `d;	12'd321: toneR = `d;
            12'd322: toneR = `d;	12'd323: toneR = `d;
            12'd324: toneR = `d;	12'd325: toneR = `d;
            12'd326: toneR = `d;	12'd327: toneR = `d;
            12'd328: toneR = `a;	12'd329: toneR = `a;
            12'd330: toneR = `a;	12'd331: toneR = `a;
            12'd332: toneR = `a;	12'd333: toneR = `a;
            12'd334: toneR = `a;	12'd335: toneR = `a;
            12'd336: toneR = `fs;	12'd337: toneR = `fs;
            12'd338: toneR = `fs;	12'd339: toneR = `fs;
            12'd340: toneR = `fs;	12'd341: toneR = `fs;
            12'd342: toneR = `fs;	12'd343: toneR = `fs;
            12'd344: toneR = `a;	12'd345: toneR = `a;
            12'd346: toneR = `a;	12'd347: toneR = `a;
            12'd348: toneR = `a;	12'd349: toneR = `a;
            12'd350: toneR = `a;	12'd351: toneR = `a;
            12'd352: toneR = `d;	12'd353: toneR = `d;
            12'd354: toneR = `d;	12'd355: toneR = `d;
            12'd356: toneR = `d;	12'd357: toneR = `d;
            12'd358: toneR = `d;	12'd359: toneR = `d;
            12'd360: toneR = `a;	12'd361: toneR = `a;
            12'd362: toneR = `a;	12'd363: toneR = `a;
            12'd364: toneR = `a;	12'd365: toneR = `a;
            12'd366: toneR = `a;	12'd367: toneR = `a;
            12'd368: toneR = `fs;	12'd369: toneR = `fs;
            12'd370: toneR = `fs;	12'd371: toneR = `fs;
            12'd372: toneR = `fs;	12'd373: toneR = `fs;
            12'd374: toneR = `fs;	12'd375: toneR = `fs;
            12'd376: toneR = `a;	12'd377: toneR = `a;
            12'd378: toneR = `a;	12'd379: toneR = `a;
            12'd380: toneR = `a;	12'd381: toneR = `a;
            12'd382: toneR = `a;	12'd383: toneR = `a;
            12'd384: toneR = `d;	12'd385: toneR = `d;
            12'd386: toneR = `d;	12'd387: toneR = `d;
            12'd388: toneR = `d;	12'd389: toneR = `d;
            12'd390: toneR = `d;	12'd391: toneR = `d;
            12'd392: toneR = `a;	12'd393: toneR = `a;
            12'd394: toneR = `a;	12'd395: toneR = `a;
            12'd396: toneR = `a;	12'd397: toneR = `a;
            12'd398: toneR = `a;	12'd399: toneR = `a;
            12'd400: toneR = `fs;	12'd401: toneR = `fs;
            12'd402: toneR = `fs;	12'd403: toneR = `fs;
            12'd404: toneR = `fs;	12'd405: toneR = `fs;
            12'd406: toneR = `fs;	12'd407: toneR = `fs;
            12'd408: toneR = `a;	12'd409: toneR = `a;
            12'd410: toneR = `a;	12'd411: toneR = `a;
            12'd412: toneR = `a;	12'd413: toneR = `a;
            12'd414: toneR = `a;	12'd415: toneR = `a;
            12'd416: toneR = `d;	12'd417: toneR = `d;
            12'd418: toneR = `d;	12'd419: toneR = `d;
            12'd420: toneR = `d;	12'd421: toneR = `d;
            12'd422: toneR = `d;	12'd423: toneR = `d;
            12'd424: toneR = `a;	12'd425: toneR = `a;
            12'd426: toneR = `a;	12'd427: toneR = `a;
            12'd428: toneR = `a;	12'd429: toneR = `a;
            12'd430: toneR = `a;	12'd431: toneR = `a;
            12'd432: toneR = `fs;	12'd433: toneR = `fs;
            12'd434: toneR = `fs;	12'd435: toneR = `fs;
            12'd436: toneR = `fs;	12'd437: toneR = `fs;
            12'd438: toneR = `fs;	12'd439: toneR = `fs;
            12'd440: toneR = `a;	12'd441: toneR = `a;
            12'd442: toneR = `a;	12'd443: toneR = `a;
            12'd444: toneR = `a;	12'd445: toneR = `a;
            12'd446: toneR = `a;	12'd447: toneR = `a;
            12'd448: toneR = `d;	12'd449: toneR = `d;
            12'd450: toneR = `d;	12'd451: toneR = `d;
            12'd452: toneR = `d;	12'd453: toneR = `d;
            12'd454: toneR = `d;	12'd455: toneR = `d;
            12'd456: toneR = `b;	12'd457: toneR = `b;
            12'd458: toneR = `b;	12'd459: toneR = `b;
            12'd460: toneR = `b;	12'd461: toneR = `b;
            12'd462: toneR = `b;	12'd463: toneR = `b;
            12'd464: toneR = `g;	12'd465: toneR = `g;
            12'd466: toneR = `g;	12'd467: toneR = `g;
            12'd468: toneR = `g;	12'd469: toneR = `g;
            12'd470: toneR = `g;	12'd471: toneR = `g;
            12'd472: toneR = `b;	12'd473: toneR = `b;
            12'd474: toneR = `b;	12'd475: toneR = `b;
            12'd476: toneR = `b;	12'd477: toneR = `b;
            12'd478: toneR = `b;	12'd479: toneR = `b;
            12'd480: toneR = `d;	12'd481: toneR = `d;
            12'd482: toneR = `d;	12'd483: toneR = `d;
            12'd484: toneR = `d;	12'd485: toneR = `d;
            12'd486: toneR = `d;	12'd487: toneR = `d;
            12'd488: toneR = `a;	12'd489: toneR = `a;
            12'd490: toneR = `a;	12'd491: toneR = `a;
            12'd492: toneR = `a;	12'd493: toneR = `a;
            12'd494: toneR = `a;	12'd495: toneR = `a;
            12'd496: toneR = `fs;	12'd497: toneR = `fs;
            12'd498: toneR = `fs;	12'd499: toneR = `fs;
            12'd500: toneR = `fs;	12'd501: toneR = `fs;
            12'd502: toneR = `fs;	12'd503: toneR = `fs;
            12'd504: toneR = `a;	12'd505: toneR = `a;
            12'd506: toneR = `a;	12'd507: toneR = `a;
            12'd508: toneR = `a;	12'd509: toneR = `a;
            12'd510: toneR = `a;	12'd511: toneR = `a;
            12'd512: toneR = `e;	12'd513: toneR = `e;
            12'd514: toneR = `e;	12'd515: toneR = `e;
            12'd516: toneR = `e;	12'd517: toneR = `e;
            12'd518: toneR = `e;	12'd519: toneR = `e;
            12'd520: toneR = `a;	12'd521: toneR = `a;
            12'd522: toneR = `a;	12'd523: toneR = `a;
            12'd524: toneR = `a;	12'd525: toneR = `a;
            12'd526: toneR = `a;	12'd527: toneR = `a;
            12'd528: toneR = `hcs;	12'd529: toneR = `hcs;
            12'd530: toneR = `hcs;	12'd531: toneR = `hcs;
            12'd532: toneR = `hcs;	12'd533: toneR = `hcs;
            12'd534: toneR = `hcs;	12'd535: toneR = `hcs;
            12'd536: toneR = `a;	12'd537: toneR = `a;
            12'd538: toneR = `a;	12'd539: toneR = `a;
            12'd540: toneR = `a;	12'd541: toneR = `a;
            12'd542: toneR = `a;	12'd543: toneR = `a;
            12'd544: toneR = `hd;	12'd545: toneR = `hd;
            12'd546: toneR = `hd;	12'd547: toneR = `hd;
            12'd548: toneR = `hd;	12'd549: toneR = `hd;
            12'd550: toneR = `hd;	12'd551: toneR = `hd;
            12'd552: toneR = `a;	12'd553: toneR = `a;
            12'd554: toneR = `a;	12'd555: toneR = `a;
            12'd556: toneR = `a;	12'd557: toneR = `a;
            12'd558: toneR = `a;	12'd559: toneR = `a;
            12'd560: toneR = `d;	12'd561: toneR = `d;
            12'd562: toneR = `d;	12'd563: toneR = `d;
            12'd564: toneR = `d;	12'd565: toneR = `d;
            12'd566: toneR = `d;	12'd567: toneR = `d;
            12'd568: toneR = `d;	12'd569: toneR = `d;
            12'd570: toneR = `d;	12'd571: toneR = `d;
            12'd572: toneR = `d;	12'd573: toneR = `d;
            12'd574: toneR = `d;	12'd575: toneR = `d;
            default: toneR = `sil;
            endcase
        end
        else toneR = `sil;
    end
    always @(*) begin
        if(en==0)begin
            case(ibeatNum)
                // Ready?
                12'd0: toneL = `d;	    12'd1: toneL = `d;
                12'd2: toneL = `d;	    12'd3: toneL = `d;
                12'd4: toneL = `d;	    12'd5: toneL = `d;
                12'd6: toneL = `d;	    12'd7: toneL = `d;
                12'd8: toneL = `sil;	12'd9: toneL = `sil;
                12'd10: toneL = `sil;	12'd11: toneL = `sil;
                12'd12: toneL = `sil;	12'd13: toneL = `sil;
                12'd14: toneL = `sil;	12'd15: toneL = `sil;
                12'd16: toneL = `d;	    12'd17: toneL = `d;
                12'd18: toneL = `d;	    12'd19: toneL = `d;
                12'd20: toneL = `d;	    12'd21: toneL = `d;
                12'd22: toneL = `d;	    12'd23: toneL = `d;
                12'd24: toneL = `sil;	12'd25: toneL = `sil;
                12'd26: toneL = `sil;	12'd27: toneL = `sil;
                12'd28: toneL = `sil;	12'd29: toneL = `sil;
                12'd30: toneL = `sil;	12'd31: toneL = `sil;
                12'd32: toneL = `d;	    12'd33: toneL = `d;
                12'd34: toneL = `d;	    12'd35: toneL = `d;
                12'd36: toneL = `d;	    12'd37: toneL = `d;
                12'd38: toneL = `d;	    12'd39: toneL = `d;
                12'd40: toneL = `sil;	12'd41: toneL = `sil;
                12'd42: toneL = `sil;	12'd43: toneL = `sil;
                12'd44: toneL = `sil;	12'd45: toneL = `sil;
                12'd46: toneL = `sil;	12'd47: toneL = `sil;
                12'd48: toneL = `d;	    12'd49: toneL = `d;
                12'd50: toneL = `d;	    12'd51: toneL = `d;
                12'd52: toneL = `d;	    12'd53: toneL = `d;
                12'd54: toneL = `d;	    12'd55: toneL = `d;
                12'd56: toneL = `sil;	12'd57: toneL = `sil;
                12'd58: toneL = `sil;	12'd59: toneL = `sil;
                12'd60: toneL = `sil;	12'd61: toneL = `sil;
                12'd62: toneL = `sil;	12'd63: toneL = `sil;
                // Measure
                12'd64: toneL = `hfs;	12'd65: toneL = `hfs;
                12'd66: toneL = `hfs;	12'd67: toneL = `hfs;
                12'd68: toneL = `hfs;	12'd69: toneL = `hfs;
                12'd70: toneL = `hfs;	12'd71: toneL = `sil;

                12'd72: toneL = `hfs;	12'd73: toneL = `hfs;
                12'd74: toneL = `hfs;	12'd75: toneL = `hfs;
                12'd76: toneL = `hfs;	12'd77: toneL = `hfs;
                12'd78: toneL = `hfs;	12'd79: toneL = `sil;

                12'd80: toneL = `hfs;	12'd81: toneL = `hfs;
                12'd82: toneL = `hfs;	12'd83: toneL = `hfs;
                12'd84: toneL = `hfs;	12'd85: toneL = `hfs;
                12'd86: toneL = `hfs;	12'd87: toneL = `hfs;
                12'd88: toneL = `hfs;	12'd89: toneL = `hfs;
                12'd90: toneL = `hfs;	12'd91: toneL = `hfs;
                12'd92: toneL = `hfs;	12'd93: toneL = `hfs;
                12'd94: toneL = `hfs;	12'd95: toneL = `sil;

                12'd96: toneL = `hfs;	12'd97: toneL = `hfs;
                12'd98: toneL = `hfs;	12'd99: toneL = `hfs;
                12'd100: toneL = `hfs;	12'd101: toneL = `hfs;
                12'd102: toneL = `hfs;	12'd103: toneL = `sil;

                12'd104: toneL = `hfs;	12'd105: toneL = `hfs;
                12'd106: toneL = `hfs;	12'd107: toneL = `hfs;
                12'd108: toneL = `hfs;	12'd109: toneL = `hfs;
                12'd110: toneL = `hfs;	12'd111: toneL = `sil;

                12'd112: toneL = `hfs;	12'd113: toneL = `hfs;
                12'd114: toneL = `hfs;	12'd115: toneL = `hfs;
                12'd116: toneL = `hfs;	12'd117: toneL = `hfs;
                12'd118: toneL = `hfs;	12'd119: toneL = `hfs;
                12'd120: toneL = `hfs;	12'd121: toneL = `hfs;
                12'd122: toneL = `hfs;	12'd123: toneL = `hfs;
                12'd124: toneL = `hfs;	12'd125: toneL = `hfs;
                12'd126: toneL = `hfs;	12'd127: toneL = `sil;
                // Measure
                12'd128: toneL = `hfs;	12'd129: toneL = `hfs;
                12'd130: toneL = `hfs;	12'd131: toneL = `hfs;
                12'd132: toneL = `hfs;	12'd133: toneL = `hfs;
                12'd134: toneL = `hfs;	12'd135: toneL = `hfs;

                12'd136: toneL = `ha;	12'd137: toneL = `ha;
                12'd138: toneL = `ha;	12'd139: toneL = `ha;
                12'd140: toneL = `ha;	12'd141: toneL = `ha;
                12'd142: toneL = `ha;	12'd143: toneL = `ha;

                12'd144: toneL = `hd;	12'd145: toneL = `hd;
                12'd146: toneL = `hd;	12'd147: toneL = `hd;
                12'd148: toneL = `hd;	12'd149: toneL = `hd;
                12'd150: toneL = `hd;	12'd151: toneL = `hd;

                12'd152: toneL = `hd;	12'd153: toneL = `hd;
                12'd154: toneL = `hd;	12'd155: toneL = `hd;
                12'd156: toneL = `he;	12'd157: toneL = `he;
                12'd158: toneL = `he;	12'd159: toneL = `he;

                12'd160: toneL = `hfs;	12'd161: toneL = `hfs;
                12'd162: toneL = `hfs;	12'd163: toneL = `hfs;
                12'd164: toneL = `hfs;	12'd165: toneL = `hfs;
                12'd166: toneL = `hfs;	12'd167: toneL = `hfs;
                12'd168: toneL = `hfs;	12'd169: toneL = `hfs;
                12'd170: toneL = `hfs;	12'd171: toneL = `hfs;
                12'd172: toneL = `hfs;	12'd173: toneL = `hfs;
                12'd174: toneL = `hfs;	12'd175: toneL = `hfs;
                12'd176: toneL = `hfs;	12'd177: toneL = `hfs;
                12'd178: toneL = `hfs;	12'd179: toneL = `hfs;
                12'd180: toneL = `hfs;	12'd181: toneL = `hfs;
                12'd182: toneL = `hfs;	12'd183: toneL = `hfs;
                12'd184: toneL = `hfs;	12'd185: toneL = `hfs;
                12'd186: toneL = `hfs;	12'd187: toneL = `hfs;
                12'd188: toneL = `hfs;	12'd189: toneL = `hfs;
                12'd190: toneL = `hfs;	12'd191: toneL = `hfs;
                // Measure
                12'd192: toneL = `hg;	12'd193: toneL = `hg;
                12'd194: toneL = `hg;	12'd195: toneL = `hg;
                12'd196: toneL = `hg;	12'd197: toneL = `hg;
                12'd198: toneL = `hg;	12'd199: toneL = `sil;

                12'd200: toneL = `hg;	12'd201: toneL = `hg;
                12'd202: toneL = `hg;	12'd203: toneL = `hg;
                12'd204: toneL = `hg;	12'd205: toneL = `hg;
                12'd206: toneL = `hg;	12'd207: toneL = `sil;

                12'd208: toneL = `hg;	12'd209: toneL = `hg;
                12'd210: toneL = `hg;	12'd211: toneL = `hg;
                12'd212: toneL = `hg;	12'd213: toneL = `hg;
                12'd214: toneL = `hg;	12'd215: toneL = `hg;

                12'd216: toneL = `hg;	12'd217: toneL = `hg;
                12'd218: toneL = `hg;	12'd219: toneL = `sil;
                12'd220: toneL = `hg;	12'd221: toneL = `hg;
                12'd222: toneL = `hg;	12'd223: toneL = `sil;

                12'd224: toneL = `hg;	12'd225: toneL = `hg;
                12'd226: toneL = `hg;	12'd227: toneL = `hg;
                12'd228: toneL = `hg;	12'd229: toneL = `hg;
                12'd230: toneL = `hg;	12'd231: toneL = `hg;

                12'd232: toneL = `hfs;	12'd233: toneL = `hfs;
                12'd234: toneL = `hfs;	12'd235: toneL = `hfs;
                12'd236: toneL = `hfs;	12'd237: toneL = `hfs;
                12'd238: toneL = `hfs;	12'd239: toneL = `sil;

                12'd240: toneL = `hfs;	12'd241: toneL = `hfs;
                12'd242: toneL = `hfs;	12'd243: toneL = `hfs;
                12'd244: toneL = `hfs;	12'd245: toneL = `hfs;
                12'd246: toneL = `hfs;	12'd247: toneL = `sil;

                12'd248: toneL = `hfs;	12'd249: toneL = `hfs;
                12'd250: toneL = `hfs;	12'd251: toneL = `sil;
                12'd252: toneL = `hfs;	12'd253: toneL = `hfs;
                12'd254: toneL = `hfs;	12'd255: toneL = `sil;
                // Measure
                12'd256: toneL = `hfs;	12'd257: toneL = `hfs;
                12'd258: toneL = `hfs;	12'd259: toneL = `hfs;
                12'd260: toneL = `hfs;	12'd261: toneL = `hfs;
                12'd262: toneL = `hfs;	12'd263: toneL = `hfs;

                12'd264: toneL = `he;	12'd265: toneL = `he;
                12'd266: toneL = `he;	12'd267: toneL = `he;
                12'd268: toneL = `he;	12'd269: toneL = `he;
                12'd270: toneL = `he;	12'd271: toneL = `sil;

                12'd272: toneL = `he;	12'd273: toneL = `he;
                12'd274: toneL = `he;	12'd275: toneL = `he;
                12'd276: toneL = `he;	12'd277: toneL = `he;
                12'd278: toneL = `he;	12'd279: toneL = `he;

                12'd280: toneL = `hfs;	12'd281: toneL = `hfs;
                12'd282: toneL = `hfs;	12'd283: toneL = `hfs;
                12'd284: toneL = `hfs;	12'd285: toneL = `hfs;
                12'd286: toneL = `hfs;	12'd287: toneL = `hfs;

                12'd288: toneL = `he;	12'd289: toneL = `he;
                12'd290: toneL = `he;	12'd291: toneL = `he;
                12'd292: toneL = `he;	12'd293: toneL = `he;
                12'd294: toneL = `he;	12'd295: toneL = `he;
                12'd296: toneL = `he;	12'd297: toneL = `he;
                12'd298: toneL = `he;	12'd299: toneL = `he;
                12'd300: toneL = `he;	12'd301: toneL = `he;
                12'd302: toneL = `he;	12'd303: toneL = `he;

                12'd304: toneL = `ha;	12'd305: toneL = `ha;
                12'd306: toneL = `ha;	12'd307: toneL = `ha;
                12'd308: toneL = `ha;	12'd309: toneL = `ha;
                12'd310: toneL = `ha;	12'd311: toneL = `ha;
                12'd312: toneL = `ha;	12'd313: toneL = `ha;
                12'd314: toneL = `ha;	12'd315: toneL = `ha;
                12'd316: toneL = `ha;	12'd317: toneL = `ha;
                12'd318: toneL = `ha;	12'd319: toneL = `ha;
                // Measure
                12'd320: toneL = `hfs;	12'd321: toneL = `hfs;
                12'd322: toneL = `hfs;	12'd323: toneL = `hfs;
                12'd324: toneL = `hfs;	12'd325: toneL = `hfs;
                12'd326: toneL = `hfs;	12'd327: toneL = `sil;

                12'd328: toneL = `hfs;	12'd329: toneL = `hfs;
                12'd330: toneL = `hfs;	12'd331: toneL = `hfs;
                12'd332: toneL = `hfs;	12'd333: toneL = `hfs;
                12'd334: toneL = `hfs;	12'd335: toneL = `sil;

                12'd336: toneL = `hfs;	12'd337: toneL = `hfs;
                12'd338: toneL = `hfs;	12'd339: toneL = `hfs;
                12'd340: toneL = `hfs;	12'd341: toneL = `hfs;
                12'd342: toneL = `hfs;	12'd343: toneL = `hfs;
                12'd344: toneL = `hfs;	12'd345: toneL = `hfs;
                12'd346: toneL = `hfs;	12'd347: toneL = `hfs;
                12'd348: toneL = `hfs;	12'd349: toneL = `hfs;
                12'd350: toneL = `hfs;	12'd351: toneL = `sil;

                12'd352: toneL = `hfs;	12'd353: toneL = `hfs;
                12'd354: toneL = `hfs;	12'd355: toneL = `hfs;
                12'd356: toneL = `hfs;	12'd357: toneL = `hfs;
                12'd358: toneL = `hfs;	12'd359: toneL = `sil;

                12'd360: toneL = `hfs;	12'd361: toneL = `hfs;
                12'd362: toneL = `hfs;	12'd363: toneL = `hfs;
                12'd364: toneL = `hfs;	12'd365: toneL = `hfs;
                12'd366: toneL = `hfs;	12'd367: toneL = `sil;

                12'd368: toneL = `hfs;	12'd369: toneL = `hfs;
                12'd370: toneL = `hfs;	12'd371: toneL = `hfs;
                12'd372: toneL = `hfs;	12'd373: toneL = `hfs;
                12'd374: toneL = `hfs;	12'd375: toneL = `hfs;
                12'd376: toneL = `hfs;	12'd377: toneL = `hfs;
                12'd378: toneL = `hfs;	12'd379: toneL = `hfs;
                12'd380: toneL = `hfs;	12'd381: toneL = `hfs;
                12'd382: toneL = `hfs;	12'd383: toneL = `sil;
                // Measure
                12'd384: toneL = `hfs;	12'd385: toneL = `hfs;
                12'd386: toneL = `hfs;	12'd387: toneL = `hfs;
                12'd388: toneL = `hfs;	12'd389: toneL = `hfs;
                12'd390: toneL = `hfs;	12'd391: toneL = `hfs;

                12'd392: toneL = `ha;	12'd393: toneL = `ha;
                12'd394: toneL = `ha;	12'd395: toneL = `ha;
                12'd396: toneL = `ha;	12'd397: toneL = `ha;
                12'd398: toneL = `ha;	12'd399: toneL = `ha;

                12'd400: toneL = `hd;	12'd401: toneL = `hd;
                12'd402: toneL = `hd;	12'd403: toneL = `hd;
                12'd404: toneL = `hd;	12'd405: toneL = `hd;
                12'd406: toneL = `hd;	12'd407: toneL = `hd;

                12'd408: toneL = `hd;	12'd409: toneL = `hd;
                12'd410: toneL = `hd;	12'd411: toneL = `hd;
                12'd412: toneL = `he;	12'd413: toneL = `he;
                12'd414: toneL = `he;	12'd415: toneL = `he;

                12'd416: toneL = `hfs;	12'd417: toneL = `hfs;
                12'd418: toneL = `hfs;	12'd419: toneL = `hfs;
                12'd420: toneL = `hfs;	12'd421: toneL = `hfs;
                12'd422: toneL = `hfs;	12'd423: toneL = `hfs;
                12'd424: toneL = `hfs;	12'd425: toneL = `hfs;
                12'd426: toneL = `hfs;	12'd427: toneL = `hfs;
                12'd428: toneL = `hfs;	12'd429: toneL = `hfs;
                12'd430: toneL = `hfs;	12'd431: toneL = `hfs;
                12'd432: toneL = `hfs;	12'd433: toneL = `hfs;
                12'd434: toneL = `hfs;	12'd435: toneL = `hfs;
                12'd436: toneL = `hfs;	12'd437: toneL = `hfs;
                12'd438: toneL = `hfs;	12'd439: toneL = `hfs;
                12'd440: toneL = `hfs;	12'd441: toneL = `hfs;
                12'd442: toneL = `hfs;	12'd443: toneL = `hfs;
                12'd444: toneL = `hfs;	12'd445: toneL = `hfs;
                12'd446: toneL = `hfs;	12'd447: toneL = `hfs;
                // Measure
                12'd448: toneL = `hg;	12'd449: toneL = `hg;
                12'd450: toneL = `hg;	12'd451: toneL = `hg;
                12'd452: toneL = `hg;	12'd453: toneL = `hg;
                12'd454: toneL = `hg;	12'd455: toneL = `sil;

                12'd456: toneL = `hg;	12'd457: toneL = `hg;
                12'd458: toneL = `hg;	12'd459: toneL = `hg;
                12'd460: toneL = `hg;	12'd461: toneL = `hg;
                12'd462: toneL = `hg;	12'd463: toneL = `sil;

                12'd464: toneL = `hg;	12'd465: toneL = `hg;
                12'd466: toneL = `hg;	12'd467: toneL = `hg;
                12'd468: toneL = `hg;	12'd469: toneL = `hg;
                12'd470: toneL = `hg;	12'd471: toneL = `hg;

                12'd472: toneL = `hg;	12'd473: toneL = `hg;
                12'd474: toneL = `hg;	12'd475: toneL = `sil;
                12'd476: toneL = `hg;	12'd477: toneL = `hg;
                12'd478: toneL = `hg;	12'd479: toneL = `sil;

                12'd480: toneL = `hg;	12'd481: toneL = `hg;
                12'd482: toneL = `hg;	12'd483: toneL = `hg;
                12'd484: toneL = `hg;	12'd485: toneL = `hg;
                12'd486: toneL = `hg;	12'd487: toneL = `hg;

                12'd488: toneL = `hfs;	12'd489: toneL = `hfs;
                12'd490: toneL = `hfs;	12'd491: toneL = `hfs;
                12'd492: toneL = `hfs;	12'd493: toneL = `hfs;
                12'd494: toneL = `hfs;	12'd495: toneL = `sil;

                12'd496: toneL = `hfs;	12'd497: toneL = `hfs;
                12'd498: toneL = `hfs;	12'd499: toneL = `hfs;
                12'd500: toneL = `hfs;	12'd501: toneL = `hfs;
                12'd502: toneL = `hfs;	12'd503: toneL = `sil;

                12'd504: toneL = `hfs;	12'd505: toneL = `hfs;
                12'd506: toneL = `hfs;	12'd507: toneL = `sil;
                12'd508: toneL = `hfs;	12'd509: toneL = `hfs;
                12'd510: toneL = `hfs;	12'd511: toneL = `sil;
                // Measure
                12'd512: toneL = `ha;	12'd513: toneL = `ha;
                12'd514: toneL = `ha;	12'd515: toneL = `ha;
                12'd516: toneL = `ha;	12'd517: toneL = `ha;
                12'd518: toneL = `ha;	12'd519: toneL = `sil;

                12'd520: toneL = `ha;	12'd521: toneL = `ha;
                12'd522: toneL = `ha;	12'd523: toneL = `ha;
                12'd524: toneL = `ha;	12'd525: toneL = `ha;
                12'd526: toneL = `ha;	12'd527: toneL = `ha;

                12'd528: toneL = `hg;	12'd529: toneL = `hg;
                12'd530: toneL = `hg;	12'd531: toneL = `hg;
                12'd532: toneL = `hg;	12'd533: toneL = `hg;
                12'd534: toneL = `hg;	12'd535: toneL = `hg;

                12'd536: toneL = `he;	12'd537: toneL = `he;
                12'd538: toneL = `he;	12'd539: toneL = `he;
                12'd540: toneL = `he;	12'd541: toneL = `he;
                12'd542: toneL = `he;	12'd543: toneL = `he;

                12'd544: toneL = `hd;	12'd545: toneL = `hd;
                12'd546: toneL = `hd;	12'd547: toneL = `hd;
                12'd548: toneL = `hd;	12'd549: toneL = `hd;
                12'd550: toneL = `hd;	12'd551: toneL = `hd;
                12'd552: toneL = `hd;	12'd553: toneL = `hd;
                12'd554: toneL = `hd;	12'd555: toneL = `hd;
                12'd556: toneL = `hd;	12'd557: toneL = `hd;
                12'd558: toneL = `hd;	12'd559: toneL = `hd;
                12'd560: toneL = `hd;	12'd561: toneL = `hd;
                12'd562: toneL = `hd;	12'd563: toneL = `hd;
                12'd564: toneL = `hd;	12'd565: toneL = `hd;
                12'd566: toneL = `hd;	12'd567: toneL = `hd;
                12'd568: toneL = `hd;	12'd569: toneL = `hd;
                12'd570: toneL = `hd;	12'd571: toneL = `hd;
                12'd572: toneL = `hd;	12'd573: toneL = `hd;
                12'd574: toneL = `hd;	12'd575: toneL = `hd;

                default : toneL = `sil;
            endcase
        end
        else begin
            toneL = `sil;
        end
    end
endmodule



module LED(
    input clk,
    input reset,
    input mute,
    output reg [4:0] led,
    output reg [2:0] vol,
    input up,
    input down
);

    reg [2:0] nextVol;
    always @(posedge clk, posedge reset) begin
        if(reset) vol = 0;
        else vol = nextVol;
    end

    always @* begin
        if(up) nextVol = (vol == 3'd4) ? 3'd4 : (vol + 1);
        else if (down) nextVol = (vol == 3'd0) ? 3'd0 : (vol - 1);
        else nextVol = vol;
    end

    always @* begin
        if(mute) led = 5'b00000;
        else begin
            case(vol)
                3'd0: led = 5'b00001;
                3'd1: led = 5'b00011;
                3'd2: led = 5'b00111;
                3'd3: led = 5'b01111;
                3'd4: led = 5'b11111;
                default: led = 5'b10101;
            endcase
        end
    end

endmodule

module SevenSeg(clk, rst, en, freq, DIGIT, DISPLAY);

    `define hc  32'd524   // C4
    `define hd  32'd588   // D4
    `define he  32'd660   // E4
    `define hf  32'd698   // F4
    `define hg  32'd784   // G4
    `define ha  32'd880   // A4 
    `define hb  32'd988   // B4
    `define hcs 32'd554         // C4#
    `define hfs 32'd740         // F4#
    `define c   32'd262   // C3
    `define cs  32'd277         // C3#
    `define d   32'd294   // D3
    `define e   32'd330   // E3
    `define f   32'd349   // F3
    `define fs  32'd370         // F3#
    `define g   32'd392   // G3
    `define gs  32'd415         // G3#
    `define a   32'd440   // A3
    `define b   32'd494   // B3

    input clk, rst;
    input en;
    input [31:0] freq;
    output reg [3:0] DIGIT;
    output reg [6:0] DISPLAY;
    
    always @(posedge clk, posedge rst) begin
        if(rst) begin
            DIGIT = 4'b1110;
        end else begin
            case(DIGIT)
                4'b1110: DIGIT = 4'b1101;
                4'b1101: DIGIT = 4'b1011;
                4'b1011: DIGIT = 4'b0111;
                4'b0111: DIGIT = 4'b1110;
            endcase
        end
    end
    
    always @* begin
        if(DIGIT == 4'b1110) begin
            // Note
            // C
            if((freq == 32'd1047) | (freq == 32'd1109) | (freq == 32'd524) | (freq == 32'd554) | (freq == 32'd262) | (freq == 32'd277))
                DISPLAY = 7'b1000110;
            // D
            else if((freq == 32'd1175) | (freq == 32'd588) | (freq == 32'd294))
                DISPLAY = 7'b0100001;
            // E
            else if((freq == 32'd1319) | (freq == 32'd660) | (freq == 32'd330))
                DISPLAY = 7'b0000110;
            // F
            else if((freq == 32'd698) | (freq == 32'd740) | (freq == 32'd349) | (freq == 32'd370))
                DISPLAY = 7'b0001110;
            // G
            else if((freq == 32'd784) | (freq == 32'd392) | (freq == 32'd415))
                DISPLAY = 7'b0000010;
            // A
            else if((freq == 32'd880) | (freq == 32'd440))
                DISPLAY = 7'b0001000;
            // B
            else if((freq == 32'd988) | (freq == 32'd494))
                DISPLAY = 7'b0000011;
            else
                DISPLAY =  7'b0111111;
        end else if(DIGIT == 4'b1101) begin
            // Sharp and high notation
            // High Normal
            if((freq == `hc) | (freq == `hd) | (freq == `he) | (freq == `hf) | (freq == `hg) | (freq == `ha) | (freq == `hb))
                DISPLAY = 7'b1111110;
            // High Sharp
            else if((freq == `hcs) | (freq == `hfs))
                DISPLAY = 7'b1011100;
            // Normal
            else if((freq == `c) | (freq == `d) | (freq == `e) | (freq == `f) | (freq == `g) | (freq == `a) | (freq == `b))
                DISPLAY = 7'b1110111;
            // Sharp
            else if((freq == `cs) | (freq == `fs) | (freq == `gs))
                DISPLAY = 7'b1010101;
            else 
                DISPLAY = 7'b0111111;
        end else begin
            DISPLAY = 7'b0111111;
        end
    end
    
endmodule

module speaker(
    clk, // clock from crystal
    rst, // active high reset: BTNC
    _play,
    _mute,
    _repeat,
    _music,
    _volUP,
    _volDOWN,
    _vol,
    audio_mclk, // master clock
    audio_lrck, // left-right clock
    audio_sck, // serial clock
    audio_sdin, // serial audio data input
    DISPLAY,
    DIGIT
);
    // I/O declaration
    input clk;  // clock from the crystal
    input rst;  // active high reset
    input _play, _mute, _repeat, _music, _volUP, _volDOWN;
    output [4:0] _vol;
    output audio_mclk; // master clock
    output audio_lrck; // left-right clock
    output audio_sck; // serial clock
    output audio_sdin; // serial audio data input
    output [6:0] DISPLAY;
    output [3:0] DIGIT;
    
    wire [2:0] volume;

    // Declare internal nodes
    wire [15:0] audio_in_left, audio_in_right;
    wire [11:0] ibeatNumJB, ibeatNumBC;

    wire [21:0] freq_out, freq_outR;
    wire clkDiv23, clkDiv18, clkDiv13;
    wire real_mute;

    clock_divider #(.n(22)) clock_23(
        .clk(clk),
       .clk_div(clkDiv23)
    );

    clock_divider #(.n(18)) clock_18(
        .clk(clk),
        .clk_div(clkDiv18)
    );

    clock_divider #(.n(13)) clock_13(
        .clk(clk),
        .clk_div(clkDiv13)
    );

    // Music Switch
    wire op_pos_music, op_neg_music;
    onepulse OP_POS_MUSIC(.signal(_music), .clk(clkDiv23), .op(op_pos_music));
    onepulse OP_NEG_MUSIC(.signal(~_music), .clk(clkDiv23), .op(op_neg_music));

    // BC Player
    PlayerCtrl #(.LEN(620)) playerCtrl_00 ( 
        .clk(clkDiv23),
        .reset(op_neg_music | rst),
        ._play(_play),
        ._repeat(_repeat),
        .ibeat(ibeatNumBC)
    );
    
    // Jingle Bells Player
    PlayerCtrl #(.LEN(600)) playerCtrl_01 ( 
        .clk(clkDiv23),
        .reset(op_pos_music | rst),
        ._play(_play),
        ._repeat(_repeat),
        .ibeat(ibeatNumJB)
    );

    // Button Processing
    wire dvu, dvd, ovu, ovd;
    debounce db0(.pb_debounced(dvu), .pb(_volUP) ,.clk(clkDiv18));
    debounce db1(.pb_debounced(dvd), .pb(_volDOWN) ,.clk(clkDiv18));

    onepulse op0(.signal(dvu), .clk(clkDiv23), .op(ovu));
    onepulse op1(.signal(dvd), .clk(clkDiv23), .op(ovd));
    // LED Control

    LED _led(
        .clk(clkDiv23),
        .reset(rst),
        .mute(_mute),
        .led(_vol),
        .vol(volume),
        .up(ovu),
        .down(ovd)
    );

    // Seven Segment
    SevenSeg ss(.clk(clkDiv13), .rst(rst), .en(~_play), .freq((_music ? freqJB : freqBC)), .DIGIT(DIGIT), .DISPLAY(DISPLAY));

    // Music module
    wire [31:0] freqBC, freqRBC, freqJB, freqRJB;
    wire realMute;
    assign realMute = _mute | ~_play;
    Music_BC music00 ( 
        .ibeatNum(ibeatNumBC),
        .en(1'b0),
        .toneL(freqBC),
        .toneR(freqRBC)
    );

    Music_JB music01 ( 
        .ibeatNum(ibeatNumJB),
        .en(1'b0),
        .toneL(freqJB),
        .toneR(freqRJB)
    );


    assign freq_out = 50000000 / (realMute ? 32'd50000 : (_music ? freqJB : freqBC));
    assign freq_outR = 50000000 / (realMute ? 32'd50000 : (_music ? freqRJB : freqRBC));

    // Note generation: Split Left and Right
    note_gen Audio(
        .clk(clk), // clock from crystal
        .rst(rst), // active high reset
        .note_div(freq_out), // div for note generation
        .note_div_right(freq_outR),
        .audio_left(audio_in_left), // left sound audio
        .audio_right(audio_in_right),
        .volume(volume)
    );


    // Speaker controllor
    speaker_control Usc(
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
