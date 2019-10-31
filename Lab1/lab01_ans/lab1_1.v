module lab1_1 (a, b, c, aluctr, d, e);
input a, b, c;
input [1:0] aluctr;
output d, e;
// add your design here  
wire d1,d2,d3,d4,d3_n;
wire e1,e2,e3,e4;
wire A_and_B,A_xor_B,A_XOR_B_and_C;
wire m,n,A_xor_B_n,b_n;

// the part of Adder  ( ctr = 0)
myxor xor1(.out(A_xor_B),.a(a),.b(b));
myxor xor2(.out(d1),.a(A_xor_B),.b(c));
and(A_and_B,a,b);
and(A_XOR_B_and_C,A_xor_B,c);
or(e1,A_and_B,A_XOR_B_and_C);

//  ctr = 1
and(d2, a, b );
and(e2, 0, 0 );

//  ctr = 2
or(d3_n,a,b);
not(d3,d3_n);
and(e3, 0, 0 );


//  ctr = 3
myxor xor3(.out(d4),.a(a),.b(b));
and(e4, 0, 0 );
 
mux4_to_1 d_mux(.q_o(d),.a_i(d1),.b_i(d2),.c_i(d3),.d_i(d4),.sel_i(aluctr));
mux4_to_1 e_mux(.q_o(e),.a_i(e1),.b_i(e2),.c_i(e3),.d_i(e4),.sel_i(aluctr));

endmodule
