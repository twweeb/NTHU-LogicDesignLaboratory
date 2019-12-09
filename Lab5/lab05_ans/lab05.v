`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/19 21:26:26
// Design Name: 
// Module Name: lab05
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


module lab05(clk, rst, money_5, money_10, cancel, drink_A, drink_B, drop_money, enough_A, enough_B, DIGIT, DISPLAY);
    input clk;
    input rst;
    input money_5;
    input money_10;
    input cancel;
    input drink_A;
    input drink_B;
    output reg[9:0] drop_money;
    output reg enough_A;
    output reg enough_B;
    output [3:0] DIGIT;
    output [6:0] DISPLAY;
    reg[3:0] BCD3,BCD2,BCD1,BCD0;
    
    //clock
    wire clk26, clk16, clk13;
    ClockDivider #(.n(13)) clock_13(clk,clk13);
    ClockDivider #(.n(16)) clock_16(clk,clk16);
    ClockDivider #(.n(26)) clock_26(clk,clk26);
    
    //debounce
    wire money_5_d, money_10_d, cancel_d, drink_A_d, drink_B_d;
    debounce m5(money_5_d, money_5, clk16);
    debounce m10(money_10_d, money_10, clk16);
    debounce c(cancel_d, cancel, clk16);
    debounce dA(drink_A_d, drink_A, clk16);
    debounce dB(drink_B_d, drink_B, clk16);
    
    //one pulse
    wire money_5_one, money_10_one, cancel_one, drink_A_one, drink_B_one;
    onepulse m5one(money_5_one, clk16, money_5_d);
    onepulse m10one(money_10_one, clk16, money_10_d);
    onepulse c_one(cancel_one, clk16, cancel_d);
    onepulse dAone(drink_A_one, clk16, drink_A_d);
    onepulse dBone(drink_B_one, clk16, drink_B_d);
    
    //7-SEG
    LED7SEG seven(DIGIT, DISPLAY, clk13, BCD3, BCD2, BCD1, BCD0);
    
    //sequential
    reg[3:0] next_BCD3,next_BCD2,next_BCD1,next_BCD0;
    reg[9:0] next_drop_money;
    reg next_enough_A, next_enough_B;
    parameter INITIAL = 2'b00, DEPOSIT = 2'b01, BUY = 2'b10, CHANGE = 2'b11;
    reg[1:0] state,next_state;
    reg[12:0] count,next_count;
    reg[8:0] bcd_delay,next_delay;
    reg[6:0] balance, next_balance;
    wire clk_select;
    assign clk_select = (state == INITIAL || state == DEPOSIT)?clk16:clk26;
    always @(posedge clk_select or posedge rst)begin
        if(rst)begin
            state <= INITIAL;
            BCD0 <= 4'b0000;
            BCD1 <= 4'b0000;
            BCD2 <= 4'b0000;
            BCD3 <= 4'b0000;
            drop_money <= 10'b00_0000_0000;
            enough_A <= 1'b0;
            enough_B <= 1'b0;
            count <= 13'd0;
            bcd_delay<= 9'b0;
            balance <= 7'd0;
        end
        else begin
            state <= next_state;
            enough_A <= next_enough_A;
            enough_B <= next_enough_B;
            BCD0 <= next_BCD0;
            BCD1 <= next_BCD1;
            BCD2 <= next_BCD2;
            BCD3 <= next_BCD3;
            drop_money <= next_drop_money;
            count <= next_count;
            bcd_delay<= next_delay;
            balance <= next_balance;
        end
    end
    
    //FSM
    always @(*)begin
        next_BCD0 = BCD0;
        next_BCD1 = BCD1;
        next_BCD2 = BCD2;
        next_BCD3 = BCD3;
        next_drop_money = drop_money;
        next_enough_A = enough_A;
        next_enough_B = enough_B;
        next_delay = bcd_delay;
        next_balance = balance;
        next_state = state;
        next_count = count;
        case(state)
            INITIAL:begin
                next_BCD0 = 4'd0;
                next_BCD1 = 4'd0;
                next_BCD2 = 4'd0;
                next_BCD3 = 4'd0;
                next_drop_money = 10'd0;
                next_enough_A = 1'd0;
                next_enough_B = 1'd0;
                next_state = DEPOSIT;
                next_balance = 7'd0;
                next_delay = 9'd0;
            end
            DEPOSIT:begin
                next_count = count+1;
                next_state = DEPOSIT;
                if(cancel_one)begin
                    next_count = 13'd0;
                    next_BCD2 = 4'd0;
                    next_BCD3 = 4'd0;
                    next_enough_A = 1'd0;
                    next_enough_B = 1'd0;
                    next_state = CHANGE;
                end
                else if(money_5_one)begin
                    next_count = 13'd0;
                    if(BCD0 == 4'd5)begin
                        if(BCD1<4'd9)begin
                            next_BCD1 = BCD1+1;
                            next_BCD0 = 4'd0;
                        end
                    end 
                    else begin
                        next_BCD0 = 4'd5;
                    end
                end
                else if(money_10_one)begin
                    next_count = 13'd0;
                    if(BCD1<9)begin
                       next_BCD1 = BCD1+4'd1; 
                    end
                end
                else if(drink_A_one)begin
                    next_count = 13'd0;
                    if(BCD3 == 4'd2 && BCD2 == 4'd0)begin
                        if((BCD1>BCD3)||((BCD3 ==BCD1)&&BCD0>=BCD2))begin
                            next_state = DEPOSIT;
                            next_count = 13'd0;
                            next_state = BUY;                       
                        end
                    end
                    else begin
                        next_BCD3 = 4'd2;
                        next_BCD2 = 4'd0;
                    end
                end
                else if(drink_B_one)begin
                    next_count = 13'd0;
                    if(BCD3 == 4'd2 && BCD2 == 4'd5)begin
                        if((BCD1>BCD3)||((BCD3 ==BCD1)&&BCD0>=BCD2))begin
                            next_state = DEPOSIT;
                            next_count = 13'd0;
                            next_state = BUY;                       
                        end
                    end
                    else begin
                        next_BCD3 = 4'd2;
                        next_BCD2 = 4'd5;
                    end
                end
                else if(count == 13'b1_1111_1111_1111)begin
                    next_count = 13'd0;
                    next_BCD2 = 4'd0;
                    next_BCD3 = 4'd0;
                    next_enough_A = 1'd0;
                    next_enough_B = 1'd0;
                    next_state = CHANGE;
                end
                else if(BCD1>2||(BCD1==2 && BCD0>=0))begin
                    next_enough_A = 1'd1;
                    if(BCD1>2||(BCD1==2 && BCD0>=5))begin
                        next_enough_B = 1'd1;
                    end
                end
            end
            BUY:begin
                next_balance = (BCD1*10+BCD0) - (BCD3*10+BCD2);
                next_enough_A = 1'b0;
                next_enough_B = 1'b0;
                if(BCD3 == 2 && BCD2 == 0)begin
                    next_BCD3 = 4'd10;
                    next_BCD2 = 4'd11;
                    next_BCD1 = 4'd12;
                    next_BCD0 = 4'd13;
                end
                else begin
                    next_BCD3 = 4'd13;
                    next_BCD2 = 4'd0;
                    next_BCD1 = 4'd14;
                    next_BCD0 = 4'd15;
                end
                //if(bcd_delay)begin
                next_state = CHANGE;
                //end
            end
            CHANGE:begin
                if(BCD3!=0 || BCD2!=0)begin
                    next_BCD3 = 4'd0;
                    next_BCD2 = 4'd0;
                    next_BCD1 = balance/10;
                    next_BCD0 = balance - (balance/10)*10;
                    next_state = CHANGE;
                end
                /*else if(balance == 0)begin
                    next_balance = BCD1*10 + BCD0;
                end*/
                else if(BCD1>0)begin
                    next_BCD1 = BCD1 - 4'd1;
                    next_drop_money = 10'b11_1111_1111;
                    next_state = CHANGE;
                end
                else if(BCD0>0)begin
                    next_BCD0 = BCD0 - 4'd5;
                    next_drop_money = 10'b11_1110_0000;
                    next_state = CHANGE;
                end
                else begin
                    next_drop_money = 10'b00_0000_0000;
                    next_BCD0 = 4'd0;
                    next_BCD1 = 4'd0;
                    next_BCD2 = 4'd0;
                    next_BCD3 = 4'd0;
                    next_state = INITIAL;
                end
            end
        endcase
   end
endmodule
