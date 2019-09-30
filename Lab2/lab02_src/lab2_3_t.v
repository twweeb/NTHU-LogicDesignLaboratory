`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/30 03:16:04
// Design Name: 
// Module Name: lab2_3_t
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


module lab2_3_t;
	
	reg		clk, rst_n;
	wire	out;
	reg [5:0] num;
	reg		pass;
	lab2_3 shifter (.clk(clk), .rst_n(rst_n), .out(out));
	initial begin
		clk = 0;
		rst_n = 1;
		pass = 1;
		#3
		rst_n = 0;
		#4
		rst_n = 1;
		#4000
        if (pass == 1)
            $display("-------------------------\n     -----[PASS]-----     \n-------------------------");
		$finish;
	end
	
	always begin
		#5	clk = ~clk;
	end
	
	always @ (posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			num[5:0] <= 6'b000001;
		end else begin
			num[5:0] <= {num[4:0],num[5]^num[0]};
		end
	end

	always @ (num or out) begin
		#2	
			if (num[5] !== out) begin
				pass = 0;
				$display("[NOT_PASS_1] : Num : %d, Out : %d", num[5], out);
			end
	end
endmodule
