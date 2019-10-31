module lab4_3(clk,reset,en,mode,min_plus,sec_plus,DIGIT,DISPLAY,stop);
input en;
input reset;
input clk;
input mode;
input min_plus;
input sec_plus;
output [3:0] DIGIT;
output [6:0] DISPLAY;
output reg stop;

parameter count = 1;
parameter set = 0;

// clock divider
wire clk_23;
clock_divider #(.width(23)) clk23(.clk(clk),.clk_div(clk_23));

//  debounce
wire reset_de, en_de, min_plus_de, sec_plus_de;
debounce reset_debounce(.clk(clk),.pb(reset),.pb_debounced(reset_de));
debounce en_debounce(.clk(clk),.pb(en),.pb_debounced(en_de));
debounce min_debounce(.clk(clk),.pb(min_plus),.pb_debounced(min_plus_de));
debounce sec_debounce(.clk(clk),.pb(sec_plus),.pb_debounced(sec_plus_de));

// one_pulse
wire en_one, min_plus_one, sec_plus_one;
one_pulse en_1pulse(.clk(clk),.pb_debounced(en_de),.pb_1pulse(en_one));
one_pulse min_1pulse(.clk(clk),.pb_debounced(min_plus_de),.pb_1pulse(min_plus_one));
one_pulse sec_1pulse(.clk(clk),.pb_debounced(sec_plus_de),.pb_1pulse(sec_plus_one));

//  button state
reg en_state;
wire en_state_next;

assign en_state_next = (en_one) ? ~en_state : en_state;

always @(posedge clk_23, posedge reset_de) begin
    if (reset_de || mode == set)
        en_state <= 1'b0;
    else
        en_state <= en_state_next;
end


// counter
reg [15:0] value, value_next;
reg mode_last;

always @(posedge clk_23, posedge reset_de) begin
    if (reset_de) begin
        value <= 0;
        mode_last <= set;
    end else begin
        value <= value_next % 3600;
        mode_last <= mode;
    end
end

always @* begin

    stop = 0;
    if (mode == count) begin
        if (en_state ==0)
            value_next = value;
        else begin 
            if (value==0) begin
                value_next = value;
                stop = 1;
            end else
                value_next = value-1; 
        end
    end else begin
        if (mode_last==count)
            value_next = 0;
        else begin
            if (min_plus_one)
                value_next = value + 60;
            else if (sec_plus_one)
                value_next = value + 1;
            else
                value_next = value;
        end
    end
    
end

wire [7:0] min ,sec;
assign min = value / 60;
assign sec = value % 60;

// BCD
wire [15:0] BCD_in, BCD_out;

assign BCD_in[3:0] = sec % 10;
assign BCD_in[7:4] = sec / 10;
assign BCD_in[11:8] = min % 10;
assign BCD_in[15:12] = min / 10;

BCD _BCD(.in(BCD_in),.out(BCD_out));


// 7-SEG decoder 
Seven_SEG decoder(.clk(clk),.BCD0(BCD_out[15:12]),.BCD1(BCD_out[11:8]),.BCD2(BCD_out[7:4]),.BCD3(BCD_out[3:0]),.DIGIT(DIGIT),.DISPLAY(DISPLAY));

endmodule