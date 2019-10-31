`timescale 1ns/100ps

module myxor (out, a, b);
input a, b;
output out;
//add your design here
wire c,d;
wire a_not,b_not;
not(a_not ,a);
not(b_not ,b);
and(c, a_not, b);
and(d, b_not, a);
or(out,c,d);

endmodule
