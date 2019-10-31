module clock_divider (clk_div, clk);
input clk;
output clk_div;

parameter width = 25;
reg  [width-1:0] num;
wire [width-1:0] next_num;

always @(posedge clk) begin  
    num <= next_num;
end

assign  next_num = num + 1;
assign  clk_div = num[width-1];  
     
endmodule
