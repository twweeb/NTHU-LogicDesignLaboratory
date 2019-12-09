module mem_addr_gen(
   input clk,
   input rst,
   input dir,
   input en,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   output [16:0] pixel_addr,
   output [16:0] pixel_addr_red
   );
    
   reg [8:0] position;
  
   
   assign pixel_addr = ( ((h_cnt>>1)+position)%320 +320*(v_cnt>>1))% 76800;  //640*480 --> 320*240 

   always @ (posedge clk or posedge rst) begin
    if(rst)begin
        position<=9'd0;
    end
    else begin
        if(en)begin
            if(dir)begin
                if(position>9'd0)begin
                    position<=position-1;
                end
                else begin
                    position<=9'd320;
                end
            end
            else begin
                if(position<9'd320) begin
                    position<=position+1;
                end
                else  begin
                    position<=9'd0;
                end
            end
        end
        else begin
            position<=position;
        end
    end
   end
    
endmodule
