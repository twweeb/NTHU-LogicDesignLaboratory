`timescale 1ns/100ps

module mux4_to_1(
  q_o,
  a_i,
  b_i,
  c_i,
  d_i,
  sel_i
  );
 
  input a_i;
  input b_i;
  input c_i;
  input d_i;
  input [1:0] sel_i;
  output q_o;
 
  reg q_o;
 
  always @(a_i or b_i or c_i or d_i or sel_i) begin
    case (sel_i)
      2'b00 : q_o = a_i;
      2'b01 : q_o = b_i;
      2'b10 : q_o = c_i;
      2'b11 : q_o = d_i;
    endcase
  end
endmodule 
