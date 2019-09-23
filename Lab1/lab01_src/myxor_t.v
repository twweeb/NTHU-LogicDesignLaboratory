`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/20 03:14:14
// Design Name: 
// Module Name: myxor_t
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


module myxor_t;
reg a, b;
wire d;
reg pass;

myxor xxxor(.a(a),
             .b(b),
             .out(d)
             );

initial begin
//-------  xor
 #5  a = 1'b0; b = 1'b0;pass = 1'b1;
   #5;
   if (d!==1'b0) begin
     printerror;
   end
   
   #5 a = 1'b0; b = 1'b1;
   #5;
   if (d!==1'b1) begin
     printerror;
   end    
   
   #5  a = 1'b1; b = 1'b0;
   #5;
   if (d!==1'b1) begin
     printerror;
   end    
   
   #5  a = 1'b1; b = 1'b1;
   #5;
   if (d!==1'b0) begin
     printerror;
   end
if (pass===1'b1)
      $display(">>>> [PASS] Congratulations!");
    else
      $display(">>>> [ERROR] Try it again!");

    $finish;
end
             
task printerror;
  begin
  pass = 1'b0;
  $display($time," Error:  a = %b, b = %b, out = %b", a, b, d);
  end
  endtask
endmodule
