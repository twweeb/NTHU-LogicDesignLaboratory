`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.09.2018 11:43:06
// Design Name: 
// Module Name: lab2_1
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


module lab2_1(clk, rst_n, en, dir,in,data, out);
    input clk,rst_n,en,dir,in;
    input [3:0] data;
    output [3:0] out;
    
    reg [3:0] out=0;
    
    always@(posedge clk)begin
        if(rst_n==0) out = 4'b0000;
        else if(en==1'b1)begin
            if(in ==1)begin
                out = data;
            end
            else begin 
                case(dir)
                    0:begin
                        if(out>4'b0000) out = out-1;
                        else out = 4'b1111;
                    end
                    1:begin
                        if(out<4'b1111) out = out+1;
                        else out = 4'b0000;
                    end
                 endcase
             end
         end   
    end
    
endmodule
