`timescale 1ns/100ps

module lab1_1_t;

  reg a, b, c;
  wire d, e;
  reg [1:0] aluctr;
  reg pass;
 
  lab1_1 alu(
    .e(e),
    .d(d),
    .a(a),
    .b(b),
    .c(c),
    .aluctr(aluctr)
  );
            
  initial begin
  // ---- addition with c
    #5  aluctr = 2'b00; a = 1'b0; b = 1'b0; c = 1'b0; pass = 1'b1;
    #5;
    if (d!==1'b0 || e!==1'b0) begin
      printerror;
    end
    
    #5  aluctr = 2'b00; a = 1'b0; b = 1'b1; c = 1'b0;
    #5;
    if (d!==1'b1 || e!==1'b0) begin
      printerror;
    end    
    
    #5  aluctr = 2'b00; a = 1'b1; b = 1'b0; c = 1'b0;
    #5;
    if (d!==1'b1 || e!==1'b0) begin
      printerror;
    end    
    
    #5 aluctr = 2'b00; a = 1'b1; b = 1'b1; c = 1'b0;
    #5;
    if (d!==1'b0 || e!==1'b1) begin
      printerror;
    end
  // ---- addition with c
    #5  aluctr = 2'b00; a = 1'b0; b = 1'b0; c = 1'b1;
    #5;
    if (d!==1'b1 || e!==1'b0)
    begin
      printerror;
    end
    
    #5 aluctr = 2'b00; a = 1'b0; b = 1'b1; c = 1'b1;
    #5;
    if (d!==1'b0 || e!==1'b1) begin
      printerror;
    end    
    
    #5  aluctr = 2'b00; a = 1'b1; b = 1'b0; c = 1'b1;
    #5;
    if (d!==1'b0 || e!==1'b1) begin
      printerror;
    end    
    
    #5  aluctr = 2'b00; a = 1'b1; b = 1'b1; c = 1'b1;
    #5;
    if (d!==1'b1 || e!==1'b1) begin
      printerror;
    end
    // ---- and
    #5  aluctr = 2'b01; a = 1'b0; b = 1'b0; c = 1'bx;
    #5;
    if (d!==1'b0 || e!==1'b0) begin
      printerror;
    end
    
    #5  aluctr = 2'b01; a = 1'b0; b = 1'b1; c = 1'bx;
    #5;
    if (d!==1'b0 || e!==1'b0) begin
      printerror;
    end    
    
    #5  aluctr = 2'b01; a = 1'b1; b = 1'b0; c = 1'bx;
    #5;
    if (d!==1'b0 || e!==1'b0) begin
      printerror;
    end    
    
    #5  aluctr = 2'b01; a = 1'b1; b = 1'b1; c = 1'bx;
    #5;
    if(d!==1'b1 || e!==1'b0) begin
      printerror;
    end
    // ---- nor
    #5  aluctr = 2'b10; a = 1'b0; b = 1'b0; c = 1'bx;
    #5;
    if (d!==1'b1 || e!==1'b0) begin
      printerror;
    end
    
    #5  aluctr = 2'b10; a = 1'b0; b = 1'b1; c = 1'bx;
    #5;
    if (d!==1'b0 || e!==1'b0) begin
      printerror;
    end    
    
    #5  aluctr = 2'b10; a = 1'b1; b = 1'b0; c = 1'bx;
    #5;
    if (d!==1'b0 || e!==1'b0) begin
      printerror;
    end    
    
    #5  aluctr = 2'b10; a = 1'b1; b = 1'b1; c = 1'bx;
    #5;
    if (d!==1'b0 || e!==1'b0) begin
      printerror;
    end
    // ---- xor
    #5  aluctr = 2'b11; a = 1'b0; b = 1'b0; c = 1'bx;
    #5;
    if (d!==1'b0 || e!==1'b0) begin
      printerror;
    end
    
    #5  aluctr = 2'b11; a = 1'b0; b = 1'b1; c = 1'bx;
    #5;
    if (d!==1'b1 || e!==1'b0) begin
      printerror;
    end    
    
    #5  aluctr = 2'b11; a = 1'b1; b = 1'b0; c = 1'bx;
    #5;
    if (d!==1'b1 || e!==1'b0) begin
      printerror;
    end    
    
    #5  aluctr = 2'b11; a = 1'b1; b = 1'b1; c = 1'bx;
    #5;
    if (d!==1'b0 || e!==1'b0) begin
      printerror;
    end
    // ---- finish
    #5;
    if (pass===1'b1)
      $display(">>>> [PASS] Congratulations!");
    else
      $display(">>>> [ERROR] Try it again!");

    $finish;
  end

  task printerror;
    begin
      pass = 1'b0;
      $display($time," Error: aluctr = %b, a = %b, b = %b, c = %b, d = %b, e = %b",
        aluctr, a, b, c, d, e);
    end
  endtask
endmodule
