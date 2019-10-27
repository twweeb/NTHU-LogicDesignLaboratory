`timescale 1ns / 1ps

module onepulse(
input wire rst,
input wire clk,
input wire pb_debounced,
output reg pb_1pulse);
	reg pb_1pulse_next;
	reg pb_debounced_delay;

	always@* begin
		pb_1pulse_next = pb_debounced & ~pb_debounced_delay;
	end

	always @(posedge clk, posedge rst) begin
		if(rst == 1'b1) begin
			pb_1pulse <= 1'b0;
			pb_debounced_delay <= 1'b0;
		end
		else begin
			pb_1pulse <= pb_1pulse_next;
			pb_debounced_delay <= pb_debounced;
		end 
	end
endmodule
