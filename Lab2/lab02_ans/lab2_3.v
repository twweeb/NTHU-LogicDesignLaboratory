`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2018 17:35:24
// Design Name: 
// Module Name: lab2_3
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


module lab2_3(clk,rst_n,out);
       input clk,rst_n;
       output out;
       
       reg [5:0] F;
       reg out;
       always@(*)begin
            if(rst_n==0)begin
           F=6'b000001;
           end
       end
       
       always@(posedge clk)begin
            if(rst_n!=0)begin
           {out,F[5:1]} <= F[5:0];
           F[0] <= F[5]^F[0];
           end  
       end
endmodule
