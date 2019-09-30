`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/28 23:30:58
// Design Name: 
// Module Name: lab2_1_t
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


module lab2_1_t;

	reg		clk, rst_n, en, dir, in;
	reg	[3:0] data;
	wire [3:0] out;
	reg		pass;
    reg [3:0] o;
	lab2_1 counter (.clk(clk), .rst_n(rst_n), .en(en), .dir(dir), .in(in), .data(data), .out(out));
	integer num, seed;
	initial begin
		seed = 0;
		clk = 0;
		rst_n = 1;
		en = 0;
		dir = 1;
		in = 0;
		data[3:0] = 4'b0;
		pass = 1;
		#3
		rst_n = 0;
		#4
		rst_n = 1;
		#20
		en = 1;
		#3000
		dir = 0;
		#3000
		dir = 1;
		#10
        if (pass == 1)
            $display("-------------------------\n     -----[PASS]-----     \n-------------------------");
		$finish;
	end
	
	always begin
		#5	clk = ~clk;
	end
	
	always begin
		#80	
			in = 1'b1;
			data <= $random(seed);
		#10	
			in = 1'b0;
	end
	
	always begin
		#100	
			en = 1'b0;
		#30	
			en = 1'b1;
	end
	
	always @ (posedge clk or posedge rst_n) begin
		if (!rst_n) begin
			num <= 0;
		end else begin
			if (en == 1'b1 && in == 1'b0 && dir == 1'b1) begin
				num <= (num == 15) ? 4'b0 : num + 4'b1;
			end else if (en == 1'b1 && in == 1'b0 && dir == 1'b0)begin
				num <= (num == 0) ? 4'b1111 : num - 4'b1;
			end else if (en == 1'b1 && in == 1'b1) begin
				num <= data;
			end
		end
	end
	
	always@(*)begin
        o = num;
    end
	
	always @ (out or o) begin
		#2
		    if(en==1)	
			if (out !== o) begin
				pass = 0;
				$display("[NOT_PASS_1] : OUT : %d, num : %d", out[3:0], num);
			end 
			/*else begin
				$display("[PASS_1] : OUT : %d, num : %d", out[3:0], num);
			end*/
	end
endmodule
