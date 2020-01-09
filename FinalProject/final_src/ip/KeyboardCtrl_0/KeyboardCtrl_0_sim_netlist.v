// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Wed Jan  8 20:47:39 2020
// Host        : DESKTOP-FUIN3UU running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/leihsiung/Desktop/Lab/dinosaur/dinosaur.srcs/sources_1/ip/KeyboardCtrl_0/KeyboardCtrl_0_sim_netlist.v
// Design      : KeyboardCtrl_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "KeyboardCtrl_0,KeyboardCtrl,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "KeyboardCtrl,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module KeyboardCtrl_0
   (key_in,
    is_extend,
    is_break,
    valid,
    err,
    PS2_DATA,
    PS2_CLK,
    rst,
    clk);
  output [7:0]key_in;
  output is_extend;
  output is_break;
  output valid;
  output err;
  inout PS2_DATA;
  inout PS2_CLK;
  input rst;
  input clk;

  (* DRIVE = "12" *) (* IBUF_LOW_PWR *) (* SLEW = "SLOW" *) wire PS2_CLK;
  (* DRIVE = "12" *) (* IBUF_LOW_PWR *) (* SLEW = "SLOW" *) wire PS2_DATA;
  wire clk;
  wire err;
  wire is_break;
  wire is_extend;
  wire [7:0]key_in;
  wire rst;
  wire valid;

  KeyboardCtrl_0_KeyboardCtrl inst
       (.PS2_CLK(PS2_CLK),
        .PS2_DATA(PS2_DATA),
        .clk(clk),
        .err(err),
        .is_break(is_break),
        .is_extend(is_extend),
        .key_in(key_in),
        .rst(rst),
        .valid(valid));
endmodule

(* ORIG_REF_NAME = "KeyboardCtrl" *) 
module KeyboardCtrl_0_KeyboardCtrl
   (err,
    key_in,
    is_break,
    valid,
    is_extend,
    PS2_CLK,
    PS2_DATA,
    clk,
    rst);
  output err;
  output [7:0]key_in;
  output is_break;
  output valid;
  output is_extend;
  inout PS2_CLK;
  inout PS2_DATA;
  input clk;
  input rst;

  wire PS2_CLK;
  wire PS2_DATA;
  wire Ps2Interface_i_n_11;
  wire Ps2Interface_i_n_12;
  wire Ps2Interface_i_n_13;
  wire Ps2Interface_i_n_14;
  wire Ps2Interface_i_n_16;
  wire Ps2Interface_i_n_2;
  wire clk;
  wire err;
  wire is_break;
  wire is_extend;
  wire [7:0]key_in;
  wire rst;
  wire [7:0]rx_data;
  wire rx_valid;
  wire [2:0]state;
  wire \tx_data[0]_i_1_n_0 ;
  wire \tx_data[7]_i_1_n_0 ;
  wire \tx_data_reg_n_0_[0] ;
  wire \tx_data_reg_n_0_[7] ;
  wire tx_valid;
  wire tx_valid_reg_n_0;
  wire valid;

  (* FSM_ENCODED_STATES = "SEND_CMD:001,WAIT_ACK:010,GET_BREAK:110,GET_EXTEND:101,WAIT_KEYIN:100,RESET_WAIT_BAT:011,RESET:000" *) 
  FDCE \FSM_sequential_state_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Ps2Interface_i_n_14),
        .Q(state[0]));
  (* FSM_ENCODED_STATES = "SEND_CMD:001,WAIT_ACK:010,GET_BREAK:110,GET_EXTEND:101,WAIT_KEYIN:100,RESET_WAIT_BAT:011,RESET:000" *) 
  FDCE \FSM_sequential_state_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Ps2Interface_i_n_13),
        .Q(state[1]));
  (* FSM_ENCODED_STATES = "SEND_CMD:001,WAIT_ACK:010,GET_BREAK:110,GET_EXTEND:101,WAIT_KEYIN:100,RESET_WAIT_BAT:011,RESET:000" *) 
  FDCE \FSM_sequential_state_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Ps2Interface_i_n_12),
        .Q(state[2]));
  KeyboardCtrl_0_Ps2Interface Ps2Interface_i
       (.D({Ps2Interface_i_n_12,Ps2Interface_i_n_13,Ps2Interface_i_n_14}),
        .\FSM_sequential_state_reg[0] (Ps2Interface_i_n_2),
        .\FSM_sequential_state_reg[2] (Ps2Interface_i_n_11),
        .PS2_CLK(PS2_CLK),
        .PS2_DATA(PS2_DATA),
        .Q(state),
        .clk(clk),
        .err_reg_0(err),
        .\frame_reg[9]_0 (tx_valid_reg_n_0),
        .\frame_reg[9]_1 (\tx_data_reg_n_0_[0] ),
        .\frame_reg[9]_2 (\tx_data_reg_n_0_[7] ),
        .is_extend(is_extend),
        .rst(rst),
        .\rx_data_reg[4]_0 (Ps2Interface_i_n_16),
        .\rx_data_reg[7]_0 (rx_data),
        .rx_valid(rx_valid),
        .tx_valid(tx_valid));
  FDPE is_break_reg
       (.C(clk),
        .CE(1'b1),
        .D(Ps2Interface_i_n_11),
        .PRE(rst),
        .Q(is_break));
  FDCE is_extend_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Ps2Interface_i_n_2),
        .Q(is_extend));
  FDCE \key_in_reg[0] 
       (.C(clk),
        .CE(rx_valid),
        .CLR(rst),
        .D(rx_data[0]),
        .Q(key_in[0]));
  FDCE \key_in_reg[1] 
       (.C(clk),
        .CE(rx_valid),
        .CLR(rst),
        .D(rx_data[1]),
        .Q(key_in[1]));
  FDCE \key_in_reg[2] 
       (.C(clk),
        .CE(rx_valid),
        .CLR(rst),
        .D(rx_data[2]),
        .Q(key_in[2]));
  FDCE \key_in_reg[3] 
       (.C(clk),
        .CE(rx_valid),
        .CLR(rst),
        .D(rx_data[3]),
        .Q(key_in[3]));
  FDCE \key_in_reg[4] 
       (.C(clk),
        .CE(rx_valid),
        .CLR(rst),
        .D(rx_data[4]),
        .Q(key_in[4]));
  FDCE \key_in_reg[5] 
       (.C(clk),
        .CE(rx_valid),
        .CLR(rst),
        .D(rx_data[5]),
        .Q(key_in[5]));
  FDCE \key_in_reg[6] 
       (.C(clk),
        .CE(rx_valid),
        .CLR(rst),
        .D(rx_data[6]),
        .Q(key_in[6]));
  FDCE \key_in_reg[7] 
       (.C(clk),
        .CE(rx_valid),
        .CLR(rst),
        .D(rx_data[7]),
        .Q(key_in[7]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT4 #(
    .INIT(16'hFF01)) 
    \tx_data[0]_i_1 
       (.I0(state[1]),
        .I1(state[2]),
        .I2(state[0]),
        .I3(\tx_data_reg_n_0_[0] ),
        .O(\tx_data[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT4 #(
    .INIT(16'hFF01)) 
    \tx_data[7]_i_1 
       (.I0(state[1]),
        .I1(state[2]),
        .I2(state[0]),
        .I3(\tx_data_reg_n_0_[7] ),
        .O(\tx_data[7]_i_1_n_0 ));
  FDCE \tx_data_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\tx_data[0]_i_1_n_0 ),
        .Q(\tx_data_reg_n_0_[0] ));
  FDCE \tx_data_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\tx_data[7]_i_1_n_0 ),
        .Q(\tx_data_reg_n_0_[7] ));
  FDCE tx_valid_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(tx_valid),
        .Q(tx_valid_reg_n_0));
  FDCE valid_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Ps2Interface_i_n_16),
        .Q(valid));
endmodule

(* ORIG_REF_NAME = "Ps2Interface" *) 
module KeyboardCtrl_0_Ps2Interface
   (rx_valid,
    err_reg_0,
    \FSM_sequential_state_reg[0] ,
    \rx_data_reg[7]_0 ,
    \FSM_sequential_state_reg[2] ,
    D,
    tx_valid,
    \rx_data_reg[4]_0 ,
    PS2_CLK,
    PS2_DATA,
    clk,
    rst,
    \frame_reg[9]_0 ,
    Q,
    is_extend,
    \frame_reg[9]_1 ,
    \frame_reg[9]_2 );
  output rx_valid;
  output err_reg_0;
  output \FSM_sequential_state_reg[0] ;
  output [7:0]\rx_data_reg[7]_0 ;
  output \FSM_sequential_state_reg[2] ;
  output [2:0]D;
  output tx_valid;
  output \rx_data_reg[4]_0 ;
  inout PS2_CLK;
  inout PS2_DATA;
  input clk;
  input rst;
  input \frame_reg[9]_0 ;
  input [2:0]Q;
  input is_extend;
  input \frame_reg[9]_1 ;
  input \frame_reg[9]_2 ;

  wire [2:0]D;
  wire \FSM_onehot_state[0]_i_1_n_0 ;
  wire \FSM_onehot_state[0]_i_2_n_0 ;
  wire \FSM_onehot_state[10]_i_1_n_0 ;
  wire \FSM_onehot_state[11]_i_1_n_0 ;
  wire \FSM_onehot_state[12]_i_1_n_0 ;
  wire \FSM_onehot_state[12]_i_2_n_0 ;
  wire \FSM_onehot_state[12]_i_3_n_0 ;
  wire \FSM_onehot_state[12]_i_4_n_0 ;
  wire \FSM_onehot_state[13]_i_1_n_0 ;
  wire \FSM_onehot_state[13]_i_2_n_0 ;
  wire \FSM_onehot_state[14]_i_1_n_0 ;
  wire \FSM_onehot_state[14]_i_2_n_0 ;
  wire \FSM_onehot_state[14]_i_3_n_0 ;
  wire \FSM_onehot_state[14]_i_4_n_0 ;
  wire \FSM_onehot_state[1]_i_1_n_0 ;
  wire \FSM_onehot_state[2]_i_1_n_0 ;
  wire \FSM_onehot_state[2]_i_2_n_0 ;
  wire \FSM_onehot_state[3]_i_1_n_0 ;
  wire \FSM_onehot_state[4]_i_1_n_0 ;
  wire \FSM_onehot_state[4]_i_2_n_0 ;
  wire \FSM_onehot_state[5]_i_1_n_0 ;
  wire \FSM_onehot_state[6]_i_1_n_0 ;
  wire \FSM_onehot_state[7]_i_1_n_0 ;
  wire \FSM_onehot_state[8]_i_1_n_0 ;
  wire \FSM_onehot_state[9]_i_1_n_0 ;
  wire \FSM_onehot_state[9]_i_2_n_0 ;
  wire \FSM_onehot_state_reg_n_0_[0] ;
  wire \FSM_onehot_state_reg_n_0_[10] ;
  wire \FSM_onehot_state_reg_n_0_[12] ;
  wire \FSM_onehot_state_reg_n_0_[13] ;
  wire \FSM_onehot_state_reg_n_0_[14] ;
  wire \FSM_onehot_state_reg_n_0_[1] ;
  wire \FSM_onehot_state_reg_n_0_[2] ;
  wire \FSM_onehot_state_reg_n_0_[3] ;
  wire \FSM_onehot_state_reg_n_0_[4] ;
  wire \FSM_onehot_state_reg_n_0_[5] ;
  wire \FSM_onehot_state_reg_n_0_[6] ;
  wire \FSM_onehot_state_reg_n_0_[7] ;
  wire \FSM_onehot_state_reg_n_0_[8] ;
  wire \FSM_onehot_state_reg_n_0_[9] ;
  wire \FSM_sequential_state[0]_i_2_n_0 ;
  wire \FSM_sequential_state[0]_i_3_n_0 ;
  wire \FSM_sequential_state[1]_i_2_n_0 ;
  wire \FSM_sequential_state[1]_i_3_n_0 ;
  wire \FSM_sequential_state[1]_i_4_n_0 ;
  wire \FSM_sequential_state[1]_i_5_n_0 ;
  wire \FSM_sequential_state[2]_i_2_n_0 ;
  wire \FSM_sequential_state[2]_i_3_n_0 ;
  wire \FSM_sequential_state[2]_i_4_n_0 ;
  wire \FSM_sequential_state[2]_i_5_n_0 ;
  wire \FSM_sequential_state_reg[0] ;
  wire \FSM_sequential_state_reg[2] ;
  wire PS2_CLK;
  wire PS2_DATA;
  wire [2:0]Q;
  wire T0;
  wire bits_count;
  wire \bits_count[0]_i_1_n_0 ;
  wire \bits_count[1]_i_1_n_0 ;
  wire \bits_count[2]_i_1_n_0 ;
  wire \bits_count[3]_i_2_n_0 ;
  wire \bits_count_reg_n_0_[0] ;
  wire \bits_count_reg_n_0_[1] ;
  wire \bits_count_reg_n_0_[2] ;
  wire \bits_count_reg_n_0_[3] ;
  wire clk;
  wire [3:0]clk_count;
  wire \clk_count[0]_i_1_n_0 ;
  wire \clk_count[1]_i_1_n_0 ;
  wire \clk_count[2]_i_1_n_0 ;
  wire \clk_count[3]_i_1_n_0 ;
  wire clk_inter;
  wire [13:0]counter;
  wire \counter[0]_i_1_n_0 ;
  wire \counter[10]_i_1_n_0 ;
  wire \counter[11]_i_1_n_0 ;
  wire \counter[12]_i_1_n_0 ;
  wire \counter[13]_i_1_n_0 ;
  wire \counter[13]_i_3_n_0 ;
  wire \counter[13]_i_4_n_0 ;
  wire \counter[13]_i_5_n_0 ;
  wire \counter[1]_i_1_n_0 ;
  wire \counter[2]_i_1_n_0 ;
  wire \counter[3]_i_1_n_0 ;
  wire \counter[4]_i_1_n_0 ;
  wire \counter[5]_i_1_n_0 ;
  wire \counter[6]_i_1_n_0 ;
  wire \counter[7]_i_1_n_0 ;
  wire \counter[8]_i_1_n_0 ;
  wire \counter[9]_i_1_n_0 ;
  wire \counter_reg[12]_i_2_n_0 ;
  wire \counter_reg[12]_i_2_n_1 ;
  wire \counter_reg[12]_i_2_n_2 ;
  wire \counter_reg[12]_i_2_n_3 ;
  wire \counter_reg[4]_i_2_n_0 ;
  wire \counter_reg[4]_i_2_n_1 ;
  wire \counter_reg[4]_i_2_n_2 ;
  wire \counter_reg[4]_i_2_n_3 ;
  wire \counter_reg[8]_i_2_n_0 ;
  wire \counter_reg[8]_i_2_n_1 ;
  wire \counter_reg[8]_i_2_n_2 ;
  wire \counter_reg[8]_i_2_n_3 ;
  wire [13:1]data1;
  wire [3:0]data_count;
  wire \data_count[0]_i_1_n_0 ;
  wire \data_count[1]_i_1_n_0 ;
  wire \data_count[2]_i_1_n_0 ;
  wire \data_count[3]_i_1_n_0 ;
  wire data_inter;
  wire err_i_2_n_0;
  wire err_i_3_n_0;
  wire err_next;
  wire err_reg_0;
  wire \frame[10]_i_1_n_0 ;
  wire \frame_reg[9]_0 ;
  wire \frame_reg[9]_1 ;
  wire \frame_reg[9]_2 ;
  wire \frame_reg_n_0_[0] ;
  wire \frame_reg_n_0_[10] ;
  wire \frame_reg_n_0_[9] ;
  wire is_extend;
  wire [7:0]p_0_in;
  wire [10:0]p_1_in;
  wire p_1_in_0;
  wire \parity_table_inferred__0/i_/i__n_0 ;
  wire ps2_clk_en_next;
  wire ps2_clk_in;
  wire ps2_clk_out;
  wire ps2_clk_out_i_2_n_0;
  wire ps2_clk_out_i_3_n_0;
  wire ps2_clk_out_next;
  wire ps2_clk_s_i_1_n_0;
  wire ps2_clk_s_n_0;
  wire ps2_data_en_next;
  wire ps2_data_en_reg_inv_n_0;
  wire ps2_data_in;
  wire ps2_data_out;
  wire ps2_data_out_i_2_n_0;
  wire ps2_data_out_next;
  wire ps2_data_s__0;
  wire ps2_data_s_i_1_n_0;
  wire ps2_data_s_n_0;
  wire rst;
  wire \rx_data_reg[4]_0 ;
  wire [7:0]\rx_data_reg[7]_0 ;
  wire rx_finish;
  wire rx_valid;
  wire state_next1;
  wire tx_valid;
  wire valid_i_2_n_0;
  wire valid_i_3_n_0;
  wire [3:0]\NLW_counter_reg[13]_i_2_CO_UNCONNECTED ;
  wire [3:1]\NLW_counter_reg[13]_i_2_O_UNCONNECTED ;

  LUT6 #(
    .INIT(64'hAAAAAAAA80888888)) 
    \FSM_onehot_state[0]_i_1 
       (.I0(state_next1),
        .I1(\FSM_onehot_state_reg_n_0_[0] ),
        .I2(\bits_count_reg_n_0_[2] ),
        .I3(\bits_count_reg_n_0_[3] ),
        .I4(\FSM_onehot_state[0]_i_2_n_0 ),
        .I5(\FSM_onehot_state_reg_n_0_[6] ),
        .O(\FSM_onehot_state[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_onehot_state[0]_i_2 
       (.I0(\bits_count_reg_n_0_[0] ),
        .I1(\bits_count_reg_n_0_[1] ),
        .O(\FSM_onehot_state[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \FSM_onehot_state[10]_i_1 
       (.I0(state_next1),
        .I1(\FSM_onehot_state_reg_n_0_[10] ),
        .I2(\FSM_onehot_state[13]_i_2_n_0 ),
        .O(\FSM_onehot_state[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'h2322)) 
    \FSM_onehot_state[11]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[10] ),
        .I1(state_next1),
        .I2(\FSM_onehot_state[12]_i_2_n_0 ),
        .I3(\FSM_onehot_state_reg_n_0_[12] ),
        .O(\FSM_onehot_state[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'hFEAA)) 
    \FSM_onehot_state[12]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[14] ),
        .I1(state_next1),
        .I2(\FSM_onehot_state[12]_i_2_n_0 ),
        .I3(\FSM_onehot_state_reg_n_0_[12] ),
        .O(\FSM_onehot_state[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFBFFFFFFFFF)) 
    \FSM_onehot_state[12]_i_2 
       (.I0(\FSM_onehot_state[12]_i_3_n_0 ),
        .I1(counter[2]),
        .I2(counter[1]),
        .I3(counter[8]),
        .I4(counter[11]),
        .I5(\FSM_onehot_state[12]_i_4_n_0 ),
        .O(\FSM_onehot_state[12]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hDFFF)) 
    \FSM_onehot_state[12]_i_3 
       (.I0(counter[0]),
        .I1(counter[10]),
        .I2(counter[5]),
        .I3(counter[3]),
        .O(\FSM_onehot_state[12]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000100)) 
    \FSM_onehot_state[12]_i_4 
       (.I0(counter[7]),
        .I1(counter[6]),
        .I2(counter[9]),
        .I3(counter[4]),
        .I4(counter[12]),
        .I5(counter[13]),
        .O(\FSM_onehot_state[12]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hAB)) 
    \FSM_onehot_state[13]_i_1 
       (.I0(p_1_in_0),
        .I1(\FSM_onehot_state[13]_i_2_n_0 ),
        .I2(state_next1),
        .O(\FSM_onehot_state[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h0400FFFF)) 
    \FSM_onehot_state[13]_i_2 
       (.I0(\bits_count_reg_n_0_[0] ),
        .I1(\bits_count_reg_n_0_[1] ),
        .I2(\bits_count_reg_n_0_[2] ),
        .I3(\bits_count_reg_n_0_[3] ),
        .I4(\FSM_onehot_state_reg_n_0_[13] ),
        .O(\FSM_onehot_state[13]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_onehot_state[14]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[4] ),
        .I1(\FSM_onehot_state[14]_i_2_n_0 ),
        .O(\FSM_onehot_state[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFEFFFFFF)) 
    \FSM_onehot_state[14]_i_2 
       (.I0(\FSM_onehot_state[14]_i_3_n_0 ),
        .I1(counter[13]),
        .I2(counter[12]),
        .I3(counter[7]),
        .I4(counter[6]),
        .I5(\FSM_onehot_state[14]_i_4_n_0 ),
        .O(\FSM_onehot_state[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \FSM_onehot_state[14]_i_3 
       (.I0(counter[1]),
        .I1(counter[2]),
        .I2(counter[3]),
        .I3(counter[11]),
        .I4(counter[0]),
        .I5(counter[5]),
        .O(\FSM_onehot_state[14]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \FSM_onehot_state[14]_i_4 
       (.I0(counter[9]),
        .I1(counter[4]),
        .I2(counter[8]),
        .I3(counter[10]),
        .O(\FSM_onehot_state[14]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hDDD5DDDDDDD5DDD5)) 
    \FSM_onehot_state[1]_i_1 
       (.I0(err_i_2_n_0),
        .I1(state_next1),
        .I2(\FSM_onehot_state_reg_n_0_[5] ),
        .I3(\FSM_onehot_state_reg_n_0_[8] ),
        .I4(\frame_reg[9]_0 ),
        .I5(\FSM_onehot_state_reg_n_0_[1] ),
        .O(\FSM_onehot_state[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h5504)) 
    \FSM_onehot_state[2]_i_1 
       (.I0(state_next1),
        .I1(\FSM_onehot_state_reg_n_0_[1] ),
        .I2(\frame_reg[9]_0 ),
        .I3(\FSM_onehot_state[2]_i_2_n_0 ),
        .O(\FSM_onehot_state[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h8AAAAAAA)) 
    \FSM_onehot_state[2]_i_2 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(\bits_count_reg_n_0_[2] ),
        .I2(\bits_count_reg_n_0_[3] ),
        .I3(\bits_count_reg_n_0_[0] ),
        .I4(\bits_count_reg_n_0_[1] ),
        .O(\FSM_onehot_state[2]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \FSM_onehot_state[3]_i_1 
       (.I0(\frame_reg[9]_0 ),
        .I1(\FSM_onehot_state_reg_n_0_[1] ),
        .I2(\FSM_onehot_state[4]_i_2_n_0 ),
        .I3(\FSM_onehot_state_reg_n_0_[3] ),
        .O(\FSM_onehot_state[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT4 #(
    .INIT(16'h8F88)) 
    \FSM_onehot_state[4]_i_1 
       (.I0(\FSM_onehot_state[14]_i_2_n_0 ),
        .I1(\FSM_onehot_state_reg_n_0_[4] ),
        .I2(\FSM_onehot_state[4]_i_2_n_0 ),
        .I3(\FSM_onehot_state_reg_n_0_[3] ),
        .O(\FSM_onehot_state[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFEFF)) 
    \FSM_onehot_state[4]_i_2 
       (.I0(\FSM_onehot_state[14]_i_3_n_0 ),
        .I1(counter[7]),
        .I2(counter[6]),
        .I3(counter[13]),
        .I4(counter[12]),
        .I5(\FSM_onehot_state[14]_i_4_n_0 ),
        .O(\FSM_onehot_state[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'h4544)) 
    \FSM_onehot_state[5]_i_1 
       (.I0(state_next1),
        .I1(\FSM_onehot_state_reg_n_0_[5] ),
        .I2(ps2_data_s__0),
        .I3(\FSM_onehot_state_reg_n_0_[7] ),
        .O(\FSM_onehot_state[5]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hBA)) 
    \FSM_onehot_state[6]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[2] ),
        .I1(state_next1),
        .I2(\FSM_onehot_state_reg_n_0_[6] ),
        .O(\FSM_onehot_state[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hA8)) 
    \FSM_onehot_state[7]_i_1 
       (.I0(state_next1),
        .I1(\FSM_onehot_state_reg_n_0_[9] ),
        .I2(\FSM_onehot_state_reg_n_0_[7] ),
        .O(\FSM_onehot_state[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'h5444)) 
    \FSM_onehot_state[8]_i_1 
       (.I0(state_next1),
        .I1(\FSM_onehot_state_reg_n_0_[8] ),
        .I2(\FSM_onehot_state_reg_n_0_[7] ),
        .I3(ps2_data_s__0),
        .O(\FSM_onehot_state[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h8F88)) 
    \FSM_onehot_state[9]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[13] ),
        .I1(\FSM_onehot_state[9]_i_2_n_0 ),
        .I2(state_next1),
        .I3(\FSM_onehot_state_reg_n_0_[9] ),
        .O(\FSM_onehot_state[9]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h0020)) 
    \FSM_onehot_state[9]_i_2 
       (.I0(\bits_count_reg_n_0_[3] ),
        .I1(\bits_count_reg_n_0_[2] ),
        .I2(\bits_count_reg_n_0_[1] ),
        .I3(\bits_count_reg_n_0_[0] ),
        .O(\FSM_onehot_state[9]_i_2_n_0 ));
  (* FSM_ENCODED_STATES = "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\FSM_onehot_state[0]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[0] ));
  (* FSM_ENCODED_STATES = "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\FSM_onehot_state[10]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[10] ));
  (* FSM_ENCODED_STATES = "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\FSM_onehot_state[11]_i_1_n_0 ),
        .Q(p_1_in_0));
  (* FSM_ENCODED_STATES = "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\FSM_onehot_state[12]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[12] ));
  (* FSM_ENCODED_STATES = "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\FSM_onehot_state[13]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[13] ));
  (* FSM_ENCODED_STATES = "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[14] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\FSM_onehot_state[14]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[14] ));
  (* FSM_ENCODED_STATES = "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000" *) 
  FDPE #(
    .INIT(1'b1)) 
    \FSM_onehot_state_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\FSM_onehot_state[1]_i_1_n_0 ),
        .PRE(rst),
        .Q(\FSM_onehot_state_reg_n_0_[1] ));
  (* FSM_ENCODED_STATES = "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\FSM_onehot_state[2]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[2] ));
  (* FSM_ENCODED_STATES = "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\FSM_onehot_state[3]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[3] ));
  (* FSM_ENCODED_STATES = "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\FSM_onehot_state[4]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[4] ));
  (* FSM_ENCODED_STATES = "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\FSM_onehot_state[5]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[5] ));
  (* FSM_ENCODED_STATES = "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\FSM_onehot_state[6]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[6] ));
  (* FSM_ENCODED_STATES = "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\FSM_onehot_state[7]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[7] ));
  (* FSM_ENCODED_STATES = "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\FSM_onehot_state[8]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[8] ));
  (* FSM_ENCODED_STATES = "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\FSM_onehot_state[9]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[9] ));
  LUT5 #(
    .INIT(32'hFFFF0155)) 
    \FSM_sequential_state[0]_i_1 
       (.I0(\FSM_sequential_state[0]_i_2_n_0 ),
        .I1(valid_i_2_n_0),
        .I2(\rx_data_reg[7]_0 [4]),
        .I3(Q[2]),
        .I4(\FSM_sequential_state[0]_i_3_n_0 ),
        .O(D[0]));
  LUT6 #(
    .INIT(64'hFFFFEFFFAAAAAAAA)) 
    \FSM_sequential_state[0]_i_2 
       (.I0(Q[0]),
        .I1(\FSM_sequential_state[1]_i_4_n_0 ),
        .I2(valid_i_3_n_0),
        .I3(rx_valid),
        .I4(Q[2]),
        .I5(Q[1]),
        .O(\FSM_sequential_state[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00000202020200FF)) 
    \FSM_sequential_state[0]_i_3 
       (.I0(Q[0]),
        .I1(err_reg_0),
        .I2(rx_valid),
        .I3(\FSM_onehot_state_reg_n_0_[1] ),
        .I4(Q[2]),
        .I5(Q[1]),
        .O(\FSM_sequential_state[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF1F000000)) 
    \FSM_sequential_state[1]_i_1 
       (.I0(Q[2]),
        .I1(\FSM_sequential_state[2]_i_4_n_0 ),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(\FSM_sequential_state[1]_i_2_n_0 ),
        .I5(\FSM_sequential_state[1]_i_3_n_0 ),
        .O(D[1]));
  LUT6 #(
    .INIT(64'h1111111D11111111)) 
    \FSM_sequential_state[1]_i_2 
       (.I0(err_reg_0),
        .I1(rx_valid),
        .I2(Q[0]),
        .I3(Q[2]),
        .I4(\FSM_sequential_state[1]_i_4_n_0 ),
        .I5(valid_i_3_n_0),
        .O(\FSM_sequential_state[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAEAAAAAAAAAAAAAA)) 
    \FSM_sequential_state[1]_i_3 
       (.I0(tx_valid),
        .I1(Q[2]),
        .I2(Q[1]),
        .I3(\rx_data_reg[7]_0 [4]),
        .I4(\FSM_sequential_state[1]_i_5_n_0 ),
        .I5(valid_i_3_n_0),
        .O(\FSM_sequential_state[1]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \FSM_sequential_state[1]_i_4 
       (.I0(\rx_data_reg[7]_0 [3]),
        .I1(\frame_reg[9]_2 ),
        .I2(\frame_reg[9]_1 ),
        .I3(\rx_data_reg[7]_0 [1]),
        .I4(\rx_data_reg[7]_0 [4]),
        .O(\FSM_sequential_state[1]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \FSM_sequential_state[1]_i_5 
       (.I0(rx_valid),
        .I1(\rx_data_reg[7]_0 [3]),
        .I2(\rx_data_reg[7]_0 [1]),
        .O(\FSM_sequential_state[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h5F51515151515151)) 
    \FSM_sequential_state[2]_i_1 
       (.I0(\FSM_sequential_state[2]_i_2_n_0 ),
        .I1(\FSM_sequential_state[2]_i_3_n_0 ),
        .I2(Q[2]),
        .I3(Q[0]),
        .I4(Q[1]),
        .I5(\FSM_sequential_state[2]_i_4_n_0 ),
        .O(D[2]));
  LUT5 #(
    .INIT(32'hF444FF5F)) 
    \FSM_sequential_state[2]_i_2 
       (.I0(rx_valid),
        .I1(err_reg_0),
        .I2(Q[1]),
        .I3(Q[0]),
        .I4(Q[2]),
        .O(\FSM_sequential_state[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \FSM_sequential_state[2]_i_3 
       (.I0(valid_i_3_n_0),
        .I1(\rx_data_reg[7]_0 [4]),
        .I2(\rx_data_reg[7]_0 [1]),
        .I3(\frame_reg[9]_1 ),
        .I4(\frame_reg[9]_2 ),
        .I5(\rx_data_reg[7]_0 [3]),
        .O(\FSM_sequential_state[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000200000000000)) 
    \FSM_sequential_state[2]_i_4 
       (.I0(\FSM_sequential_state[2]_i_5_n_0 ),
        .I1(\rx_data_reg[7]_0 [6]),
        .I2(\rx_data_reg[7]_0 [3]),
        .I3(rx_valid),
        .I4(\rx_data_reg[7]_0 [4]),
        .I5(\rx_data_reg[7]_0 [1]),
        .O(\FSM_sequential_state[2]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h0008)) 
    \FSM_sequential_state[2]_i_5 
       (.I0(\rx_data_reg[7]_0 [5]),
        .I1(\rx_data_reg[7]_0 [7]),
        .I2(\rx_data_reg[7]_0 [0]),
        .I3(\rx_data_reg[7]_0 [2]),
        .O(\FSM_sequential_state[2]_i_5_n_0 ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  IOBUF #(
    .IOSTANDARD("DEFAULT")) 
    IOBUF_inst_0
       (.I(ps2_clk_out),
        .IO(PS2_CLK),
        .O(ps2_clk_in),
        .T(T0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  IOBUF #(
    .IOSTANDARD("DEFAULT")) 
    IOBUF_inst_1
       (.I(ps2_data_out),
        .IO(PS2_DATA),
        .O(ps2_data_in),
        .T(ps2_data_en_reg_inv_n_0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \bits_count[0]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[1] ),
        .I1(\bits_count_reg_n_0_[0] ),
        .O(\bits_count[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \bits_count[1]_i_1 
       (.I0(\bits_count_reg_n_0_[1] ),
        .I1(\bits_count_reg_n_0_[0] ),
        .I2(\FSM_onehot_state_reg_n_0_[1] ),
        .O(\bits_count[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h0078)) 
    \bits_count[2]_i_1 
       (.I0(\bits_count_reg_n_0_[0] ),
        .I1(\bits_count_reg_n_0_[1] ),
        .I2(\bits_count_reg_n_0_[2] ),
        .I3(\FSM_onehot_state_reg_n_0_[1] ),
        .O(\bits_count[2]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hFE)) 
    \bits_count[3]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[1] ),
        .I1(\FSM_onehot_state_reg_n_0_[2] ),
        .I2(p_1_in_0),
        .O(bits_count));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h15554000)) 
    \bits_count[3]_i_2 
       (.I0(\FSM_onehot_state_reg_n_0_[1] ),
        .I1(\bits_count_reg_n_0_[2] ),
        .I2(\bits_count_reg_n_0_[1] ),
        .I3(\bits_count_reg_n_0_[0] ),
        .I4(\bits_count_reg_n_0_[3] ),
        .O(\bits_count[3]_i_2_n_0 ));
  FDCE \bits_count_reg[0] 
       (.C(clk),
        .CE(bits_count),
        .CLR(rst),
        .D(\bits_count[0]_i_1_n_0 ),
        .Q(\bits_count_reg_n_0_[0] ));
  FDCE \bits_count_reg[1] 
       (.C(clk),
        .CE(bits_count),
        .CLR(rst),
        .D(\bits_count[1]_i_1_n_0 ),
        .Q(\bits_count_reg_n_0_[1] ));
  FDCE \bits_count_reg[2] 
       (.C(clk),
        .CE(bits_count),
        .CLR(rst),
        .D(\bits_count[2]_i_1_n_0 ),
        .Q(\bits_count_reg_n_0_[2] ));
  FDCE \bits_count_reg[3] 
       (.C(clk),
        .CE(bits_count),
        .CLR(rst),
        .D(\bits_count[3]_i_2_n_0 ),
        .Q(\bits_count_reg_n_0_[3] ));
  LUT6 #(
    .INIT(64'hD55500000000D555)) 
    \clk_count[0]_i_1 
       (.I0(clk_count[0]),
        .I1(clk_count[3]),
        .I2(clk_count[2]),
        .I3(clk_count[1]),
        .I4(ps2_clk_in),
        .I5(clk_inter),
        .O(\clk_count[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8FF0000000008FF0)) 
    \clk_count[1]_i_1 
       (.I0(clk_count[3]),
        .I1(clk_count[2]),
        .I2(clk_count[0]),
        .I3(clk_count[1]),
        .I4(ps2_clk_in),
        .I5(clk_inter),
        .O(\clk_count[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hBCCC00000000BCCC)) 
    \clk_count[2]_i_1 
       (.I0(clk_count[3]),
        .I1(clk_count[2]),
        .I2(clk_count[0]),
        .I3(clk_count[1]),
        .I4(ps2_clk_in),
        .I5(clk_inter),
        .O(\clk_count[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEAAA00000000EAAA)) 
    \clk_count[3]_i_1 
       (.I0(clk_count[3]),
        .I1(clk_count[2]),
        .I2(clk_count[0]),
        .I3(clk_count[1]),
        .I4(ps2_clk_in),
        .I5(clk_inter),
        .O(\clk_count[3]_i_1_n_0 ));
  FDCE \clk_count_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\clk_count[0]_i_1_n_0 ),
        .Q(clk_count[0]));
  FDCE \clk_count_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\clk_count[1]_i_1_n_0 ),
        .Q(clk_count[1]));
  FDCE \clk_count_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\clk_count[2]_i_1_n_0 ),
        .Q(clk_count[2]));
  FDCE \clk_count_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\clk_count[3]_i_1_n_0 ),
        .Q(clk_count[3]));
  FDPE clk_inter_reg
       (.C(clk),
        .CE(1'b1),
        .D(ps2_clk_in),
        .PRE(rst),
        .Q(clk_inter));
  LUT5 #(
    .INIT(32'h2020E0FF)) 
    \counter[0]_i_1 
       (.I0(state_next1),
        .I1(\FSM_onehot_state[12]_i_2_n_0 ),
        .I2(\FSM_onehot_state_reg_n_0_[12] ),
        .I3(\counter[13]_i_3_n_0 ),
        .I4(counter[0]),
        .O(\counter[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'h80AA)) 
    \counter[10]_i_1 
       (.I0(data1[10]),
        .I1(\FSM_onehot_state_reg_n_0_[12] ),
        .I2(\FSM_onehot_state[12]_i_2_n_0 ),
        .I3(\counter[13]_i_3_n_0 ),
        .O(\counter[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'h80AA)) 
    \counter[11]_i_1 
       (.I0(data1[11]),
        .I1(\FSM_onehot_state_reg_n_0_[12] ),
        .I2(\FSM_onehot_state[12]_i_2_n_0 ),
        .I3(\counter[13]_i_3_n_0 ),
        .O(\counter[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'h80AA)) 
    \counter[12]_i_1 
       (.I0(data1[12]),
        .I1(\FSM_onehot_state_reg_n_0_[12] ),
        .I2(\FSM_onehot_state[12]_i_2_n_0 ),
        .I3(\counter[13]_i_3_n_0 ),
        .O(\counter[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'h80AA)) 
    \counter[13]_i_1 
       (.I0(data1[13]),
        .I1(\FSM_onehot_state_reg_n_0_[12] ),
        .I2(\FSM_onehot_state[12]_i_2_n_0 ),
        .I3(\counter[13]_i_3_n_0 ),
        .O(\counter[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000733333737)) 
    \counter[13]_i_3 
       (.I0(\counter[13]_i_4_n_0 ),
        .I1(\FSM_onehot_state_reg_n_0_[4] ),
        .I2(\FSM_onehot_state[14]_i_3_n_0 ),
        .I3(\counter[13]_i_5_n_0 ),
        .I4(\FSM_onehot_state[14]_i_4_n_0 ),
        .I5(\FSM_onehot_state_reg_n_0_[3] ),
        .O(\counter[13]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'hEFFF)) 
    \counter[13]_i_4 
       (.I0(counter[13]),
        .I1(counter[12]),
        .I2(counter[7]),
        .I3(counter[6]),
        .O(\counter[13]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'hFFEF)) 
    \counter[13]_i_5 
       (.I0(counter[7]),
        .I1(counter[6]),
        .I2(counter[13]),
        .I3(counter[12]),
        .O(\counter[13]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hF5D500C0)) 
    \counter[1]_i_1 
       (.I0(\counter[13]_i_3_n_0 ),
        .I1(state_next1),
        .I2(\FSM_onehot_state_reg_n_0_[12] ),
        .I3(\FSM_onehot_state[12]_i_2_n_0 ),
        .I4(data1[1]),
        .O(\counter[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF5D500C0)) 
    \counter[2]_i_1 
       (.I0(\counter[13]_i_3_n_0 ),
        .I1(state_next1),
        .I2(\FSM_onehot_state_reg_n_0_[12] ),
        .I3(\FSM_onehot_state[12]_i_2_n_0 ),
        .I4(data1[2]),
        .O(\counter[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF5D500C0)) 
    \counter[3]_i_1 
       (.I0(\counter[13]_i_3_n_0 ),
        .I1(state_next1),
        .I2(\FSM_onehot_state_reg_n_0_[12] ),
        .I3(\FSM_onehot_state[12]_i_2_n_0 ),
        .I4(data1[3]),
        .O(\counter[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF5D500C0)) 
    \counter[4]_i_1 
       (.I0(\counter[13]_i_3_n_0 ),
        .I1(state_next1),
        .I2(\FSM_onehot_state_reg_n_0_[12] ),
        .I3(\FSM_onehot_state[12]_i_2_n_0 ),
        .I4(data1[4]),
        .O(\counter[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA2F2A222)) 
    \counter[5]_i_1 
       (.I0(data1[5]),
        .I1(\counter[13]_i_3_n_0 ),
        .I2(\FSM_onehot_state_reg_n_0_[12] ),
        .I3(\FSM_onehot_state[12]_i_2_n_0 ),
        .I4(state_next1),
        .O(\counter[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'h80AA)) 
    \counter[6]_i_1 
       (.I0(data1[6]),
        .I1(\FSM_onehot_state_reg_n_0_[12] ),
        .I2(\FSM_onehot_state[12]_i_2_n_0 ),
        .I3(\counter[13]_i_3_n_0 ),
        .O(\counter[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'h80AA)) 
    \counter[7]_i_1 
       (.I0(data1[7]),
        .I1(\FSM_onehot_state_reg_n_0_[12] ),
        .I2(\FSM_onehot_state[12]_i_2_n_0 ),
        .I3(\counter[13]_i_3_n_0 ),
        .O(\counter[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'h80AA)) 
    \counter[8]_i_1 
       (.I0(data1[8]),
        .I1(\FSM_onehot_state_reg_n_0_[12] ),
        .I2(\FSM_onehot_state[12]_i_2_n_0 ),
        .I3(\counter[13]_i_3_n_0 ),
        .O(\counter[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'h80AA)) 
    \counter[9]_i_1 
       (.I0(data1[9]),
        .I1(\FSM_onehot_state_reg_n_0_[12] ),
        .I2(\FSM_onehot_state[12]_i_2_n_0 ),
        .I3(\counter[13]_i_3_n_0 ),
        .O(\counter[9]_i_1_n_0 ));
  FDCE \counter_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\counter[0]_i_1_n_0 ),
        .Q(counter[0]));
  FDCE \counter_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\counter[10]_i_1_n_0 ),
        .Q(counter[10]));
  FDCE \counter_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\counter[11]_i_1_n_0 ),
        .Q(counter[11]));
  FDCE \counter_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\counter[12]_i_1_n_0 ),
        .Q(counter[12]));
  CARRY4 \counter_reg[12]_i_2 
       (.CI(\counter_reg[8]_i_2_n_0 ),
        .CO({\counter_reg[12]_i_2_n_0 ,\counter_reg[12]_i_2_n_1 ,\counter_reg[12]_i_2_n_2 ,\counter_reg[12]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data1[12:9]),
        .S(counter[12:9]));
  FDCE \counter_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\counter[13]_i_1_n_0 ),
        .Q(counter[13]));
  CARRY4 \counter_reg[13]_i_2 
       (.CI(\counter_reg[12]_i_2_n_0 ),
        .CO(\NLW_counter_reg[13]_i_2_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_counter_reg[13]_i_2_O_UNCONNECTED [3:1],data1[13]}),
        .S({1'b0,1'b0,1'b0,counter[13]}));
  FDCE \counter_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\counter[1]_i_1_n_0 ),
        .Q(counter[1]));
  FDCE \counter_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\counter[2]_i_1_n_0 ),
        .Q(counter[2]));
  FDCE \counter_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\counter[3]_i_1_n_0 ),
        .Q(counter[3]));
  FDCE \counter_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\counter[4]_i_1_n_0 ),
        .Q(counter[4]));
  CARRY4 \counter_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\counter_reg[4]_i_2_n_0 ,\counter_reg[4]_i_2_n_1 ,\counter_reg[4]_i_2_n_2 ,\counter_reg[4]_i_2_n_3 }),
        .CYINIT(counter[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data1[4:1]),
        .S(counter[4:1]));
  FDCE \counter_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\counter[5]_i_1_n_0 ),
        .Q(counter[5]));
  FDCE \counter_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\counter[6]_i_1_n_0 ),
        .Q(counter[6]));
  FDCE \counter_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\counter[7]_i_1_n_0 ),
        .Q(counter[7]));
  FDCE \counter_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\counter[8]_i_1_n_0 ),
        .Q(counter[8]));
  CARRY4 \counter_reg[8]_i_2 
       (.CI(\counter_reg[4]_i_2_n_0 ),
        .CO({\counter_reg[8]_i_2_n_0 ,\counter_reg[8]_i_2_n_1 ,\counter_reg[8]_i_2_n_2 ,\counter_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data1[8:5]),
        .S(counter[8:5]));
  FDCE \counter_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\counter[9]_i_1_n_0 ),
        .Q(counter[9]));
  LUT6 #(
    .INIT(64'hD55500000000D555)) 
    \data_count[0]_i_1 
       (.I0(data_count[0]),
        .I1(data_count[3]),
        .I2(data_count[2]),
        .I3(data_count[1]),
        .I4(ps2_data_in),
        .I5(data_inter),
        .O(\data_count[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8FF0000000008FF0)) 
    \data_count[1]_i_1 
       (.I0(data_count[3]),
        .I1(data_count[2]),
        .I2(data_count[0]),
        .I3(data_count[1]),
        .I4(ps2_data_in),
        .I5(data_inter),
        .O(\data_count[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hBCCC00000000BCCC)) 
    \data_count[2]_i_1 
       (.I0(data_count[3]),
        .I1(data_count[2]),
        .I2(data_count[0]),
        .I3(data_count[1]),
        .I4(ps2_data_in),
        .I5(data_inter),
        .O(\data_count[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEAAA00000000EAAA)) 
    \data_count[3]_i_1 
       (.I0(data_count[3]),
        .I1(data_count[2]),
        .I2(data_count[0]),
        .I3(data_count[1]),
        .I4(ps2_data_in),
        .I5(data_inter),
        .O(\data_count[3]_i_1_n_0 ));
  FDCE \data_count_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\data_count[0]_i_1_n_0 ),
        .Q(data_count[0]));
  FDCE \data_count_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\data_count[1]_i_1_n_0 ),
        .Q(data_count[1]));
  FDCE \data_count_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\data_count[2]_i_1_n_0 ),
        .Q(data_count[2]));
  FDCE \data_count_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\data_count[3]_i_1_n_0 ),
        .Q(data_count[3]));
  FDPE data_inter_reg
       (.C(clk),
        .CE(1'b1),
        .D(ps2_data_in),
        .PRE(rst),
        .Q(data_inter));
  LUT4 #(
    .INIT(16'h8F88)) 
    err_i_1
       (.I0(\FSM_onehot_state_reg_n_0_[8] ),
        .I1(state_next1),
        .I2(err_i_2_n_0),
        .I3(err_i_3_n_0),
        .O(err_next));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hDFFFFFFF)) 
    err_i_2
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(\bits_count_reg_n_0_[2] ),
        .I2(\bits_count_reg_n_0_[3] ),
        .I3(\bits_count_reg_n_0_[0] ),
        .I4(\bits_count_reg_n_0_[1] ),
        .O(err_i_2_n_0));
  LUT4 #(
    .INIT(16'h9669)) 
    err_i_3
       (.I0(\parity_table_inferred__0/i_/i__n_0 ),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(\frame_reg_n_0_[9] ),
        .O(err_i_3_n_0));
  FDCE err_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(err_next),
        .Q(err_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h2A)) 
    \frame[0]_i_1 
       (.I0(p_0_in[0]),
        .I1(\frame_reg[9]_0 ),
        .I2(\FSM_onehot_state_reg_n_0_[1] ),
        .O(p_1_in[0]));
  LUT4 #(
    .INIT(16'hFEEE)) 
    \frame[10]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[2] ),
        .I1(p_1_in_0),
        .I2(\frame_reg[9]_0 ),
        .I3(\FSM_onehot_state_reg_n_0_[1] ),
        .O(\frame[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hEA)) 
    \frame[10]_i_2 
       (.I0(ps2_data_s__0),
        .I1(\frame_reg[9]_0 ),
        .I2(\FSM_onehot_state_reg_n_0_[1] ),
        .O(p_1_in[10]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'hBF80)) 
    \frame[1]_i_1 
       (.I0(\frame_reg[9]_1 ),
        .I1(\FSM_onehot_state_reg_n_0_[1] ),
        .I2(\frame_reg[9]_0 ),
        .I3(p_0_in[1]),
        .O(p_1_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'hBF80)) 
    \frame[2]_i_1 
       (.I0(\frame_reg[9]_1 ),
        .I1(\FSM_onehot_state_reg_n_0_[1] ),
        .I2(\frame_reg[9]_0 ),
        .I3(p_0_in[2]),
        .O(p_1_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'hBF80)) 
    \frame[3]_i_1 
       (.I0(\frame_reg[9]_1 ),
        .I1(\FSM_onehot_state_reg_n_0_[1] ),
        .I2(\frame_reg[9]_0 ),
        .I3(p_0_in[3]),
        .O(p_1_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hBF80)) 
    \frame[4]_i_1 
       (.I0(\frame_reg[9]_2 ),
        .I1(\FSM_onehot_state_reg_n_0_[1] ),
        .I2(\frame_reg[9]_0 ),
        .I3(p_0_in[4]),
        .O(p_1_in[4]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'hBF80)) 
    \frame[5]_i_1 
       (.I0(\frame_reg[9]_2 ),
        .I1(\FSM_onehot_state_reg_n_0_[1] ),
        .I2(\frame_reg[9]_0 ),
        .I3(p_0_in[5]),
        .O(p_1_in[5]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'hBF80)) 
    \frame[6]_i_1 
       (.I0(\frame_reg[9]_2 ),
        .I1(\FSM_onehot_state_reg_n_0_[1] ),
        .I2(\frame_reg[9]_0 ),
        .I3(p_0_in[6]),
        .O(p_1_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'hBF80)) 
    \frame[7]_i_1 
       (.I0(\frame_reg[9]_2 ),
        .I1(\FSM_onehot_state_reg_n_0_[1] ),
        .I2(\frame_reg[9]_0 ),
        .I3(p_0_in[7]),
        .O(p_1_in[7]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hBF80)) 
    \frame[8]_i_1 
       (.I0(\frame_reg[9]_2 ),
        .I1(\FSM_onehot_state_reg_n_0_[1] ),
        .I2(\frame_reg[9]_0 ),
        .I3(\frame_reg_n_0_[9] ),
        .O(p_1_in[8]));
  LUT5 #(
    .INIT(32'h9FFF9000)) 
    \frame[9]_i_1 
       (.I0(\frame_reg[9]_1 ),
        .I1(\frame_reg[9]_2 ),
        .I2(\FSM_onehot_state_reg_n_0_[1] ),
        .I3(\frame_reg[9]_0 ),
        .I4(\frame_reg_n_0_[10] ),
        .O(p_1_in[9]));
  FDCE \frame_reg[0] 
       (.C(clk),
        .CE(\frame[10]_i_1_n_0 ),
        .CLR(rst),
        .D(p_1_in[0]),
        .Q(\frame_reg_n_0_[0] ));
  FDCE \frame_reg[10] 
       (.C(clk),
        .CE(\frame[10]_i_1_n_0 ),
        .CLR(rst),
        .D(p_1_in[10]),
        .Q(\frame_reg_n_0_[10] ));
  FDCE \frame_reg[1] 
       (.C(clk),
        .CE(\frame[10]_i_1_n_0 ),
        .CLR(rst),
        .D(p_1_in[1]),
        .Q(p_0_in[0]));
  FDCE \frame_reg[2] 
       (.C(clk),
        .CE(\frame[10]_i_1_n_0 ),
        .CLR(rst),
        .D(p_1_in[2]),
        .Q(p_0_in[1]));
  FDCE \frame_reg[3] 
       (.C(clk),
        .CE(\frame[10]_i_1_n_0 ),
        .CLR(rst),
        .D(p_1_in[3]),
        .Q(p_0_in[2]));
  FDCE \frame_reg[4] 
       (.C(clk),
        .CE(\frame[10]_i_1_n_0 ),
        .CLR(rst),
        .D(p_1_in[4]),
        .Q(p_0_in[3]));
  FDCE \frame_reg[5] 
       (.C(clk),
        .CE(\frame[10]_i_1_n_0 ),
        .CLR(rst),
        .D(p_1_in[5]),
        .Q(p_0_in[4]));
  FDCE \frame_reg[6] 
       (.C(clk),
        .CE(\frame[10]_i_1_n_0 ),
        .CLR(rst),
        .D(p_1_in[6]),
        .Q(p_0_in[5]));
  FDCE \frame_reg[7] 
       (.C(clk),
        .CE(\frame[10]_i_1_n_0 ),
        .CLR(rst),
        .D(p_1_in[7]),
        .Q(p_0_in[6]));
  FDCE \frame_reg[8] 
       (.C(clk),
        .CE(\frame[10]_i_1_n_0 ),
        .CLR(rst),
        .D(p_1_in[8]),
        .Q(p_0_in[7]));
  FDCE \frame_reg[9] 
       (.C(clk),
        .CE(\frame[10]_i_1_n_0 ),
        .CLR(rst),
        .D(p_1_in[9]),
        .Q(\frame_reg_n_0_[9] ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h0091)) 
    is_break_i_1
       (.I0(Q[2]),
        .I1(Q[1]),
        .I2(rx_valid),
        .I3(Q[0]),
        .O(\FSM_sequential_state_reg[2] ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'hF0800080)) 
    is_extend_i_1
       (.I0(Q[0]),
        .I1(rx_valid),
        .I2(Q[2]),
        .I3(Q[1]),
        .I4(is_extend),
        .O(\FSM_sequential_state_reg[0] ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \parity_table_inferred__0/i_/i_ 
       (.I0(p_0_in[3]),
        .I1(p_0_in[2]),
        .I2(p_0_in[6]),
        .I3(p_0_in[7]),
        .I4(p_0_in[4]),
        .I5(p_0_in[5]),
        .O(\parity_table_inferred__0/i_/i__n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    ps2_clk_en_inv_i_1
       (.I0(\FSM_onehot_state_reg_n_0_[4] ),
        .I1(\FSM_onehot_state_reg_n_0_[3] ),
        .O(ps2_clk_en_next));
  FDPE ps2_clk_en_reg_inv
       (.C(clk),
        .CE(1'b1),
        .D(ps2_clk_en_next),
        .PRE(rst),
        .Q(T0));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    ps2_clk_out_i_1
       (.I0(ps2_clk_out_i_2_n_0),
        .I1(\FSM_onehot_state_reg_n_0_[13] ),
        .I2(\FSM_onehot_state_reg_n_0_[9] ),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(ps2_clk_out_i_3_n_0),
        .O(ps2_clk_out_next));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    ps2_clk_out_i_2
       (.I0(\FSM_onehot_state_reg_n_0_[5] ),
        .I1(\FSM_onehot_state_reg_n_0_[8] ),
        .I2(\FSM_onehot_state_reg_n_0_[6] ),
        .I3(\FSM_onehot_state_reg_n_0_[7] ),
        .I4(\FSM_onehot_state_reg_n_0_[1] ),
        .I5(\FSM_onehot_state_reg_n_0_[0] ),
        .O(ps2_clk_out_i_2_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    ps2_clk_out_i_3
       (.I0(\FSM_onehot_state_reg_n_0_[10] ),
        .I1(p_1_in_0),
        .I2(\FSM_onehot_state_reg_n_0_[14] ),
        .I3(\FSM_onehot_state_reg_n_0_[12] ),
        .O(ps2_clk_out_i_3_n_0));
  FDCE ps2_clk_out_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ps2_clk_out_next),
        .Q(ps2_clk_out));
  LUT2 #(
    .INIT(4'h7)) 
    ps2_clk_s
       (.I0(clk_count[0]),
        .I1(clk_count[1]),
        .O(ps2_clk_s_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFF708000000)) 
    ps2_clk_s_i_1
       (.I0(clk_count[3]),
        .I1(clk_count[2]),
        .I2(ps2_clk_s_n_0),
        .I3(ps2_clk_in),
        .I4(clk_inter),
        .I5(state_next1),
        .O(ps2_clk_s_i_1_n_0));
  FDPE ps2_clk_s_reg
       (.C(clk),
        .CE(1'b1),
        .D(ps2_clk_s_i_1_n_0),
        .PRE(rst),
        .Q(state_next1));
  LUT6 #(
    .INIT(64'h0000000000000002)) 
    ps2_data_en_inv_i_1
       (.I0(\FSM_onehot_state[13]_i_2_n_0 ),
        .I1(\FSM_onehot_state_reg_n_0_[10] ),
        .I2(p_1_in_0),
        .I3(\FSM_onehot_state_reg_n_0_[14] ),
        .I4(\FSM_onehot_state_reg_n_0_[12] ),
        .I5(\FSM_onehot_state_reg_n_0_[4] ),
        .O(ps2_data_en_next));
  FDPE ps2_data_en_reg_inv
       (.C(clk),
        .CE(1'b1),
        .D(ps2_data_en_next),
        .PRE(rst),
        .Q(ps2_data_en_reg_inv_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    ps2_data_out_i_1
       (.I0(ps2_data_out_i_2_n_0),
        .I1(ps2_clk_out_i_2_n_0),
        .I2(\FSM_onehot_state_reg_n_0_[3] ),
        .I3(\FSM_onehot_state_reg_n_0_[9] ),
        .I4(\FSM_onehot_state_reg_n_0_[2] ),
        .O(ps2_data_out_next));
  LUT4 #(
    .INIT(16'hAAA8)) 
    ps2_data_out_i_2
       (.I0(\frame_reg_n_0_[0] ),
        .I1(p_1_in_0),
        .I2(\FSM_onehot_state_reg_n_0_[10] ),
        .I3(\FSM_onehot_state_reg_n_0_[13] ),
        .O(ps2_data_out_i_2_n_0));
  FDCE ps2_data_out_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ps2_data_out_next),
        .Q(ps2_data_out));
  LUT2 #(
    .INIT(4'h7)) 
    ps2_data_s
       (.I0(data_count[0]),
        .I1(data_count[1]),
        .O(ps2_data_s_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFF708000000)) 
    ps2_data_s_i_1
       (.I0(data_count[3]),
        .I1(data_count[2]),
        .I2(ps2_data_s_n_0),
        .I3(ps2_data_in),
        .I4(data_inter),
        .I5(ps2_data_s__0),
        .O(ps2_data_s_i_1_n_0));
  FDPE ps2_data_s_reg
       (.C(clk),
        .CE(1'b1),
        .D(ps2_data_s_i_1_n_0),
        .PRE(rst),
        .Q(ps2_data_s__0));
  LUT5 #(
    .INIT(32'h00006996)) 
    \rx_data[7]_i_1 
       (.I0(\frame_reg_n_0_[9] ),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(\parity_table_inferred__0/i_/i__n_0 ),
        .I4(err_i_2_n_0),
        .O(rx_finish));
  FDCE \rx_data_reg[0] 
       (.C(clk),
        .CE(rx_finish),
        .CLR(rst),
        .D(p_0_in[0]),
        .Q(\rx_data_reg[7]_0 [0]));
  FDCE \rx_data_reg[1] 
       (.C(clk),
        .CE(rx_finish),
        .CLR(rst),
        .D(p_0_in[1]),
        .Q(\rx_data_reg[7]_0 [1]));
  FDCE \rx_data_reg[2] 
       (.C(clk),
        .CE(rx_finish),
        .CLR(rst),
        .D(p_0_in[2]),
        .Q(\rx_data_reg[7]_0 [2]));
  FDCE \rx_data_reg[3] 
       (.C(clk),
        .CE(rx_finish),
        .CLR(rst),
        .D(p_0_in[3]),
        .Q(\rx_data_reg[7]_0 [3]));
  FDCE \rx_data_reg[4] 
       (.C(clk),
        .CE(rx_finish),
        .CLR(rst),
        .D(p_0_in[4]),
        .Q(\rx_data_reg[7]_0 [4]));
  FDCE \rx_data_reg[5] 
       (.C(clk),
        .CE(rx_finish),
        .CLR(rst),
        .D(p_0_in[5]),
        .Q(\rx_data_reg[7]_0 [5]));
  FDCE \rx_data_reg[6] 
       (.C(clk),
        .CE(rx_finish),
        .CLR(rst),
        .D(p_0_in[6]),
        .Q(\rx_data_reg[7]_0 [6]));
  FDCE \rx_data_reg[7] 
       (.C(clk),
        .CE(rx_finish),
        .CLR(rst),
        .D(p_0_in[7]),
        .Q(\rx_data_reg[7]_0 [7]));
  FDCE rx_valid_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(rx_finish),
        .Q(rx_valid));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h1000)) 
    tx_valid_i_1
       (.I0(Q[1]),
        .I1(Q[2]),
        .I2(Q[0]),
        .I3(\FSM_onehot_state_reg_n_0_[1] ),
        .O(tx_valid));
  LUT6 #(
    .INIT(64'h3F34000000000000)) 
    valid_i_1
       (.I0(\rx_data_reg[7]_0 [4]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(valid_i_2_n_0),
        .I4(Q[2]),
        .I5(rx_valid),
        .O(\rx_data_reg[4]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'hFDFF)) 
    valid_i_2
       (.I0(valid_i_3_n_0),
        .I1(\rx_data_reg[7]_0 [1]),
        .I2(\rx_data_reg[7]_0 [3]),
        .I3(rx_valid),
        .O(valid_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h02000000)) 
    valid_i_3
       (.I0(\rx_data_reg[7]_0 [6]),
        .I1(\rx_data_reg[7]_0 [2]),
        .I2(\rx_data_reg[7]_0 [0]),
        .I3(\rx_data_reg[7]_0 [7]),
        .I4(\rx_data_reg[7]_0 [5]),
        .O(valid_i_3_n_0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
