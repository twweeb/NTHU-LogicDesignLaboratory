// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Wed Jan  8 20:47:39 2020
// Host        : DESKTOP-FUIN3UU running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/leihsiung/Desktop/Lab/dinosaur/dinosaur.srcs/sources_1/ip/KeyboardCtrl_0/KeyboardCtrl_0_stub.v
// Design      : KeyboardCtrl_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "KeyboardCtrl,Vivado 2019.1" *)
module KeyboardCtrl_0(key_in, is_extend, is_break, valid, err, PS2_DATA, 
  PS2_CLK, rst, clk)
/* synthesis syn_black_box black_box_pad_pin="key_in[7:0],is_extend,is_break,valid,err,PS2_DATA,PS2_CLK,rst,clk" */;
  output [7:0]key_in;
  output is_extend;
  output is_break;
  output valid;
  output err;
  inout PS2_DATA;
  inout PS2_CLK;
  input rst;
  input clk;
endmodule
