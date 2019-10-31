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

module lab03_3(clk,rst,en,dir,led);
    input clk,rst,en,dir;
    output[15:0] led;
    reg[15:0]led1_next,led3_next,led1,led3;
    reg[3:0]position1,position3,position1_next,position3_next;
    wire clk_div1,clk_div3,clk_div23,clk_div26;
    reg[1:0]dir1,dir1_next;
	
	clock_divider #(26) div1(.clk(clk), .clk_div(clk_div26));
    clock_divider #(23) div2(.clk(clk), .clk_div(clk_div23));

    always@(posedge clk_div23)begin
        if(rst)begin
            led1 <= 16'b1000000000000000;
            position1 <= 4'd15;
            dir1 <= 2'b0;
        end
        else begin
            led1 <= led1_next;
            position1 <= position1_next;
            dir1 <= dir1_next;
        end
    end

    always@(posedge clk_div26)begin
        if(rst)begin
            led3 <= 16'b1110000000000000;
            position3 <= 4'd14;
        end
        else begin
            led3 <= led3_next;
            position3 <= position3_next;
        end
    end
    

    always@(*)begin
        if(en)begin
            led3_next[15] = led3[0];
            led3_next[14:0] = led3[15:1];
            position3_next = (position3 == 4'd0)? 4'd15 : position3 - 4'd1;
            if(position1 - position3 == 4'd1 && dir1 == 2'b0)begin // collision when Mr.1 shifts right turn left
                led1_next[0] = led1[15];
                led1_next[15:1] = led1[14:0];
                position1_next = (position1 + 4'd1) % 5'd16;
                dir1_next = 2'b1;
            end
            else if((position3 - position1 == 4'd1 || position3 - position1 == 4'd0) && dir1 == 2'b1)begin //collision when Mr.1 shifts left  turn right
                led1_next[15] = led1[0];
                led1_next[14:0] = led1[15:1];
                position1_next = (position1 == 4'd0)? 4'd15 : position1 - 4'd1;
                dir1_next = 2'b0;
            end
            else begin
                if(dir1 == 2'b0)begin
                    led1_next[15] = led1[0];
                    led1_next[14:0] = led1[15:1];
                    position1_next = (position1 == 4'd0)? 4'd15 : position1 - 4'd1;
                    dir1_next = dir1;
                end
                else begin
                    led1_next[0] = led1[15];
                    led1_next[15:1] = led1[14:0];
                    position1_next = (position1 + 4'd1) % 5'd16;
                    dir1_next = dir1;
                end
            end
        end

        else begin
            led3_next = led3;
            led1_next = led1;
            position3_next = position3;
            position1_next = position1;
            dir1_next = dir1;
        end
    end

	assign led = led1 | led3;

endmodule
