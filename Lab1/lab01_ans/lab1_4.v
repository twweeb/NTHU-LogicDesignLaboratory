module lab1_4 (a, b, c, aluctr, d, e);
input [3:0] a,b;
input [1:0] aluctr;
input c;
output [3:0] d;
output e;

wire _e[2:0];
//	add your design here 
lab1_3 alu1(.a(a[0]), .b(b[0]), .c(c), .aluctr(aluctr), .d(d[0]), .e(_e[0]));
lab1_3 alu2(.a(a[1]), .b(b[1]), .c(_e[0]), .aluctr(aluctr), .d(d[1]), .e(_e[1]));
lab1_3 alu3(.a(a[2]), .b(b[2]), .c(_e[1]), .aluctr(aluctr), .d(d[2]), .e(_e[2]));
lab1_3 alu4(.a(a[3]), .b(b[3]), .c(_e[2]), .aluctr(aluctr), .d(d[3]), .e(e));

endmodule
