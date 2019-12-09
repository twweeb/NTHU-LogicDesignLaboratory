`define IDLE 3'b00
`define SPLIT 3'b01
`define CLEAN 3'b10
`define PASTE 3'b11
module top(
   input clk,
   input rst,
   input shift,
   input split,
   output [3:0] vgaRed,
   output [3:0] vgaGreen,
   output [3:0] vgaBlue,
   output hsync,
   output vsync
    );

    wire [11:0] data,data1;
    wire clk_25MHz;
    wire clk_22;
    wire [16:0] pixel_addr;
    wire [11:0] pixel,pixel1;
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480
    wire change_de,change_one,split_de,split_one,finish,paste,pic;
    reg [1:0] state,state_next;
    wire val;

  assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b0 && val == 1'b0) ? 12'h0: pixel;
  
  debounce change_debounce(.clk(clk),.pb(shift),.pb_debounced(change_de));
  one_pulse change_1pulse(.clk(clk),.pb_debounced(change_de),.pb_1pulse(change_one));
  debounce split_debounce(.clk(clk),.pb(split),.pb_debounced(split_de));
  one_pulse split_1pulse(.clk(clk),.pb_debounced(split_de),.pb_1pulse(split_one));
  
  always@(posedge rst or posedge clk)begin
    if(rst)begin
        state <= `IDLE;
    end
    else begin
        state <= state_next;
    end
  end
  
  always@(*)begin
    case(state)
        `IDLE:begin
            if(change_one)begin
                state_next = `CLEAN;
            end
            else if(split_one)begin
                state_next = `SPLIT; 
            end
            else begin
                state_next = state;
            end
        end
        `SPLIT:begin
            if(finish)begin
                state_next = `IDLE;
            end
            else begin
                state_next = state;
            end
        end
        `CLEAN:begin
            if(paste)begin
                state_next = `PASTE;
            end
            else begin
                state_next = state;
            end
        end
        `PASTE:begin
            if(finish)begin
                state_next = `IDLE;
            end
            else begin
                state_next =state;
            end
        end
    endcase
  end

     clock_divisor clk_wiz_0_inst(
      .clk(clk),
      .clk1(clk_25MHz),
      .clk22(clk_22)
    );

    mem_addr_gen mem_addr_gen_inst(
    .clk(clk_22),
    .rst(rst),
    .state(state),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .pixel_addr(pixel_addr),
    .finish(finish),
    .paste(paste),
    .valid(val)
    );
     
 
    blk_mem_gen_0 blk_mem_gen_0_inst(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr),
      .dina(data[11:0]),
      .douta(pixel)
    ); 

    vga_controller   vga_inst(
      .pclk(clk_25MHz),
      .reset(rst),
      .hsync(hsync),
      .vsync(vsync),
      .valid(valid),
      .h_cnt(h_cnt),
      .v_cnt(v_cnt)
    );
    
      
endmodule
