module lab2_2(clk, rst_n, en, dir, gray, cout); 
	input clk, rst_n, en, dir; 
	output [7:0] gray;
	output cout;
	
    wire c1, c2;
	
	GRAY2 b1(clk, rst_n, en, dir, gray[3:0], c1);
    GRAY2 b2(clk, rst_n, c1, dir, gray[7:4], c2);
	and a1(cout, c1, c2);
	
endmodule


module GRAY(in, en, dir, gray, cout);
	input en, dir;
	input [3:0]in;
	output wire [3:0]gray;
	output cout;
	
	wire [3:0]Din;
	reg [3:0]Dout;
	reg cout;
	
	change_b c1(in, Din);
    
	always@(*)begin
        Dout = 4'b0000;
        if (en == 1'b0)
            Dout = Din;
        else if (en == 1'b1) begin
            if (dir == 1'b1) begin
                if (Din < 4'b1111)
                    Dout = Din+4'b0001;
            end else begin
                if (Din > 4'b0000)
                    Dout = Din-4'b0001;
                else if (Din == 4'b0000)
                    Dout = 4'b1111;
            end
        end
    end
	
	always@(*)begin
       cout = 1'b0;
       if (en == 1'b1)begin
           if (dir == 1'b1 && Din == 4'b1111)
               cout = 1'b1;
           else if (dir == 1'b0 && Din == 4'b0000)
               cout = 1'b1;
       end
    end
    
    change_g c2(Dout, gray);
    
endmodule

module GRAY2(clk, rst_n, en, dir, gray, cout);
    	input  clk,rst_n ,en,dir;
        output reg [3:0]gray;
        output cout;
        wire     [3:0] out;

        GRAY g0(gray, en, dir, out, cout);

        always @(negedge rst_n or negedge clk) begin
            if (!rst_n) begin
                gray <= 4'b0;
            end else begin
                gray <= out;
            end    
        end
		
endmodule

module change_g(in, out);
    input [3:0]in;
    output reg [3:0]out;
	
    always@(*)begin
        case(in)
            4,5,6,7,8,9,10,11: out[2] = 1'b1 ;
            default: out[2] = 1'b0 ;     
        endcase
        case(in)     
            2,3,4,5,10,11,12,13: out[1] = 1'b1;
            default: out[1] = 1'b0;
        endcase
        case(in)
            1,2,5,6,9,10,13,14 : out[0] = 1'b1;
            default: out[0] = 1'b0;
        endcase
        out[3] = in[3];
    end
	
endmodule

module change_b(in, out);
    input [3:0]in;
    output [3:0]out;
	
    wire t1, t2, t3;
	
    assign out[3]=in[3];
    xor x1(t1, out[3], in[2]);
    assign out[2]=t1;
    xor x2(t2, out[2], in[1]);
    assign out[1]=t2;
    xor x3(t3, out[1], in[0]);
    assign out[0]=t3;
	
endmodule    