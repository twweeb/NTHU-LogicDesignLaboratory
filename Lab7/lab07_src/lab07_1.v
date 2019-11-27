`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/26 02:05:29
// Design Name: 
// Module Name: lab07_1
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


module lab07_1(input clk, input rst, input en, input dir, output [3:0] vgaRed, 
            output [3:0] vgaGreen, output [3:0] vgaBlue, output hsync, output vsync);  
    wire [11:0] data;
    wire clk_25MHz;
    wire clk_22;
    wire clk_d16;
    wire [16:0] pixel_addr;
    wire [11:0] pixel;
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480
    wire rst_d;
    
    reg en_counter;

    assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel : 12'h0;
    
    clock_divider #(.n(16)) c16(.clk(clk), .clk_div(clk_d16));
    
    clock_divisor clk_wiz_0_inst(.clk(clk),.clk1(clk_25MHz),.clk22(clk_22));
    
    mem_addr_gen1 mem_addr_gen_inst(.clk(clk_22), .rst(rst), .dir(dir), .en(en), .h_cnt(h_cnt), .v_cnt(v_cnt), .pixel_addr(pixel_addr));

    blk_mem_gen_0 blk_mem_gen_0_inst(.clka(clk_25MHz), .wea(0), .addra(pixel_addr), .dina(data[11:0]), .douta(pixel)); 
    
    vga_controller vga_inst(.pclk(clk_25MHz), .reset(rst), .hsync(hsync), .vsync(vsync), .valid(valid), .h_cnt(h_cnt), .v_cnt(v_cnt));
                            
    debounce dreset(.pb_debounced(rst_d), .pb(rst), .clk(clk_d16));
endmodule
