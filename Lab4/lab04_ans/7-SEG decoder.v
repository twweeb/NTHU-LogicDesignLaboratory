module Seven_SEG(
input clk,
input  [3:0] BCD0,BCD1,BCD2,BCD3,
output reg [3:0] DIGIT,
output reg [6:0] DISPLAY
);

wire clk1;    
    clock_divider #(.width(13)) clk_13(.clk(clk),.clk_div(clk1));    
    
reg [3:0] value;
reg [1:0] digit,digit_next;
    
always @(posedge clk1)  begin
    digit <= digit_next;
    case(digit)
        2'b00:    begin
                    value = BCD0;
                    DIGIT = 4'b1110;
                  end
                        
        2'b01:    begin
                    value = BCD1;
                    DIGIT = 4'b1101;
                  end
        2'b10:   begin
                    value = BCD2;
                    DIGIT = 4'b1011;
                  end    
        2'b11: begin
                    value = BCD3;
                    DIGIT = 4'b0111;
                 end         
        endcase                
    end
    
always @* begin
    digit_next = digit +1;
    case(value)
            4'd0: DISPLAY = 7'b0000001;
            4'd1: DISPLAY = 7'b1001111;
            4'd2: DISPLAY = 7'b0010010;
            4'd3: DISPLAY = 7'b0000110;
            4'd4: DISPLAY = 7'b1001100;
            4'd5: DISPLAY = 7'b0100100;
            4'd6: DISPLAY = 7'b0100000;
            4'd7: DISPLAY = 7'b0001111;
            4'd8: DISPLAY = 7'b0000000;
            4'd9: DISPLAY = 7'b0000100;
            default: DISPLAY = 7'b1111111;
  endcase    
end    
    
endmodule
