//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/26 02:04:51
// Design Name: 
// Module Name: lab07_2
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


module lab07_2(input clk, input rst, input shift, input split, output [3:0] vgaRed, 
            output [3:0] vgaGreen, output [3:0] vgaBlue, output hsync, output vsync);  
    wire [16:0] pixel_addr;
    wire [11:0] pixel, data;
    wire [9:0] h_cnt, v_cnt;
    wire clk_25MHz, clk_22, valid, valid_t, rst_d, split_d, shift_d, split_1pulse, shift_1pulse;

    assign {vgaRed, vgaGreen, vgaBlue} = (valid & valid_t) ? pixel : 12'h0;
    
    clock_divisor clk_wiz_0_inst(.clk(clk),.clk1(clk_25MHz),.clk22(clk_22));
    
    mem_addr_gen2 mem_addr_gen_inst(.clk(clk_22), .rst(rst_d), .shift(shift_d), .split(split_d), .h_cnt(h_cnt), .v_cnt(v_cnt), .pixel_addr(pixel_addr), .valid(valid_t));

    blk_mem_gen_0 blk_mem_gen_0_inst(.clka(clk_25MHz), .wea(0), .addra(pixel_addr), .dina(data[11:0]), .douta(pixel)); 
    
    vga_controller vga_inst(.pclk(clk_25MHz), .reset(rst_d), .hsync(hsync), .vsync(vsync), .valid(valid), .h_cnt(h_cnt), .v_cnt(v_cnt));
                            
    debounce dreset(.pb_debounced(rst_d), .pb(rst), .clk(clk));
    debounce dshift(.pb_debounced(shift_d), .pb(shift), .clk(clk));
    debounce dsplit(.pb_debounced(split_d), .pb(split), .clk(clk));
endmodule
