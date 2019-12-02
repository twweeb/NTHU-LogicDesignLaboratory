module note_gen(
    clk, // clock from crystal
    rst, // active high reset
    note_div_left, // div for note generation
    note_div_right,
    audio_left,
    audio_right,
    volume
);

    // I/O declaration
    input clk; // clock from crystal
    input rst; // active low reset
    input [21:0] note_div_left, note_div_right; // div for note generation
    output [15:0] audio_left, audio_right;
    input [2:0] volume;

    // Declare internal signals
    reg [21:0] clk_cnt_next, clk_cnt;
    reg [21:0] clk_cnt_next_2, clk_cnt_2;
    reg b_clk, b_clk_next;
    reg c_clk, c_clk_next;
    reg [15:0] ampH, ampL;

    // Note frequency generation
    always @(posedge clk or posedge rst)
        if (rst == 1'b1)
            begin
                clk_cnt <= 22'd0;
                clk_cnt_2 <= 22'd0;
                b_clk <= 1'b0;
                c_clk <= 1'b0;
            end
        else
            begin
                clk_cnt <= clk_cnt_next;
                clk_cnt_2 <= clk_cnt_next_2;
                b_clk <= b_clk_next;
                c_clk <= c_clk_next;
            end
        
    always @*
        if (clk_cnt == note_div_left)
            begin
                clk_cnt_next = 22'd0;
                b_clk_next = ~b_clk;
            end
        else
            begin
                clk_cnt_next = clk_cnt + 1'b1;
                b_clk_next = b_clk;
            end

    always @*
        if (clk_cnt_2 == note_div_right)
            begin
                clk_cnt_next_2 = 22'd0;
                c_clk_next = ~c_clk;
            end
        else
            begin
                clk_cnt_next_2 = clk_cnt_2 + 1'b1;
                c_clk_next = c_clk;
            end
    always @*
        case(volume)
            1: begin
                ampH <= 16'h0040;
                ampL <= 16'hFFC0;
            end
            2: begin
                ampH <= 16'h00A0;
                ampL <= 16'hFF60;
            end
            3: begin
                ampH <= 16'h0A00;
                ampL <= 16'hF600;
            end
            4: begin
                ampH <= 16'h4000;
                ampL <= 16'hC000;
            end
            5: begin
                ampH <= 16'h7000;
                ampL <= 16'h9000;
            end
            default: begin
                ampH <= 16'h00C0;
                ampL <= 16'hFFC0;
            end
        endcase
        
    // Assign the amplitude of the note
    // Volume is controlled here
    assign audio_left = (note_div_left == 22'd1) ? 16'h0000 : (b_clk == 1'b0) ? ampL : ampH;
    assign audio_right = (note_div_right == 22'd1) ? 16'h0000 : (c_clk == 1'b0) ? ampL : ampH;
endmodule