module lab4_1(DIGIT, DISPLAY, clk, reset, SW);
input [15:0] SW;
input clk;
input reset;
output [3:0] DIGIT;
output [6:0] DISPLAY;

// clock divider
wire clk_25;
clock_divider #(.width(25)) clk25(.clk(clk),.clk_div(clk_25));

// debounce
wire reset_de;
debounce reset_debounce(.clk(clk),.pb(reset),.pb_debounced(reset_de));

//  monitor
reg [3:0] BCD0, BCD1, BCD2, BCD3;
Seven_SEG decoder(.clk(clk),.BCD0(BCD0),.BCD1(BCD1),.BCD2(BCD2),.BCD3(BCD3),.DIGIT(DIGIT),.DISPLAY(DISPLAY));

// BCD
wire [15:0] value;
BCD _BCD(.in(SW),.out(value));

always@(posedge clk_25, posedge reset) begin
    if (reset == 1'b1) begin
        BCD0 <= 4'b0;
        BCD1 <= 4'b0;
        BCD2 <= 4'b0;
        BCD3 <= 4'b0;
    end else begin
        BCD0 <= value[15:12];
        BCD1 <= value[11:8];
        BCD2 <= value[7:4];
        BCD3 <= value[3:0];
    end
end

endmodule
