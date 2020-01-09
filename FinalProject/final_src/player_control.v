module player_control (
	input clk,
	input reset,
	input _play,
	input _repeat,
	output reg [11:0] ibeat
);
	parameter LEN = 4095;
    reg [11:0] next_ibeat;
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			ibeat <= 0;
		end
		else begin
            ibeat <= next_ibeat;
		end
	end

    always @* begin
        next_ibeat = (_play) ? (ibeat + 1 < LEN) ? (ibeat + 1) : (_repeat) ? 12'd0 : 12'd511 : ibeat;// : 12'd0;
    end

endmodule