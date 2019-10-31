`timescale 1ns / 1ps

module clock_divider(clk,clk_div);
    input clk;
    output clk_div;
    parameter n = 26;
    reg[n-1:0]num;
    wire[n-1:0]next_num;
    always@(posedge clk)begin
        num <= next_num;
    end
    assign next_num = num + 1;
    assign clk_div = num[n-1];
endmodule

module lab03_1(clk,rst,en,dir,led);
    input clk,rst,en,dir;
    output[15:0] led;
    
    reg[15:0]led_next = 0;
    reg[15:0]led = 0;
    wire clk_div;
    clock_divider div(.clk(clk), .clk_div(clk_div));
    always@(posedge clk_div)begin
        led <= led_next;
    end
    always@(*)begin
        if(rst == 1)begin
            led_next = 16'b1000000000000000;
        end
        else begin
            if(en == 1 && dir == 0)begin
                led_next[14:0] = led[15:1];
                led_next[15] = led[0];
            end
            else if(en ==1 && dir == 1)begin
                led_next[0] = led[15];
                led_next[15:1] = led[14:0];
            end
            else begin
                led_next = led;
            end
        end
    end
endmodule
