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

module lab03_2(clk,rst,en,dir,led);
    input clk,rst,en,dir;
    output[15:0] led;
    reg[15:0]led1_next,led3_next;
    reg[15:0]led1,led3;
    wire clk_div1,clk_div3,clk_div23,clk_div26;
	
	clock_divider #(26) div1(.clk(clk), .clk_div(clk_div26));
    clock_divider #(23) div2(.clk(clk), .clk_div(clk_div23));
        
    assign clk_div1 = (dir == 1)?clk_div26 : clk_div23;
	assign clk_div3 = (dir == 1)?clk_div23 : clk_div26;

        always@(posedge clk_div3)begin
            led3 <= led3_next;
        end
		always@(posedge clk_div1)begin
            led1 <= led1_next;
        end
        always@(*)begin
            if(rst == 1)begin
                led3_next = 16'b1110000000000000;
				led1_next = 16'b1000000000000000;
            end
            else begin
                if(en == 1 && dir == 0)begin
                    led1_next[14:0] = led1[15:1];
                    led1_next[15] = led1[0];
					led3_next[14:0] = led3[15:1];
                    led3_next[15] = led3[0];
                end
                else if (en == 1 && dir == 1)begin
                    led1_next[0] = led1[15];
                    led1_next[15:1] = led1[14:0];
                    led3_next[0] = led3[15];
                    led3_next[15:1] = led3[14:0];
                end
                else begin
                    led1_next = led1;
					led3_next = led3;
                end
            end
        end
	assign led = led1 | led3;

endmodule
