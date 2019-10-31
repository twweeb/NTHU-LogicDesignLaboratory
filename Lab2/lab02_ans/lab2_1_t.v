`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.09.2018 11:43:49
// Design Name: 
// Module Name: lab2_1_t
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


module lab2_1_t;
    reg	clk, rst_n, en, dir;
    reg pass,in;
    reg [3:0] data;
    wire [3:0] out;
    integer num;
    
   lab2_1 counter (.clk(clk), .rst_n(rst_n), .en(en), .dir(dir),.in(in),.data(data), .out(out));
  
    always #5 clk = ~clk;
    initial clk=0;
    
     always @(negedge rst_n) begin
            if (rst_n) 
                num <= 0;  
     end  
     
     
    initial begin
    
        rst_n=0;
        en=0;
        dir=1;
        num=0;
        pass=1;
        in=0;
        data=0;
        #40 
        en=1;
        dir=1;
        rst_n=1;
        #60 
        dir=0;
        #60
        in =1;
        data= 8;
        dir=1;
        #15
        in=0;
        #30
        en=0;
        #50
        en=1;
        dir=0;
        #50
        
        if(pass==1) $display("PASS!!!!");
        else $display("WRONG!!");
      $finish;    
    end
    
    always@(posedge clk)begin
        
        if (en == 1'b1 && dir == 1'b1) begin
            num <= (in == 1) ? data : (num == 15) ? 0 : num + 1;
        end 
        else if (en == 1'b1 && dir == 1'b0)begin
            num <= (in == 1) ? data : (num == 0) ?  15 : num - 1;
        end
      
        
    end
    always@(negedge clk)begin
         if(num!=out) pass=0;
    end
     
endmodule
