-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Wed Jan  8 20:47:39 2020
-- Host        : DESKTOP-FUIN3UU running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/leihsiung/Desktop/Lab/dinosaur/dinosaur.srcs/sources_1/ip/KeyboardCtrl_0/KeyboardCtrl_0_sim_netlist.vhdl
-- Design      : KeyboardCtrl_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity KeyboardCtrl_0_Ps2Interface is
  port (
    rx_valid : out STD_LOGIC;
    err_reg_0 : out STD_LOGIC;
    \FSM_sequential_state_reg[0]\ : out STD_LOGIC;
    \rx_data_reg[7]_0\ : out STD_LOGIC_VECTOR ( 7 downto 0 );
    \FSM_sequential_state_reg[2]\ : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 2 downto 0 );
    tx_valid : out STD_LOGIC;
    \rx_data_reg[4]_0\ : out STD_LOGIC;
    PS2_CLK : inout STD_LOGIC;
    PS2_DATA : inout STD_LOGIC;
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    \frame_reg[9]_0\ : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 2 downto 0 );
    is_extend : in STD_LOGIC;
    \frame_reg[9]_1\ : in STD_LOGIC;
    \frame_reg[9]_2\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of KeyboardCtrl_0_Ps2Interface : entity is "Ps2Interface";
end KeyboardCtrl_0_Ps2Interface;

architecture STRUCTURE of KeyboardCtrl_0_Ps2Interface is
  signal \FSM_onehot_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[0]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[10]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[11]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[12]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[12]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[12]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[12]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[13]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[13]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[14]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[14]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[14]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[14]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[2]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[3]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[5]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[6]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[7]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[8]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[9]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[9]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[0]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[10]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[12]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[13]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[14]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[1]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[2]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[3]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[4]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[5]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[6]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[7]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[8]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[9]\ : STD_LOGIC;
  signal \FSM_sequential_state[0]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[0]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_5_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[2]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[2]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[2]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[2]_i_5_n_0\ : STD_LOGIC;
  signal T0 : STD_LOGIC;
  signal bits_count : STD_LOGIC;
  signal \bits_count[0]_i_1_n_0\ : STD_LOGIC;
  signal \bits_count[1]_i_1_n_0\ : STD_LOGIC;
  signal \bits_count[2]_i_1_n_0\ : STD_LOGIC;
  signal \bits_count[3]_i_2_n_0\ : STD_LOGIC;
  signal \bits_count_reg_n_0_[0]\ : STD_LOGIC;
  signal \bits_count_reg_n_0_[1]\ : STD_LOGIC;
  signal \bits_count_reg_n_0_[2]\ : STD_LOGIC;
  signal \bits_count_reg_n_0_[3]\ : STD_LOGIC;
  signal clk_count : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \clk_count[0]_i_1_n_0\ : STD_LOGIC;
  signal \clk_count[1]_i_1_n_0\ : STD_LOGIC;
  signal \clk_count[2]_i_1_n_0\ : STD_LOGIC;
  signal \clk_count[3]_i_1_n_0\ : STD_LOGIC;
  signal clk_inter : STD_LOGIC;
  signal counter : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal \counter[0]_i_1_n_0\ : STD_LOGIC;
  signal \counter[10]_i_1_n_0\ : STD_LOGIC;
  signal \counter[11]_i_1_n_0\ : STD_LOGIC;
  signal \counter[12]_i_1_n_0\ : STD_LOGIC;
  signal \counter[13]_i_1_n_0\ : STD_LOGIC;
  signal \counter[13]_i_3_n_0\ : STD_LOGIC;
  signal \counter[13]_i_4_n_0\ : STD_LOGIC;
  signal \counter[13]_i_5_n_0\ : STD_LOGIC;
  signal \counter[1]_i_1_n_0\ : STD_LOGIC;
  signal \counter[2]_i_1_n_0\ : STD_LOGIC;
  signal \counter[3]_i_1_n_0\ : STD_LOGIC;
  signal \counter[4]_i_1_n_0\ : STD_LOGIC;
  signal \counter[5]_i_1_n_0\ : STD_LOGIC;
  signal \counter[6]_i_1_n_0\ : STD_LOGIC;
  signal \counter[7]_i_1_n_0\ : STD_LOGIC;
  signal \counter[8]_i_1_n_0\ : STD_LOGIC;
  signal \counter[9]_i_1_n_0\ : STD_LOGIC;
  signal \counter_reg[12]_i_2_n_0\ : STD_LOGIC;
  signal \counter_reg[12]_i_2_n_1\ : STD_LOGIC;
  signal \counter_reg[12]_i_2_n_2\ : STD_LOGIC;
  signal \counter_reg[12]_i_2_n_3\ : STD_LOGIC;
  signal \counter_reg[4]_i_2_n_0\ : STD_LOGIC;
  signal \counter_reg[4]_i_2_n_1\ : STD_LOGIC;
  signal \counter_reg[4]_i_2_n_2\ : STD_LOGIC;
  signal \counter_reg[4]_i_2_n_3\ : STD_LOGIC;
  signal \counter_reg[8]_i_2_n_0\ : STD_LOGIC;
  signal \counter_reg[8]_i_2_n_1\ : STD_LOGIC;
  signal \counter_reg[8]_i_2_n_2\ : STD_LOGIC;
  signal \counter_reg[8]_i_2_n_3\ : STD_LOGIC;
  signal data1 : STD_LOGIC_VECTOR ( 13 downto 1 );
  signal data_count : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \data_count[0]_i_1_n_0\ : STD_LOGIC;
  signal \data_count[1]_i_1_n_0\ : STD_LOGIC;
  signal \data_count[2]_i_1_n_0\ : STD_LOGIC;
  signal \data_count[3]_i_1_n_0\ : STD_LOGIC;
  signal data_inter : STD_LOGIC;
  signal err_i_2_n_0 : STD_LOGIC;
  signal err_i_3_n_0 : STD_LOGIC;
  signal err_next : STD_LOGIC;
  signal \^err_reg_0\ : STD_LOGIC;
  signal \frame[10]_i_1_n_0\ : STD_LOGIC;
  signal \frame_reg_n_0_[0]\ : STD_LOGIC;
  signal \frame_reg_n_0_[10]\ : STD_LOGIC;
  signal \frame_reg_n_0_[9]\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal p_1_in : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal p_1_in_0 : STD_LOGIC;
  signal \parity_table_inferred__0/i_/i__n_0\ : STD_LOGIC;
  signal ps2_clk_en_next : STD_LOGIC;
  signal ps2_clk_in : STD_LOGIC;
  signal ps2_clk_out : STD_LOGIC;
  signal ps2_clk_out_i_2_n_0 : STD_LOGIC;
  signal ps2_clk_out_i_3_n_0 : STD_LOGIC;
  signal ps2_clk_out_next : STD_LOGIC;
  signal ps2_clk_s_i_1_n_0 : STD_LOGIC;
  signal ps2_clk_s_n_0 : STD_LOGIC;
  signal ps2_data_en_next : STD_LOGIC;
  signal ps2_data_en_reg_inv_n_0 : STD_LOGIC;
  signal ps2_data_in : STD_LOGIC;
  signal ps2_data_out : STD_LOGIC;
  signal ps2_data_out_i_2_n_0 : STD_LOGIC;
  signal ps2_data_out_next : STD_LOGIC;
  signal \ps2_data_s__0\ : STD_LOGIC;
  signal ps2_data_s_i_1_n_0 : STD_LOGIC;
  signal ps2_data_s_n_0 : STD_LOGIC;
  signal \^rx_data_reg[7]_0\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal rx_finish : STD_LOGIC;
  signal \^rx_valid\ : STD_LOGIC;
  signal state_next1 : STD_LOGIC;
  signal \^tx_valid\ : STD_LOGIC;
  signal valid_i_2_n_0 : STD_LOGIC;
  signal valid_i_3_n_0 : STD_LOGIC;
  signal \NLW_counter_reg[13]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_counter_reg[13]_i_2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_onehot_state[0]_i_2\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \FSM_onehot_state[10]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \FSM_onehot_state[11]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \FSM_onehot_state[12]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \FSM_onehot_state[13]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \FSM_onehot_state[13]_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \FSM_onehot_state[14]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \FSM_onehot_state[2]_i_2\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \FSM_onehot_state[4]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \FSM_onehot_state[5]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \FSM_onehot_state[7]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \FSM_onehot_state[8]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \FSM_onehot_state[9]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \FSM_onehot_state[9]_i_2\ : label is "soft_lutpair0";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[0]\ : label is "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[10]\ : label is "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[11]\ : label is "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[12]\ : label is "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[13]\ : label is "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[14]\ : label is "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[1]\ : label is "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[2]\ : label is "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[3]\ : label is "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[4]\ : label is "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[5]\ : label is "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[6]\ : label is "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[7]\ : label is "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[8]\ : label is "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[9]\ : label is "TX_FORCE_CLK_LOW:000000000001000,RX_CLK_HIGH:000000000000001,RX_CLK_LOW:000000001000000,TX_RECEIVED_ACK:000000000100000,TX_WAIT_ACK:000000010000000,TX_WAIT_POS_EDGE_BEFORE_ACK:000001000000000,TX_CLK_HIGH:000010000000000,RX_NEG_EDGE:000000000000100,IDLE:000000000000010,TX_WAIT_POS_EDGE:010000000000000,TX_WAIT_FIRTS_NEG_EDGE:001000000000000,TX_RELEASE_CLK:100000000000000,TX_CLK_LOW:000100000000000,TX_ERROR_NO_ACK:000000100000000,TX_BRING_DATA_LOW:000000000010000";
  attribute SOFT_HLUTNM of \FSM_sequential_state[1]_i_5\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \FSM_sequential_state[2]_i_5\ : label is "soft_lutpair3";
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of IOBUF_inst_0 : label is "PRIMITIVE";
  attribute BOX_TYPE of IOBUF_inst_1 : label is "PRIMITIVE";
  attribute SOFT_HLUTNM of \bits_count[0]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \bits_count[1]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \bits_count[2]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \bits_count[3]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \counter[10]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \counter[11]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \counter[12]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \counter[13]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \counter[13]_i_4\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \counter[13]_i_5\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \counter[6]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \counter[7]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \counter[8]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \counter[9]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of err_i_2 : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \frame[0]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \frame[10]_i_2\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \frame[1]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \frame[2]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \frame[3]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \frame[4]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \frame[5]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \frame[6]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \frame[7]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \frame[8]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of is_break_i_1 : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of is_extend_i_1 : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of tx_valid_i_1 : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of valid_i_2 : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of valid_i_3 : label is "soft_lutpair3";
begin
  err_reg_0 <= \^err_reg_0\;
  \rx_data_reg[7]_0\(7 downto 0) <= \^rx_data_reg[7]_0\(7 downto 0);
  rx_valid <= \^rx_valid\;
  tx_valid <= \^tx_valid\;
\FSM_onehot_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAA80888888"
    )
        port map (
      I0 => state_next1,
      I1 => \FSM_onehot_state_reg_n_0_[0]\,
      I2 => \bits_count_reg_n_0_[2]\,
      I3 => \bits_count_reg_n_0_[3]\,
      I4 => \FSM_onehot_state[0]_i_2_n_0\,
      I5 => \FSM_onehot_state_reg_n_0_[6]\,
      O => \FSM_onehot_state[0]_i_1_n_0\
    );
\FSM_onehot_state[0]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \bits_count_reg_n_0_[0]\,
      I1 => \bits_count_reg_n_0_[1]\,
      O => \FSM_onehot_state[0]_i_2_n_0\
    );
\FSM_onehot_state[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => state_next1,
      I1 => \FSM_onehot_state_reg_n_0_[10]\,
      I2 => \FSM_onehot_state[13]_i_2_n_0\,
      O => \FSM_onehot_state[10]_i_1_n_0\
    );
\FSM_onehot_state[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2322"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[10]\,
      I1 => state_next1,
      I2 => \FSM_onehot_state[12]_i_2_n_0\,
      I3 => \FSM_onehot_state_reg_n_0_[12]\,
      O => \FSM_onehot_state[11]_i_1_n_0\
    );
\FSM_onehot_state[12]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FEAA"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[14]\,
      I1 => state_next1,
      I2 => \FSM_onehot_state[12]_i_2_n_0\,
      I3 => \FSM_onehot_state_reg_n_0_[12]\,
      O => \FSM_onehot_state[12]_i_1_n_0\
    );
\FSM_onehot_state[12]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFBFFFFFFFFF"
    )
        port map (
      I0 => \FSM_onehot_state[12]_i_3_n_0\,
      I1 => counter(2),
      I2 => counter(1),
      I3 => counter(8),
      I4 => counter(11),
      I5 => \FSM_onehot_state[12]_i_4_n_0\,
      O => \FSM_onehot_state[12]_i_2_n_0\
    );
\FSM_onehot_state[12]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DFFF"
    )
        port map (
      I0 => counter(0),
      I1 => counter(10),
      I2 => counter(5),
      I3 => counter(3),
      O => \FSM_onehot_state[12]_i_3_n_0\
    );
\FSM_onehot_state[12]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000100"
    )
        port map (
      I0 => counter(7),
      I1 => counter(6),
      I2 => counter(9),
      I3 => counter(4),
      I4 => counter(12),
      I5 => counter(13),
      O => \FSM_onehot_state[12]_i_4_n_0\
    );
\FSM_onehot_state[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AB"
    )
        port map (
      I0 => p_1_in_0,
      I1 => \FSM_onehot_state[13]_i_2_n_0\,
      I2 => state_next1,
      O => \FSM_onehot_state[13]_i_1_n_0\
    );
\FSM_onehot_state[13]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0400FFFF"
    )
        port map (
      I0 => \bits_count_reg_n_0_[0]\,
      I1 => \bits_count_reg_n_0_[1]\,
      I2 => \bits_count_reg_n_0_[2]\,
      I3 => \bits_count_reg_n_0_[3]\,
      I4 => \FSM_onehot_state_reg_n_0_[13]\,
      O => \FSM_onehot_state[13]_i_2_n_0\
    );
\FSM_onehot_state[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[4]\,
      I1 => \FSM_onehot_state[14]_i_2_n_0\,
      O => \FSM_onehot_state[14]_i_1_n_0\
    );
\FSM_onehot_state[14]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFEFFFFFF"
    )
        port map (
      I0 => \FSM_onehot_state[14]_i_3_n_0\,
      I1 => counter(13),
      I2 => counter(12),
      I3 => counter(7),
      I4 => counter(6),
      I5 => \FSM_onehot_state[14]_i_4_n_0\,
      O => \FSM_onehot_state[14]_i_2_n_0\
    );
\FSM_onehot_state[14]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => counter(1),
      I1 => counter(2),
      I2 => counter(3),
      I3 => counter(11),
      I4 => counter(0),
      I5 => counter(5),
      O => \FSM_onehot_state[14]_i_3_n_0\
    );
\FSM_onehot_state[14]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => counter(9),
      I1 => counter(4),
      I2 => counter(8),
      I3 => counter(10),
      O => \FSM_onehot_state[14]_i_4_n_0\
    );
\FSM_onehot_state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DDD5DDDDDDD5DDD5"
    )
        port map (
      I0 => err_i_2_n_0,
      I1 => state_next1,
      I2 => \FSM_onehot_state_reg_n_0_[5]\,
      I3 => \FSM_onehot_state_reg_n_0_[8]\,
      I4 => \frame_reg[9]_0\,
      I5 => \FSM_onehot_state_reg_n_0_[1]\,
      O => \FSM_onehot_state[1]_i_1_n_0\
    );
\FSM_onehot_state[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5504"
    )
        port map (
      I0 => state_next1,
      I1 => \FSM_onehot_state_reg_n_0_[1]\,
      I2 => \frame_reg[9]_0\,
      I3 => \FSM_onehot_state[2]_i_2_n_0\,
      O => \FSM_onehot_state[2]_i_1_n_0\
    );
\FSM_onehot_state[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8AAAAAAA"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => \bits_count_reg_n_0_[2]\,
      I2 => \bits_count_reg_n_0_[3]\,
      I3 => \bits_count_reg_n_0_[0]\,
      I4 => \bits_count_reg_n_0_[1]\,
      O => \FSM_onehot_state[2]_i_2_n_0\
    );
\FSM_onehot_state[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \frame_reg[9]_0\,
      I1 => \FSM_onehot_state_reg_n_0_[1]\,
      I2 => \FSM_onehot_state[4]_i_2_n_0\,
      I3 => \FSM_onehot_state_reg_n_0_[3]\,
      O => \FSM_onehot_state[3]_i_1_n_0\
    );
\FSM_onehot_state[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8F88"
    )
        port map (
      I0 => \FSM_onehot_state[14]_i_2_n_0\,
      I1 => \FSM_onehot_state_reg_n_0_[4]\,
      I2 => \FSM_onehot_state[4]_i_2_n_0\,
      I3 => \FSM_onehot_state_reg_n_0_[3]\,
      O => \FSM_onehot_state[4]_i_1_n_0\
    );
\FSM_onehot_state[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFEFF"
    )
        port map (
      I0 => \FSM_onehot_state[14]_i_3_n_0\,
      I1 => counter(7),
      I2 => counter(6),
      I3 => counter(13),
      I4 => counter(12),
      I5 => \FSM_onehot_state[14]_i_4_n_0\,
      O => \FSM_onehot_state[4]_i_2_n_0\
    );
\FSM_onehot_state[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4544"
    )
        port map (
      I0 => state_next1,
      I1 => \FSM_onehot_state_reg_n_0_[5]\,
      I2 => \ps2_data_s__0\,
      I3 => \FSM_onehot_state_reg_n_0_[7]\,
      O => \FSM_onehot_state[5]_i_1_n_0\
    );
\FSM_onehot_state[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[2]\,
      I1 => state_next1,
      I2 => \FSM_onehot_state_reg_n_0_[6]\,
      O => \FSM_onehot_state[6]_i_1_n_0\
    );
\FSM_onehot_state[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A8"
    )
        port map (
      I0 => state_next1,
      I1 => \FSM_onehot_state_reg_n_0_[9]\,
      I2 => \FSM_onehot_state_reg_n_0_[7]\,
      O => \FSM_onehot_state[7]_i_1_n_0\
    );
\FSM_onehot_state[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5444"
    )
        port map (
      I0 => state_next1,
      I1 => \FSM_onehot_state_reg_n_0_[8]\,
      I2 => \FSM_onehot_state_reg_n_0_[7]\,
      I3 => \ps2_data_s__0\,
      O => \FSM_onehot_state[8]_i_1_n_0\
    );
\FSM_onehot_state[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8F88"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[13]\,
      I1 => \FSM_onehot_state[9]_i_2_n_0\,
      I2 => state_next1,
      I3 => \FSM_onehot_state_reg_n_0_[9]\,
      O => \FSM_onehot_state[9]_i_1_n_0\
    );
\FSM_onehot_state[9]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0020"
    )
        port map (
      I0 => \bits_count_reg_n_0_[3]\,
      I1 => \bits_count_reg_n_0_[2]\,
      I2 => \bits_count_reg_n_0_[1]\,
      I3 => \bits_count_reg_n_0_[0]\,
      O => \FSM_onehot_state[9]_i_2_n_0\
    );
\FSM_onehot_state_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \FSM_onehot_state[0]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[0]\
    );
\FSM_onehot_state_reg[10]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \FSM_onehot_state[10]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[10]\
    );
\FSM_onehot_state_reg[11]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \FSM_onehot_state[11]_i_1_n_0\,
      Q => p_1_in_0
    );
\FSM_onehot_state_reg[12]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \FSM_onehot_state[12]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[12]\
    );
\FSM_onehot_state_reg[13]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \FSM_onehot_state[13]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[13]\
    );
\FSM_onehot_state_reg[14]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \FSM_onehot_state[14]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[14]\
    );
\FSM_onehot_state_reg[1]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => '1',
      D => \FSM_onehot_state[1]_i_1_n_0\,
      PRE => rst,
      Q => \FSM_onehot_state_reg_n_0_[1]\
    );
\FSM_onehot_state_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \FSM_onehot_state[2]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[2]\
    );
\FSM_onehot_state_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \FSM_onehot_state[3]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[3]\
    );
\FSM_onehot_state_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \FSM_onehot_state[4]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[4]\
    );
\FSM_onehot_state_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \FSM_onehot_state[5]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[5]\
    );
\FSM_onehot_state_reg[6]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \FSM_onehot_state[6]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[6]\
    );
\FSM_onehot_state_reg[7]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \FSM_onehot_state[7]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[7]\
    );
\FSM_onehot_state_reg[8]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \FSM_onehot_state[8]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[8]\
    );
\FSM_onehot_state_reg[9]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \FSM_onehot_state[9]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[9]\
    );
\FSM_sequential_state[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF0155"
    )
        port map (
      I0 => \FSM_sequential_state[0]_i_2_n_0\,
      I1 => valid_i_2_n_0,
      I2 => \^rx_data_reg[7]_0\(4),
      I3 => Q(2),
      I4 => \FSM_sequential_state[0]_i_3_n_0\,
      O => D(0)
    );
\FSM_sequential_state[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEFFFAAAAAAAA"
    )
        port map (
      I0 => Q(0),
      I1 => \FSM_sequential_state[1]_i_4_n_0\,
      I2 => valid_i_3_n_0,
      I3 => \^rx_valid\,
      I4 => Q(2),
      I5 => Q(1),
      O => \FSM_sequential_state[0]_i_2_n_0\
    );
\FSM_sequential_state[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000202020200FF"
    )
        port map (
      I0 => Q(0),
      I1 => \^err_reg_0\,
      I2 => \^rx_valid\,
      I3 => \FSM_onehot_state_reg_n_0_[1]\,
      I4 => Q(2),
      I5 => Q(1),
      O => \FSM_sequential_state[0]_i_3_n_0\
    );
\FSM_sequential_state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF1F000000"
    )
        port map (
      I0 => Q(2),
      I1 => \FSM_sequential_state[2]_i_4_n_0\,
      I2 => Q(0),
      I3 => Q(1),
      I4 => \FSM_sequential_state[1]_i_2_n_0\,
      I5 => \FSM_sequential_state[1]_i_3_n_0\,
      O => D(1)
    );
\FSM_sequential_state[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1111111D11111111"
    )
        port map (
      I0 => \^err_reg_0\,
      I1 => \^rx_valid\,
      I2 => Q(0),
      I3 => Q(2),
      I4 => \FSM_sequential_state[1]_i_4_n_0\,
      I5 => valid_i_3_n_0,
      O => \FSM_sequential_state[1]_i_2_n_0\
    );
\FSM_sequential_state[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEAAAAAAAAAAAAAA"
    )
        port map (
      I0 => \^tx_valid\,
      I1 => Q(2),
      I2 => Q(1),
      I3 => \^rx_data_reg[7]_0\(4),
      I4 => \FSM_sequential_state[1]_i_5_n_0\,
      I5 => valid_i_3_n_0,
      O => \FSM_sequential_state[1]_i_3_n_0\
    );
\FSM_sequential_state[1]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFFFFF"
    )
        port map (
      I0 => \^rx_data_reg[7]_0\(3),
      I1 => \frame_reg[9]_2\,
      I2 => \frame_reg[9]_1\,
      I3 => \^rx_data_reg[7]_0\(1),
      I4 => \^rx_data_reg[7]_0\(4),
      O => \FSM_sequential_state[1]_i_4_n_0\
    );
\FSM_sequential_state[1]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => \^rx_valid\,
      I1 => \^rx_data_reg[7]_0\(3),
      I2 => \^rx_data_reg[7]_0\(1),
      O => \FSM_sequential_state[1]_i_5_n_0\
    );
\FSM_sequential_state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5F51515151515151"
    )
        port map (
      I0 => \FSM_sequential_state[2]_i_2_n_0\,
      I1 => \FSM_sequential_state[2]_i_3_n_0\,
      I2 => Q(2),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \FSM_sequential_state[2]_i_4_n_0\,
      O => D(2)
    );
\FSM_sequential_state[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F444FF5F"
    )
        port map (
      I0 => \^rx_valid\,
      I1 => \^err_reg_0\,
      I2 => Q(1),
      I3 => Q(0),
      I4 => Q(2),
      O => \FSM_sequential_state[2]_i_2_n_0\
    );
\FSM_sequential_state[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => valid_i_3_n_0,
      I1 => \^rx_data_reg[7]_0\(4),
      I2 => \^rx_data_reg[7]_0\(1),
      I3 => \frame_reg[9]_1\,
      I4 => \frame_reg[9]_2\,
      I5 => \^rx_data_reg[7]_0\(3),
      O => \FSM_sequential_state[2]_i_3_n_0\
    );
\FSM_sequential_state[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000200000000000"
    )
        port map (
      I0 => \FSM_sequential_state[2]_i_5_n_0\,
      I1 => \^rx_data_reg[7]_0\(6),
      I2 => \^rx_data_reg[7]_0\(3),
      I3 => \^rx_valid\,
      I4 => \^rx_data_reg[7]_0\(4),
      I5 => \^rx_data_reg[7]_0\(1),
      O => \FSM_sequential_state[2]_i_4_n_0\
    );
\FSM_sequential_state[2]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0008"
    )
        port map (
      I0 => \^rx_data_reg[7]_0\(5),
      I1 => \^rx_data_reg[7]_0\(7),
      I2 => \^rx_data_reg[7]_0\(0),
      I3 => \^rx_data_reg[7]_0\(2),
      O => \FSM_sequential_state[2]_i_5_n_0\
    );
IOBUF_inst_0: unisim.vcomponents.IOBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
        port map (
      I => ps2_clk_out,
      IO => PS2_CLK,
      O => ps2_clk_in,
      T => T0
    );
IOBUF_inst_1: unisim.vcomponents.IOBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
        port map (
      I => ps2_data_out,
      IO => PS2_DATA,
      O => ps2_data_in,
      T => ps2_data_en_reg_inv_n_0
    );
\bits_count[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[1]\,
      I1 => \bits_count_reg_n_0_[0]\,
      O => \bits_count[0]_i_1_n_0\
    );
\bits_count[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
        port map (
      I0 => \bits_count_reg_n_0_[1]\,
      I1 => \bits_count_reg_n_0_[0]\,
      I2 => \FSM_onehot_state_reg_n_0_[1]\,
      O => \bits_count[1]_i_1_n_0\
    );
\bits_count[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0078"
    )
        port map (
      I0 => \bits_count_reg_n_0_[0]\,
      I1 => \bits_count_reg_n_0_[1]\,
      I2 => \bits_count_reg_n_0_[2]\,
      I3 => \FSM_onehot_state_reg_n_0_[1]\,
      O => \bits_count[2]_i_1_n_0\
    );
\bits_count[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[1]\,
      I1 => \FSM_onehot_state_reg_n_0_[2]\,
      I2 => p_1_in_0,
      O => bits_count
    );
\bits_count[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"15554000"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[1]\,
      I1 => \bits_count_reg_n_0_[2]\,
      I2 => \bits_count_reg_n_0_[1]\,
      I3 => \bits_count_reg_n_0_[0]\,
      I4 => \bits_count_reg_n_0_[3]\,
      O => \bits_count[3]_i_2_n_0\
    );
\bits_count_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => bits_count,
      CLR => rst,
      D => \bits_count[0]_i_1_n_0\,
      Q => \bits_count_reg_n_0_[0]\
    );
\bits_count_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => bits_count,
      CLR => rst,
      D => \bits_count[1]_i_1_n_0\,
      Q => \bits_count_reg_n_0_[1]\
    );
\bits_count_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => bits_count,
      CLR => rst,
      D => \bits_count[2]_i_1_n_0\,
      Q => \bits_count_reg_n_0_[2]\
    );
\bits_count_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => bits_count,
      CLR => rst,
      D => \bits_count[3]_i_2_n_0\,
      Q => \bits_count_reg_n_0_[3]\
    );
\clk_count[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D55500000000D555"
    )
        port map (
      I0 => clk_count(0),
      I1 => clk_count(3),
      I2 => clk_count(2),
      I3 => clk_count(1),
      I4 => ps2_clk_in,
      I5 => clk_inter,
      O => \clk_count[0]_i_1_n_0\
    );
\clk_count[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8FF0000000008FF0"
    )
        port map (
      I0 => clk_count(3),
      I1 => clk_count(2),
      I2 => clk_count(0),
      I3 => clk_count(1),
      I4 => ps2_clk_in,
      I5 => clk_inter,
      O => \clk_count[1]_i_1_n_0\
    );
\clk_count[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BCCC00000000BCCC"
    )
        port map (
      I0 => clk_count(3),
      I1 => clk_count(2),
      I2 => clk_count(0),
      I3 => clk_count(1),
      I4 => ps2_clk_in,
      I5 => clk_inter,
      O => \clk_count[2]_i_1_n_0\
    );
\clk_count[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EAAA00000000EAAA"
    )
        port map (
      I0 => clk_count(3),
      I1 => clk_count(2),
      I2 => clk_count(0),
      I3 => clk_count(1),
      I4 => ps2_clk_in,
      I5 => clk_inter,
      O => \clk_count[3]_i_1_n_0\
    );
\clk_count_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \clk_count[0]_i_1_n_0\,
      Q => clk_count(0)
    );
\clk_count_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \clk_count[1]_i_1_n_0\,
      Q => clk_count(1)
    );
\clk_count_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \clk_count[2]_i_1_n_0\,
      Q => clk_count(2)
    );
\clk_count_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \clk_count[3]_i_1_n_0\,
      Q => clk_count(3)
    );
clk_inter_reg: unisim.vcomponents.FDPE
     port map (
      C => clk,
      CE => '1',
      D => ps2_clk_in,
      PRE => rst,
      Q => clk_inter
    );
\counter[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2020E0FF"
    )
        port map (
      I0 => state_next1,
      I1 => \FSM_onehot_state[12]_i_2_n_0\,
      I2 => \FSM_onehot_state_reg_n_0_[12]\,
      I3 => \counter[13]_i_3_n_0\,
      I4 => counter(0),
      O => \counter[0]_i_1_n_0\
    );
\counter[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"80AA"
    )
        port map (
      I0 => data1(10),
      I1 => \FSM_onehot_state_reg_n_0_[12]\,
      I2 => \FSM_onehot_state[12]_i_2_n_0\,
      I3 => \counter[13]_i_3_n_0\,
      O => \counter[10]_i_1_n_0\
    );
\counter[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"80AA"
    )
        port map (
      I0 => data1(11),
      I1 => \FSM_onehot_state_reg_n_0_[12]\,
      I2 => \FSM_onehot_state[12]_i_2_n_0\,
      I3 => \counter[13]_i_3_n_0\,
      O => \counter[11]_i_1_n_0\
    );
\counter[12]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"80AA"
    )
        port map (
      I0 => data1(12),
      I1 => \FSM_onehot_state_reg_n_0_[12]\,
      I2 => \FSM_onehot_state[12]_i_2_n_0\,
      I3 => \counter[13]_i_3_n_0\,
      O => \counter[12]_i_1_n_0\
    );
\counter[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"80AA"
    )
        port map (
      I0 => data1(13),
      I1 => \FSM_onehot_state_reg_n_0_[12]\,
      I2 => \FSM_onehot_state[12]_i_2_n_0\,
      I3 => \counter[13]_i_3_n_0\,
      O => \counter[13]_i_1_n_0\
    );
\counter[13]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000733333737"
    )
        port map (
      I0 => \counter[13]_i_4_n_0\,
      I1 => \FSM_onehot_state_reg_n_0_[4]\,
      I2 => \FSM_onehot_state[14]_i_3_n_0\,
      I3 => \counter[13]_i_5_n_0\,
      I4 => \FSM_onehot_state[14]_i_4_n_0\,
      I5 => \FSM_onehot_state_reg_n_0_[3]\,
      O => \counter[13]_i_3_n_0\
    );
\counter[13]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EFFF"
    )
        port map (
      I0 => counter(13),
      I1 => counter(12),
      I2 => counter(7),
      I3 => counter(6),
      O => \counter[13]_i_4_n_0\
    );
\counter[13]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEF"
    )
        port map (
      I0 => counter(7),
      I1 => counter(6),
      I2 => counter(13),
      I3 => counter(12),
      O => \counter[13]_i_5_n_0\
    );
\counter[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F5D500C0"
    )
        port map (
      I0 => \counter[13]_i_3_n_0\,
      I1 => state_next1,
      I2 => \FSM_onehot_state_reg_n_0_[12]\,
      I3 => \FSM_onehot_state[12]_i_2_n_0\,
      I4 => data1(1),
      O => \counter[1]_i_1_n_0\
    );
\counter[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F5D500C0"
    )
        port map (
      I0 => \counter[13]_i_3_n_0\,
      I1 => state_next1,
      I2 => \FSM_onehot_state_reg_n_0_[12]\,
      I3 => \FSM_onehot_state[12]_i_2_n_0\,
      I4 => data1(2),
      O => \counter[2]_i_1_n_0\
    );
\counter[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F5D500C0"
    )
        port map (
      I0 => \counter[13]_i_3_n_0\,
      I1 => state_next1,
      I2 => \FSM_onehot_state_reg_n_0_[12]\,
      I3 => \FSM_onehot_state[12]_i_2_n_0\,
      I4 => data1(3),
      O => \counter[3]_i_1_n_0\
    );
\counter[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F5D500C0"
    )
        port map (
      I0 => \counter[13]_i_3_n_0\,
      I1 => state_next1,
      I2 => \FSM_onehot_state_reg_n_0_[12]\,
      I3 => \FSM_onehot_state[12]_i_2_n_0\,
      I4 => data1(4),
      O => \counter[4]_i_1_n_0\
    );
\counter[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A2F2A222"
    )
        port map (
      I0 => data1(5),
      I1 => \counter[13]_i_3_n_0\,
      I2 => \FSM_onehot_state_reg_n_0_[12]\,
      I3 => \FSM_onehot_state[12]_i_2_n_0\,
      I4 => state_next1,
      O => \counter[5]_i_1_n_0\
    );
\counter[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"80AA"
    )
        port map (
      I0 => data1(6),
      I1 => \FSM_onehot_state_reg_n_0_[12]\,
      I2 => \FSM_onehot_state[12]_i_2_n_0\,
      I3 => \counter[13]_i_3_n_0\,
      O => \counter[6]_i_1_n_0\
    );
\counter[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"80AA"
    )
        port map (
      I0 => data1(7),
      I1 => \FSM_onehot_state_reg_n_0_[12]\,
      I2 => \FSM_onehot_state[12]_i_2_n_0\,
      I3 => \counter[13]_i_3_n_0\,
      O => \counter[7]_i_1_n_0\
    );
\counter[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"80AA"
    )
        port map (
      I0 => data1(8),
      I1 => \FSM_onehot_state_reg_n_0_[12]\,
      I2 => \FSM_onehot_state[12]_i_2_n_0\,
      I3 => \counter[13]_i_3_n_0\,
      O => \counter[8]_i_1_n_0\
    );
\counter[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"80AA"
    )
        port map (
      I0 => data1(9),
      I1 => \FSM_onehot_state_reg_n_0_[12]\,
      I2 => \FSM_onehot_state[12]_i_2_n_0\,
      I3 => \counter[13]_i_3_n_0\,
      O => \counter[9]_i_1_n_0\
    );
\counter_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \counter[0]_i_1_n_0\,
      Q => counter(0)
    );
\counter_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \counter[10]_i_1_n_0\,
      Q => counter(10)
    );
\counter_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \counter[11]_i_1_n_0\,
      Q => counter(11)
    );
\counter_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \counter[12]_i_1_n_0\,
      Q => counter(12)
    );
\counter_reg[12]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter_reg[8]_i_2_n_0\,
      CO(3) => \counter_reg[12]_i_2_n_0\,
      CO(2) => \counter_reg[12]_i_2_n_1\,
      CO(1) => \counter_reg[12]_i_2_n_2\,
      CO(0) => \counter_reg[12]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data1(12 downto 9),
      S(3 downto 0) => counter(12 downto 9)
    );
\counter_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \counter[13]_i_1_n_0\,
      Q => counter(13)
    );
\counter_reg[13]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter_reg[12]_i_2_n_0\,
      CO(3 downto 0) => \NLW_counter_reg[13]_i_2_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 1) => \NLW_counter_reg[13]_i_2_O_UNCONNECTED\(3 downto 1),
      O(0) => data1(13),
      S(3 downto 1) => B"000",
      S(0) => counter(13)
    );
\counter_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \counter[1]_i_1_n_0\,
      Q => counter(1)
    );
\counter_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \counter[2]_i_1_n_0\,
      Q => counter(2)
    );
\counter_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \counter[3]_i_1_n_0\,
      Q => counter(3)
    );
\counter_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \counter[4]_i_1_n_0\,
      Q => counter(4)
    );
\counter_reg[4]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \counter_reg[4]_i_2_n_0\,
      CO(2) => \counter_reg[4]_i_2_n_1\,
      CO(1) => \counter_reg[4]_i_2_n_2\,
      CO(0) => \counter_reg[4]_i_2_n_3\,
      CYINIT => counter(0),
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data1(4 downto 1),
      S(3 downto 0) => counter(4 downto 1)
    );
\counter_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \counter[5]_i_1_n_0\,
      Q => counter(5)
    );
\counter_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \counter[6]_i_1_n_0\,
      Q => counter(6)
    );
\counter_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \counter[7]_i_1_n_0\,
      Q => counter(7)
    );
\counter_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \counter[8]_i_1_n_0\,
      Q => counter(8)
    );
\counter_reg[8]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter_reg[4]_i_2_n_0\,
      CO(3) => \counter_reg[8]_i_2_n_0\,
      CO(2) => \counter_reg[8]_i_2_n_1\,
      CO(1) => \counter_reg[8]_i_2_n_2\,
      CO(0) => \counter_reg[8]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data1(8 downto 5),
      S(3 downto 0) => counter(8 downto 5)
    );
\counter_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \counter[9]_i_1_n_0\,
      Q => counter(9)
    );
\data_count[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D55500000000D555"
    )
        port map (
      I0 => data_count(0),
      I1 => data_count(3),
      I2 => data_count(2),
      I3 => data_count(1),
      I4 => ps2_data_in,
      I5 => data_inter,
      O => \data_count[0]_i_1_n_0\
    );
\data_count[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8FF0000000008FF0"
    )
        port map (
      I0 => data_count(3),
      I1 => data_count(2),
      I2 => data_count(0),
      I3 => data_count(1),
      I4 => ps2_data_in,
      I5 => data_inter,
      O => \data_count[1]_i_1_n_0\
    );
\data_count[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BCCC00000000BCCC"
    )
        port map (
      I0 => data_count(3),
      I1 => data_count(2),
      I2 => data_count(0),
      I3 => data_count(1),
      I4 => ps2_data_in,
      I5 => data_inter,
      O => \data_count[2]_i_1_n_0\
    );
\data_count[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EAAA00000000EAAA"
    )
        port map (
      I0 => data_count(3),
      I1 => data_count(2),
      I2 => data_count(0),
      I3 => data_count(1),
      I4 => ps2_data_in,
      I5 => data_inter,
      O => \data_count[3]_i_1_n_0\
    );
\data_count_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \data_count[0]_i_1_n_0\,
      Q => data_count(0)
    );
\data_count_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \data_count[1]_i_1_n_0\,
      Q => data_count(1)
    );
\data_count_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \data_count[2]_i_1_n_0\,
      Q => data_count(2)
    );
\data_count_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \data_count[3]_i_1_n_0\,
      Q => data_count(3)
    );
data_inter_reg: unisim.vcomponents.FDPE
     port map (
      C => clk,
      CE => '1',
      D => ps2_data_in,
      PRE => rst,
      Q => data_inter
    );
err_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8F88"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[8]\,
      I1 => state_next1,
      I2 => err_i_2_n_0,
      I3 => err_i_3_n_0,
      O => err_next
    );
err_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"DFFFFFFF"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => \bits_count_reg_n_0_[2]\,
      I2 => \bits_count_reg_n_0_[3]\,
      I3 => \bits_count_reg_n_0_[0]\,
      I4 => \bits_count_reg_n_0_[1]\,
      O => err_i_2_n_0
    );
err_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9669"
    )
        port map (
      I0 => \parity_table_inferred__0/i_/i__n_0\,
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => \frame_reg_n_0_[9]\,
      O => err_i_3_n_0
    );
err_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => err_next,
      Q => \^err_reg_0\
    );
\frame[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"2A"
    )
        port map (
      I0 => p_0_in(0),
      I1 => \frame_reg[9]_0\,
      I2 => \FSM_onehot_state_reg_n_0_[1]\,
      O => p_1_in(0)
    );
\frame[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FEEE"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[2]\,
      I1 => p_1_in_0,
      I2 => \frame_reg[9]_0\,
      I3 => \FSM_onehot_state_reg_n_0_[1]\,
      O => \frame[10]_i_1_n_0\
    );
\frame[10]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
        port map (
      I0 => \ps2_data_s__0\,
      I1 => \frame_reg[9]_0\,
      I2 => \FSM_onehot_state_reg_n_0_[1]\,
      O => p_1_in(10)
    );
\frame[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BF80"
    )
        port map (
      I0 => \frame_reg[9]_1\,
      I1 => \FSM_onehot_state_reg_n_0_[1]\,
      I2 => \frame_reg[9]_0\,
      I3 => p_0_in(1),
      O => p_1_in(1)
    );
\frame[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BF80"
    )
        port map (
      I0 => \frame_reg[9]_1\,
      I1 => \FSM_onehot_state_reg_n_0_[1]\,
      I2 => \frame_reg[9]_0\,
      I3 => p_0_in(2),
      O => p_1_in(2)
    );
\frame[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BF80"
    )
        port map (
      I0 => \frame_reg[9]_1\,
      I1 => \FSM_onehot_state_reg_n_0_[1]\,
      I2 => \frame_reg[9]_0\,
      I3 => p_0_in(3),
      O => p_1_in(3)
    );
\frame[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BF80"
    )
        port map (
      I0 => \frame_reg[9]_2\,
      I1 => \FSM_onehot_state_reg_n_0_[1]\,
      I2 => \frame_reg[9]_0\,
      I3 => p_0_in(4),
      O => p_1_in(4)
    );
\frame[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BF80"
    )
        port map (
      I0 => \frame_reg[9]_2\,
      I1 => \FSM_onehot_state_reg_n_0_[1]\,
      I2 => \frame_reg[9]_0\,
      I3 => p_0_in(5),
      O => p_1_in(5)
    );
\frame[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BF80"
    )
        port map (
      I0 => \frame_reg[9]_2\,
      I1 => \FSM_onehot_state_reg_n_0_[1]\,
      I2 => \frame_reg[9]_0\,
      I3 => p_0_in(6),
      O => p_1_in(6)
    );
\frame[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BF80"
    )
        port map (
      I0 => \frame_reg[9]_2\,
      I1 => \FSM_onehot_state_reg_n_0_[1]\,
      I2 => \frame_reg[9]_0\,
      I3 => p_0_in(7),
      O => p_1_in(7)
    );
\frame[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BF80"
    )
        port map (
      I0 => \frame_reg[9]_2\,
      I1 => \FSM_onehot_state_reg_n_0_[1]\,
      I2 => \frame_reg[9]_0\,
      I3 => \frame_reg_n_0_[9]\,
      O => p_1_in(8)
    );
\frame[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"9FFF9000"
    )
        port map (
      I0 => \frame_reg[9]_1\,
      I1 => \frame_reg[9]_2\,
      I2 => \FSM_onehot_state_reg_n_0_[1]\,
      I3 => \frame_reg[9]_0\,
      I4 => \frame_reg_n_0_[10]\,
      O => p_1_in(9)
    );
\frame_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \frame[10]_i_1_n_0\,
      CLR => rst,
      D => p_1_in(0),
      Q => \frame_reg_n_0_[0]\
    );
\frame_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \frame[10]_i_1_n_0\,
      CLR => rst,
      D => p_1_in(10),
      Q => \frame_reg_n_0_[10]\
    );
\frame_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \frame[10]_i_1_n_0\,
      CLR => rst,
      D => p_1_in(1),
      Q => p_0_in(0)
    );
\frame_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \frame[10]_i_1_n_0\,
      CLR => rst,
      D => p_1_in(2),
      Q => p_0_in(1)
    );
\frame_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \frame[10]_i_1_n_0\,
      CLR => rst,
      D => p_1_in(3),
      Q => p_0_in(2)
    );
\frame_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \frame[10]_i_1_n_0\,
      CLR => rst,
      D => p_1_in(4),
      Q => p_0_in(3)
    );
\frame_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \frame[10]_i_1_n_0\,
      CLR => rst,
      D => p_1_in(5),
      Q => p_0_in(4)
    );
\frame_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \frame[10]_i_1_n_0\,
      CLR => rst,
      D => p_1_in(6),
      Q => p_0_in(5)
    );
\frame_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \frame[10]_i_1_n_0\,
      CLR => rst,
      D => p_1_in(7),
      Q => p_0_in(6)
    );
\frame_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \frame[10]_i_1_n_0\,
      CLR => rst,
      D => p_1_in(8),
      Q => p_0_in(7)
    );
\frame_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \frame[10]_i_1_n_0\,
      CLR => rst,
      D => p_1_in(9),
      Q => \frame_reg_n_0_[9]\
    );
is_break_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0091"
    )
        port map (
      I0 => Q(2),
      I1 => Q(1),
      I2 => \^rx_valid\,
      I3 => Q(0),
      O => \FSM_sequential_state_reg[2]\
    );
is_extend_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0800080"
    )
        port map (
      I0 => Q(0),
      I1 => \^rx_valid\,
      I2 => Q(2),
      I3 => Q(1),
      I4 => is_extend,
      O => \FSM_sequential_state_reg[0]\
    );
\parity_table_inferred__0/i_/i_\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => p_0_in(3),
      I1 => p_0_in(2),
      I2 => p_0_in(6),
      I3 => p_0_in(7),
      I4 => p_0_in(4),
      I5 => p_0_in(5),
      O => \parity_table_inferred__0/i_/i__n_0\
    );
ps2_clk_en_inv_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[4]\,
      I1 => \FSM_onehot_state_reg_n_0_[3]\,
      O => ps2_clk_en_next
    );
ps2_clk_en_reg_inv: unisim.vcomponents.FDPE
     port map (
      C => clk,
      CE => '1',
      D => ps2_clk_en_next,
      PRE => rst,
      Q => T0
    );
ps2_clk_out_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => ps2_clk_out_i_2_n_0,
      I1 => \FSM_onehot_state_reg_n_0_[13]\,
      I2 => \FSM_onehot_state_reg_n_0_[9]\,
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => ps2_clk_out_i_3_n_0,
      O => ps2_clk_out_next
    );
ps2_clk_out_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[5]\,
      I1 => \FSM_onehot_state_reg_n_0_[8]\,
      I2 => \FSM_onehot_state_reg_n_0_[6]\,
      I3 => \FSM_onehot_state_reg_n_0_[7]\,
      I4 => \FSM_onehot_state_reg_n_0_[1]\,
      I5 => \FSM_onehot_state_reg_n_0_[0]\,
      O => ps2_clk_out_i_2_n_0
    );
ps2_clk_out_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[10]\,
      I1 => p_1_in_0,
      I2 => \FSM_onehot_state_reg_n_0_[14]\,
      I3 => \FSM_onehot_state_reg_n_0_[12]\,
      O => ps2_clk_out_i_3_n_0
    );
ps2_clk_out_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ps2_clk_out_next,
      Q => ps2_clk_out
    );
ps2_clk_s: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => clk_count(0),
      I1 => clk_count(1),
      O => ps2_clk_s_n_0
    );
ps2_clk_s_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFF708000000"
    )
        port map (
      I0 => clk_count(3),
      I1 => clk_count(2),
      I2 => ps2_clk_s_n_0,
      I3 => ps2_clk_in,
      I4 => clk_inter,
      I5 => state_next1,
      O => ps2_clk_s_i_1_n_0
    );
ps2_clk_s_reg: unisim.vcomponents.FDPE
     port map (
      C => clk,
      CE => '1',
      D => ps2_clk_s_i_1_n_0,
      PRE => rst,
      Q => state_next1
    );
ps2_data_en_inv_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000002"
    )
        port map (
      I0 => \FSM_onehot_state[13]_i_2_n_0\,
      I1 => \FSM_onehot_state_reg_n_0_[10]\,
      I2 => p_1_in_0,
      I3 => \FSM_onehot_state_reg_n_0_[14]\,
      I4 => \FSM_onehot_state_reg_n_0_[12]\,
      I5 => \FSM_onehot_state_reg_n_0_[4]\,
      O => ps2_data_en_next
    );
ps2_data_en_reg_inv: unisim.vcomponents.FDPE
     port map (
      C => clk,
      CE => '1',
      D => ps2_data_en_next,
      PRE => rst,
      Q => ps2_data_en_reg_inv_n_0
    );
ps2_data_out_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => ps2_data_out_i_2_n_0,
      I1 => ps2_clk_out_i_2_n_0,
      I2 => \FSM_onehot_state_reg_n_0_[3]\,
      I3 => \FSM_onehot_state_reg_n_0_[9]\,
      I4 => \FSM_onehot_state_reg_n_0_[2]\,
      O => ps2_data_out_next
    );
ps2_data_out_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAA8"
    )
        port map (
      I0 => \frame_reg_n_0_[0]\,
      I1 => p_1_in_0,
      I2 => \FSM_onehot_state_reg_n_0_[10]\,
      I3 => \FSM_onehot_state_reg_n_0_[13]\,
      O => ps2_data_out_i_2_n_0
    );
ps2_data_out_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ps2_data_out_next,
      Q => ps2_data_out
    );
ps2_data_s: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => data_count(0),
      I1 => data_count(1),
      O => ps2_data_s_n_0
    );
ps2_data_s_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFF708000000"
    )
        port map (
      I0 => data_count(3),
      I1 => data_count(2),
      I2 => ps2_data_s_n_0,
      I3 => ps2_data_in,
      I4 => data_inter,
      I5 => \ps2_data_s__0\,
      O => ps2_data_s_i_1_n_0
    );
ps2_data_s_reg: unisim.vcomponents.FDPE
     port map (
      C => clk,
      CE => '1',
      D => ps2_data_s_i_1_n_0,
      PRE => rst,
      Q => \ps2_data_s__0\
    );
\rx_data[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00006996"
    )
        port map (
      I0 => \frame_reg_n_0_[9]\,
      I1 => p_0_in(1),
      I2 => p_0_in(0),
      I3 => \parity_table_inferred__0/i_/i__n_0\,
      I4 => err_i_2_n_0,
      O => rx_finish
    );
\rx_data_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => rx_finish,
      CLR => rst,
      D => p_0_in(0),
      Q => \^rx_data_reg[7]_0\(0)
    );
\rx_data_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => rx_finish,
      CLR => rst,
      D => p_0_in(1),
      Q => \^rx_data_reg[7]_0\(1)
    );
\rx_data_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => rx_finish,
      CLR => rst,
      D => p_0_in(2),
      Q => \^rx_data_reg[7]_0\(2)
    );
\rx_data_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => rx_finish,
      CLR => rst,
      D => p_0_in(3),
      Q => \^rx_data_reg[7]_0\(3)
    );
\rx_data_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => rx_finish,
      CLR => rst,
      D => p_0_in(4),
      Q => \^rx_data_reg[7]_0\(4)
    );
\rx_data_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => rx_finish,
      CLR => rst,
      D => p_0_in(5),
      Q => \^rx_data_reg[7]_0\(5)
    );
\rx_data_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => rx_finish,
      CLR => rst,
      D => p_0_in(6),
      Q => \^rx_data_reg[7]_0\(6)
    );
\rx_data_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => rx_finish,
      CLR => rst,
      D => p_0_in(7),
      Q => \^rx_data_reg[7]_0\(7)
    );
rx_valid_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => rx_finish,
      Q => \^rx_valid\
    );
tx_valid_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => Q(1),
      I1 => Q(2),
      I2 => Q(0),
      I3 => \FSM_onehot_state_reg_n_0_[1]\,
      O => \^tx_valid\
    );
valid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3F34000000000000"
    )
        port map (
      I0 => \^rx_data_reg[7]_0\(4),
      I1 => Q(0),
      I2 => Q(1),
      I3 => valid_i_2_n_0,
      I4 => Q(2),
      I5 => \^rx_valid\,
      O => \rx_data_reg[4]_0\
    );
valid_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FDFF"
    )
        port map (
      I0 => valid_i_3_n_0,
      I1 => \^rx_data_reg[7]_0\(1),
      I2 => \^rx_data_reg[7]_0\(3),
      I3 => \^rx_valid\,
      O => valid_i_2_n_0
    );
valid_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"02000000"
    )
        port map (
      I0 => \^rx_data_reg[7]_0\(6),
      I1 => \^rx_data_reg[7]_0\(2),
      I2 => \^rx_data_reg[7]_0\(0),
      I3 => \^rx_data_reg[7]_0\(7),
      I4 => \^rx_data_reg[7]_0\(5),
      O => valid_i_3_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity KeyboardCtrl_0_KeyboardCtrl is
  port (
    err : out STD_LOGIC;
    key_in : out STD_LOGIC_VECTOR ( 7 downto 0 );
    is_break : out STD_LOGIC;
    valid : out STD_LOGIC;
    is_extend : out STD_LOGIC;
    PS2_CLK : inout STD_LOGIC;
    PS2_DATA : inout STD_LOGIC;
    clk : in STD_LOGIC;
    rst : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of KeyboardCtrl_0_KeyboardCtrl : entity is "KeyboardCtrl";
end KeyboardCtrl_0_KeyboardCtrl;

architecture STRUCTURE of KeyboardCtrl_0_KeyboardCtrl is
  signal Ps2Interface_i_n_11 : STD_LOGIC;
  signal Ps2Interface_i_n_12 : STD_LOGIC;
  signal Ps2Interface_i_n_13 : STD_LOGIC;
  signal Ps2Interface_i_n_14 : STD_LOGIC;
  signal Ps2Interface_i_n_16 : STD_LOGIC;
  signal Ps2Interface_i_n_2 : STD_LOGIC;
  signal \^is_extend\ : STD_LOGIC;
  signal rx_data : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal rx_valid : STD_LOGIC;
  signal state : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \tx_data[0]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data[7]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[0]\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[7]\ : STD_LOGIC;
  signal tx_valid : STD_LOGIC;
  signal tx_valid_reg_n_0 : STD_LOGIC;
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[0]\ : label is "SEND_CMD:001,WAIT_ACK:010,GET_BREAK:110,GET_EXTEND:101,WAIT_KEYIN:100,RESET_WAIT_BAT:011,RESET:000";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[1]\ : label is "SEND_CMD:001,WAIT_ACK:010,GET_BREAK:110,GET_EXTEND:101,WAIT_KEYIN:100,RESET_WAIT_BAT:011,RESET:000";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[2]\ : label is "SEND_CMD:001,WAIT_ACK:010,GET_BREAK:110,GET_EXTEND:101,WAIT_KEYIN:100,RESET_WAIT_BAT:011,RESET:000";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \tx_data[0]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \tx_data[7]_i_1\ : label is "soft_lutpair23";
begin
  is_extend <= \^is_extend\;
\FSM_sequential_state_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Ps2Interface_i_n_14,
      Q => state(0)
    );
\FSM_sequential_state_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Ps2Interface_i_n_13,
      Q => state(1)
    );
\FSM_sequential_state_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Ps2Interface_i_n_12,
      Q => state(2)
    );
Ps2Interface_i: entity work.KeyboardCtrl_0_Ps2Interface
     port map (
      D(2) => Ps2Interface_i_n_12,
      D(1) => Ps2Interface_i_n_13,
      D(0) => Ps2Interface_i_n_14,
      \FSM_sequential_state_reg[0]\ => Ps2Interface_i_n_2,
      \FSM_sequential_state_reg[2]\ => Ps2Interface_i_n_11,
      PS2_CLK => PS2_CLK,
      PS2_DATA => PS2_DATA,
      Q(2 downto 0) => state(2 downto 0),
      clk => clk,
      err_reg_0 => err,
      \frame_reg[9]_0\ => tx_valid_reg_n_0,
      \frame_reg[9]_1\ => \tx_data_reg_n_0_[0]\,
      \frame_reg[9]_2\ => \tx_data_reg_n_0_[7]\,
      is_extend => \^is_extend\,
      rst => rst,
      \rx_data_reg[4]_0\ => Ps2Interface_i_n_16,
      \rx_data_reg[7]_0\(7 downto 0) => rx_data(7 downto 0),
      rx_valid => rx_valid,
      tx_valid => tx_valid
    );
is_break_reg: unisim.vcomponents.FDPE
     port map (
      C => clk,
      CE => '1',
      D => Ps2Interface_i_n_11,
      PRE => rst,
      Q => is_break
    );
is_extend_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Ps2Interface_i_n_2,
      Q => \^is_extend\
    );
\key_in_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => rx_valid,
      CLR => rst,
      D => rx_data(0),
      Q => key_in(0)
    );
\key_in_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => rx_valid,
      CLR => rst,
      D => rx_data(1),
      Q => key_in(1)
    );
\key_in_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => rx_valid,
      CLR => rst,
      D => rx_data(2),
      Q => key_in(2)
    );
\key_in_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => rx_valid,
      CLR => rst,
      D => rx_data(3),
      Q => key_in(3)
    );
\key_in_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => rx_valid,
      CLR => rst,
      D => rx_data(4),
      Q => key_in(4)
    );
\key_in_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => rx_valid,
      CLR => rst,
      D => rx_data(5),
      Q => key_in(5)
    );
\key_in_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => rx_valid,
      CLR => rst,
      D => rx_data(6),
      Q => key_in(6)
    );
\key_in_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => rx_valid,
      CLR => rst,
      D => rx_data(7),
      Q => key_in(7)
    );
\tx_data[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF01"
    )
        port map (
      I0 => state(1),
      I1 => state(2),
      I2 => state(0),
      I3 => \tx_data_reg_n_0_[0]\,
      O => \tx_data[0]_i_1_n_0\
    );
\tx_data[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF01"
    )
        port map (
      I0 => state(1),
      I1 => state(2),
      I2 => state(0),
      I3 => \tx_data_reg_n_0_[7]\,
      O => \tx_data[7]_i_1_n_0\
    );
\tx_data_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \tx_data[0]_i_1_n_0\,
      Q => \tx_data_reg_n_0_[0]\
    );
\tx_data_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \tx_data[7]_i_1_n_0\,
      Q => \tx_data_reg_n_0_[7]\
    );
tx_valid_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => tx_valid,
      Q => tx_valid_reg_n_0
    );
valid_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Ps2Interface_i_n_16,
      Q => valid
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity KeyboardCtrl_0 is
  port (
    key_in : out STD_LOGIC_VECTOR ( 7 downto 0 );
    is_extend : out STD_LOGIC;
    is_break : out STD_LOGIC;
    valid : out STD_LOGIC;
    err : out STD_LOGIC;
    PS2_DATA : inout STD_LOGIC;
    PS2_CLK : inout STD_LOGIC;
    rst : in STD_LOGIC;
    clk : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of KeyboardCtrl_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of KeyboardCtrl_0 : entity is "KeyboardCtrl_0,KeyboardCtrl,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of KeyboardCtrl_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of KeyboardCtrl_0 : entity is "KeyboardCtrl,Vivado 2019.1";
end KeyboardCtrl_0;

architecture STRUCTURE of KeyboardCtrl_0 is
begin
inst: entity work.KeyboardCtrl_0_KeyboardCtrl
     port map (
      PS2_CLK => PS2_CLK,
      PS2_DATA => PS2_DATA,
      clk => clk,
      err => err,
      is_break => is_break,
      is_extend => is_extend,
      key_in(7 downto 0) => key_in(7 downto 0),
      rst => rst,
      valid => valid
    );
end STRUCTURE;
