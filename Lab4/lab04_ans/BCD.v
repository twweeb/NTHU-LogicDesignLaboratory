module BCD(in,out);
input [15:0] in;
output [15:0] out;

assign out[15:12] = (in[15:12]/10 > 0) ? 9 : in[15:12] % 10 ;
assign out[11:8] = (in[11:8]/10 > 0) ? 9 : in[11:8] % 10 ;
assign out[7:4] = (in[7:4]/10 > 0) ? 9 : in[7:4] % 10 ;
assign out[3:0] = (in[3:0]/10 > 0) ? 9 : in[3:0] % 10 ;

endmodule