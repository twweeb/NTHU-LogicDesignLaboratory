module lab1_2 (a, b, c, aluctr, d, e);
input a, b, c;
input [1:0] aluctr;
output d, e;
//	add your design here 

wire d1,d2,d3,d4;
wire e1,e2,e3,e4;

assign {e1,d1} = a + b + c;
assign d2 = a & b;
assign d3 = ! (a | b);
assign d4 = a ^ b;
assign e2 = 0;
assign e3 = 0;
assign e4 = 0;
assign d = (aluctr==0) ? d1 : (aluctr==1) ? d2 : (aluctr==2) ? d3 : d4;
assign e = (aluctr==0) ? e1 : (aluctr==1) ? e2 : (aluctr==2) ? e3 : e4;      

endmodule
