`timescale 1ns/100ps

module lab1_4_t;

  reg  [3:0] a, b;
  reg  [1:0] aluctr;
  reg  c;
  wire [3:0] d;
  wire e;
  reg  pass;
    
  lab1_4 ALU(
    .a(a),
    .b(b),
    .c(c),
    .aluctr(aluctr),
    .d(d),
    .e(e));
   
  initial begin
    #0      pass = 1'b1; a = 4'b0000; b = 4'b0000; c = 1'b0; aluctr = 2'b00;
    $display("Starting simulation");
    //$monitor("%g\taluctr=%b\ta=%b\tb=%b\tc=%b\td=%b\te=%b",$time, aluctr, a, b, c, d, e);
    #2048   c = 1'b1;
    #2560   $display("%g Terminating simulation...", $time);
    if(pass)    $display(">>>> [PASS] Congratulations!");
    else        $display(">>>> [ERROR] Try it again!");
    $finish;
  end
        
  always #512 aluctr = aluctr + 1;
  always #32  a = a + 1;
  always #2   b = b + 1;
    
  always @(*) begin
    #1
    if ( aluctr == 2'b00 ) begin
      if ( (a+b+c) !== {e,d} )
        printerror;
    end else if( aluctr == 2'b01 ) begin
      if( ( (a&b) !== d ) || ( e !== 0 ) )
        printerror;
    end else if( aluctr == 2'b10 ) begin
      if( ( (~a & ~b) !== d ) || ( e !== 0 ) )
        printerror;
    end else if( aluctr == 2'b11 ) begin
      if( ( (a^b) !== d ) || ( e !== 0 ) )
        printerror;
    end
  end
    
  task printerror;
    begin
      pass = 1'b0;
      $display("  Error:\taluctr=%b\ta=%b\tb=%b\tc=%b\td=%b\te=%b", aluctr, a, b, c, d, e);
    end
  endtask
    
endmodule
