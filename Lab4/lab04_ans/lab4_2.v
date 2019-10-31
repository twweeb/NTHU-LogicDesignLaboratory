module lab4_2(clk,reset,en,dir,record,DIGIT,DISPLAY,max,min);
input en;
input reset;
input clk;
input dir;
input record;
output [3:0] DIGIT;
output [6:0] DISPLAY;
output max;
output min;

parameter upperbound = 99;
parameter lowerbound = 0;

// clock divider
wire clk_25, clk_23;
clock_divider #(.width(23)) clk23(.clk(clk),.clk_div(clk_23));
clock_divider #(.width(25)) clk25(.clk(clk),.clk_div(clk_25));

//  debounce
wire reset_de, en_de, dir_de, record_de;
debounce reset_debounce(.clk(clk),.pb(reset),.pb_debounced(reset_de));
debounce en_debounce(.clk(clk),.pb(en),.pb_debounced(en_de));
debounce dir_debounce(.clk(clk),.pb(dir),.pb_debounced(dir_de));
debounce record_debounce(.clk(clk),.pb(record),.pb_debounced(record_de));

// one_pulse
wire en_one, dir_one, record_one;
one_pulse en_1pulse(.clk(clk),.pb_debounced(en_de),.pb_1pulse(en_one));
one_pulse dir_1pulse(.clk(clk),.pb_debounced(dir_de),.pb_1pulse(dir_one));
one_pulse record_1pulse(.clk(clk),.pb_debounced(record_de),.pb_1pulse(record_one));

//  button state
reg dir_state, en_state;
wire dir_state_next, en_state_next;

assign en_state_next = (en_one) ? ~en_state : en_state;
assign dir_state_next = (dir_one) ? ~dir_state : dir_state;

always @(posedge clk_23, posedge reset_de) begin
    if (reset_de) begin
        en_state <= 1'b0;
        dir_state <= 1'b1;
    end else begin
        en_state <= en_state_next;
        dir_state <= dir_state_next;
    end
end


// counter
reg [7:0] value;
always @(posedge clk_25, posedge reset_de) begin
    if (reset_de)
        value <= 0;
    else begin
        if (en_state==1'b0)
            value <= value;
        else begin
            if (dir_state==1'b1)
                value <= (value == upperbound) ? upperbound : value + 1;
            else 
                value <= (value == lowerbound) ? lowerbound : value - 1;
        end
    end
end

// number record
reg [7:0] number;
always @(posedge clk_23, posedge reset_de) begin
    if (reset_de)
        number <= 0;
    else if (record_one == 1)
        number <= value;
    else
        number <= number;
end

// BCD
wire [15:0] BCD_in, BCD_out;

assign BCD_in[3:0] = value % 10;
assign BCD_in[7:4] = value / 10;
assign BCD_in[11:8] = number % 10;
assign BCD_in[15:12] = number / 10;

BCD _BCD(.in(BCD_in),.out(BCD_out));

// max & min
assign max = (value==upperbound && dir_state==1 && ~reset_de) ? 1 : 0;
assign min = (value==lowerbound && dir_state==0 && ~reset_de) ? 1 : 0;


// 7-SEG decoder 
Seven_SEG decoder(.clk(clk),.BCD0(BCD_out[15:12]),.BCD1(BCD_out[11:8]),.BCD2(BCD_out[7:4]),.BCD3(BCD_out[3:0]),.DIGIT(DIGIT),.DISPLAY(DISPLAY));

endmodule