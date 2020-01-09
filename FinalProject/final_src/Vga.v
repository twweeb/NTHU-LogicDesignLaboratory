`timescale 1ns / 1ps

module Vga (clk, clrn, row_addr, col_addr, rdn, r, g, b, hs, vs, px_ground, px_dinosaur, px_score, px_cactus); // vgac
   input      clk;  // 25MHz
   input      clrn;
   input wire px_ground;
   input wire px_dinosaur;
   input wire px_cactus;
   input wire px_score;
   output reg [8:0] row_addr; // pixel ram row address, 480 (512) lines
   output reg [9:0] col_addr; // pixel ram col address, 640 (1024) pixels
   output wire [3:0] r,g,b;
   output reg       rdn;
   output reg       hs,vs;
   wire px;
   
   // h_count: VGA horizontal counter (0-799)
   reg [9:0] h_count;
   always @ (posedge clk) begin
       if (!clrn) begin
           h_count <= 10'h0;
       end else if (h_count == 10'd799) begin
           h_count <= 10'h0;
       end else begin 
           h_count <= h_count + 10'h1;
       end
   end
   
   // v_count: VGA vertical counter (0-524)
   reg [9:0] v_count;
   always @ (posedge clk or negedge clrn) begin
       if (!clrn) begin
           v_count <= 10'h0;
       end else if (h_count == 10'd799) begin
           if (v_count == 10'd524) begin
               v_count <= 10'h0;
           end else begin
               v_count <= v_count + 10'h1;
           end
       end
   end
   
    // signals, will be latched for outputs
    wire  [9:0] row    =  v_count - 10'd35;     // pixel ram row addr 
    wire  [9:0] col    =  h_count - 10'd143;    // pixel ram col addr 
    wire        h_sync = (h_count > 10'd95);    //  96 -> 799
    wire        v_sync = (v_count > 10'd1);     //   2 -> 524
    wire        read   = (h_count > 10'd142) && // 143 -> 782
                         (h_count < 10'd783) && //        640 pixels
                         (v_count > 10'd34)  && //  35 -> 514
                         (v_count < 10'd515);   //        480 lines
    
    //set color to black
    assign r = rdn ? 4'h0 : px ? 4'b0000:4'b1111;
    assign g = rdn ? 4'h0 : px ? 4'b0000:4'b1111;
    assign b = rdn ? 4'h0 : px ? 4'b0000:4'b1111;

    assign px = px_ground || px_dinosaur || px_cactus || px_score;
    
    // vga signals
    always @ (posedge clk) begin
        rdn      <= ~read;     // read pixel (active low)
        hs       <=  h_sync;   // horizontal synchronization
        vs       <=  v_sync;   // vertical   synchronization
        row_addr <=  row[8:0]; // pixel ram row address
        col_addr <=  col;      // pixel ram col address
    end
    
endmodule
