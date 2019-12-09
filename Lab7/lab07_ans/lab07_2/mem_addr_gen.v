`define IDLE 3'b00
`define SPLIT 3'b01
`define CLEAN 3'b10
`define PASTE 3'b11
module mem_addr_gen(
   input clk,
   input rst,
   input [1:0] state,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   output [16:0] pixel_addr,
   output finish,
   output paste,
   output valid
   );
   reg valid;
   reg [16:0] pixel_addr_n;
   reg [8:0] position;
   reg finish_n,paste_n;
  
  assign pixel_addr = pixel_addr_n;
  assign finish = finish_n;
  assign paste = paste_n;
   
   always@(*)begin
    case(state)
        `IDLE:begin
            pixel_addr_n = ((h_cnt>>1)+320*(v_cnt>>1))% 76800;
            valid = 1;
        end
        `SPLIT:begin
            if((h_cnt>>1) < 160 && (v_cnt>>1) < 120 - position && position < 120)begin
                pixel_addr_n = ((h_cnt>>1) + 320*(v_cnt>>1) + 320 * position)% 76800;
                valid = 1;
            end
            else if((h_cnt>>1) > 160 + position && (v_cnt>>1) < 120)begin
                pixel_addr_n = (((h_cnt>>1) - position)%320 + 320*(v_cnt>>1))% 76800;
                valid = 1;
            end
            else if ((h_cnt>>1) > 160 && (v_cnt>>1) > 120 + position && position < 120)begin
                pixel_addr_n = ((h_cnt>>1) + 320*(v_cnt>>1) - 320 * position)% 76800;
                valid = 1;
            end
            else if ((h_cnt>>1) < 160 - position && (v_cnt>>1) > 120)begin
                pixel_addr_n = (((h_cnt>>1) + position)%320 + 320*(v_cnt>>1))% 76800;
                valid = 1;
            end
            else begin
                pixel_addr_n = 0;
                valid = 0;
            end
        end
        `CLEAN:begin
            if((h_cnt>>1)< 320-position && (v_cnt>>1)<240)begin
                pixel_addr_n = ((h_cnt>>1) +320*(v_cnt>>1))% 76800;
                valid = 1;
            end
            else begin
                pixel_addr_n = 0;
                valid = 0;
            end
        end
        `PASTE:begin
            if((h_cnt>>1)< 320 && (v_cnt>>1)<position)begin
                pixel_addr_n = ((h_cnt>>1) +320*(v_cnt>>1))% 76800;
                valid = 1;
            end
            else begin
                pixel_addr_n = 0;
                valid = 0;
            end
        end
    endcase
   end
   
   always @ (posedge clk or posedge rst) begin
      if(rst)begin
          position <= 0;
          finish_n <= 0;
          paste_n <= 0;
      end
      else begin
        case(state)
            `IDLE:begin
                position <= 0;
                finish_n <= 0;
                paste_n <= 0;
            end
            `SPLIT:begin
                if(position < 160)begin
                    position <= position + 1;
                    finish_n <= 0;
                    paste_n <= 0;
                end
                else begin
                    position <= 0;
                    finish_n <= 1;
                    paste_n <= 0;
                end
            end
            `CLEAN:begin
                if(position < 320)begin
                    position <= position + 1;
                    finish_n <= 0;
                    paste_n <= 0;
                end
                else begin
                    position <= 0;
                    finish_n <= 0;
                    paste_n <= 1;
                end
            end
            `PASTE:begin
                if(paste)begin
                    position <= 0;
                    finish_n <= 0;
                    paste_n <= 0;
                end
                else begin
                    if(position < 240)begin
                        position <= position + 1;
                        finish_n <= 0;
                        paste_n <= 0;
                    end
                    else begin
                        position <= position;
                        finish_n <= 1;
                        paste_n <= 0;
                    end
                end
            end
        endcase
      end
   end
 
    
endmodule
