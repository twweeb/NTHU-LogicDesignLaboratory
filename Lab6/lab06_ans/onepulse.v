module OnePulse (signal_single_pulse, clock, signal);
  input signal;
  input clock;
  output signal_single_pulse;
  reg signal_single_pulse;
  reg PB_debounced_delay;
    
  always @(posedge clock)
  begin
    if (signal == 1'b1 & PB_debounced_delay == 1'b0)
      signal_single_pulse <= 1'b1;
    else
      signal_single_pulse <= 1'b0;

    PB_debounced_delay <= signal;
  end
endmodule
