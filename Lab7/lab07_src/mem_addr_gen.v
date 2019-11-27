//Lab 07_2
`define INIT 2'b00
`define SHIF 2'b01
`define SPLI 2'b10

module mem_addr_gen1(
   input clk,
   input rst,
   input dir,
   input en,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   output [16:0] pixel_addr
   );
    
   reg [8:0] position;
  
   assign pixel_addr = (((h_cnt >> 1) + position) % 320 + 320 * (v_cnt >> 1));

   always @ (posedge clk, posedge rst) begin
       if(rst)
         position <= 0;
       else if(en == 1)
         if(dir == 0)
           if(position < 319)
             position <= position + 1;
           else
             position <= 0;
         else
           if(position > 0)
             position <= position - 1;
           else 
             position <= 319;
       else 
         position <= position;
   end
    
endmodule

module mem_addr_gen2(
   input clk,
   input rst,
   input shift,
   input split,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   output [16:0] pixel_addr,
   output wire valid
   );
    
    reg [9:0] position, next_position;
    reg [16:0] pixel;
    reg [1:0] state, next_state, count, next_count;
    reg next_valid, done, next_done;
    integer target, next_target,
            top_left, next_top_left, bottom_right, next_bottom_right, top_right, next_top_right, bottom_left, next_bottom_left;
    
	assign pixel_addr = pixel;
    assign valid = next_valid;
    
    always @ (posedge clk, posedge rst) begin
		if(rst == 1) begin
            state <= `INIT;
            target <= 319;
            position <= 10'b00000_00000;
            top_left <= 119;
            bottom_left <= 159;
            bottom_right <= 120;
            top_right <= 160;
            count <= 2'b00;
		    done <= 0;
		end
		else begin
            state <= next_state;
            target <= next_target;
            position <= next_position;
            top_left <= next_top_left;
            bottom_left <= next_bottom_left;
            bottom_right <= next_bottom_right;
            top_right <= next_top_right;
            count <= next_count;
		    done <= next_done;
		end
	end
	
    always @ (*) begin
		case(state) 
			`INIT: begin
                next_valid = 1;
                next_target = 319;
                next_position = 10'b00000_00000;
                next_top_left = 119;
                next_bottom_left = 159;
                next_bottom_right = 120;
                next_top_right = 160;
                next_count = 2'b00;
		        next_done = 0;
                pixel = ((h_cnt >> 1) + 320 * (v_cnt >> 1)) % 76800;
			    next_state = (shift) ? `SHIF : (split) ? `SPLI : state;
			end
			`SHIF: begin
                pixel = ((h_cnt >> 1) + 320 * (v_cnt >> 1)) % 76800;
                next_position = position;
                next_top_left = top_left;
                next_bottom_left = bottom_left;
                next_bottom_right = bottom_right;
                next_top_right = top_right;
                next_count = count;
			    // Disappear from Right to Left
                if(count == 2'b00) begin
                    if((h_cnt >> 1) >= target) next_valid = 1'b0;
                    else next_valid = 1'b1;
					
                    if(target > 0) begin 
			    	    next_target = target - 1;
			    		next_count = count;
                    end
			    	else begin
                        next_count = 2'b01;
                        next_target = 0;
                    end
					next_done = done;
                end
			    
			    // Appear from Up to Down
			    else if(count == 2'b01) begin
                    if((v_cnt >> 1) <= target) next_valid = 1'b1;
                    else next_valid = 1'b0;
					
                    if(target <= 239) begin 
					    next_target = target + 1;
						next_done = done;
			    		next_count = count;
				    end
                    else begin
                        next_count = 2'b10;
                        next_target = target;
                        next_done = 1'b1;
                    end
                end
				
				else begin 
                    next_target = target;
                    next_count = count;
					next_done = done;
				end
			    next_state = (done) ? `INIT : state;
			end
			`SPLI: begin
                next_count = count;
                next_position = position + 1;
			    // Update each part until they all disappear
                if(top_left > 0) next_top_left = top_left - 1;
			    else begin
                    next_top_left = top_left;
                    next_count = count + 1;
                end
                
                if(bottom_left > 0) next_bottom_left = bottom_left - 1;
                else begin
                    next_bottom_left = bottom_left;
                    next_count = count + 1;
                end
			    
                if(bottom_right < 239) next_bottom_right = bottom_right + 1;
                else begin
                    next_bottom_right = bottom_right;
                    next_count = count + 1;
                end
			    
                if(top_right < 319) begin 
				    next_top_right = top_right + 1;
					next_done = done;
				end
                else begin
                    next_top_right = top_right;
                    next_count = count + 1;
                    next_done = 1'b1;
                end
				
			    // Top Left
                if((h_cnt >> 1) <= 159 && (v_cnt >> 1) <= 119) begin
                    if((v_cnt >> 1) >= top_left) next_valid = 1'b0;
                    else begin
                        next_valid = 1'b1;
                        pixel = ((h_cnt >> 1) + 320 * ((v_cnt >> 1) + position)) % 76800;
                    end
                end
			    
			    // Bottom Left
			    else if((h_cnt >> 1) <= 159 && (v_cnt >> 1) <= 239) begin
                    if((h_cnt >> 1) >= bottom_left) next_valid = 1'b0;
                    else begin
                        next_valid = 1'b1;
                        pixel = (((h_cnt >> 1) + position) + 320 * (v_cnt >> 1)) % 76800;
                    end
                end
			    
			    // Top Right
                else if((h_cnt >> 1) <= 319 && (v_cnt >> 1) <= 119) begin
                    if((h_cnt >> 1) <= top_right + 1) next_valid = 1'b0;
                    else begin
                        next_valid = 1'b1;
                        pixel = (((h_cnt >> 1) - position) + 320 * (v_cnt >> 1)) % 76800;
                    end
                end
			    
			    // Bottom Right
                else if((h_cnt >> 1) <= 319 && (v_cnt >> 1) <= 239) begin
                    if((v_cnt >> 1) <= bottom_right) next_valid = 1'b0;
                    else begin
                        next_valid = 1'b1;
                        pixel = ((h_cnt >> 1) + 320 * ((v_cnt >> 1) - position)) % 76800;
                    end
			    end
			    next_state = (done) ? `INIT : state;
			end
			default: begin
			    next_state = `INIT;
			end
        endcase
    end
endmodule
