module counter (out, CLK, RST_N);
 output [7:0] out;
 input CLK, RST_N;
 reg [7:0] out;
 wire CLK, RST_N;
 always @(posedge CLK) begin
 if (!RST_N) begin
 out <= 0;
 end
 else begin
 out <= out + 1;
 end
 end
endmodule


`timescale 1ns/1ps
module counter_tb;
 reg test_clk, test_rstn;
 wire [7:0] count_val;
 counter u_DUT (.out(count_val), .CLK(test_clk), 
.RST_N(test_rstn));
 initial begin
 test_clk = 0;
 test_rstn = 1;
 #5 test_rstn = 0;
 #15 test_rstn = 1;
 #5000 $finish;
 end
 always begin
 #5 test_clk = ~test_clk;
 end
 initial begin
 $dumpfile("counter_tb.vcd");
 $dumpvars(0, u_DUT);
 $monitor("Time: %t :: Count: %x", $time, count_val);
 end
endmodule
