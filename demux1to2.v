// Write a Verilog module to implement a 1-to-2 demultiplexer by using gate level structural description. The module will take as arguments the following:
// 1-bit data input “in”,
// 1-bit select line “sel”
// 2-bit output “out”
// module demux1to2 (out, in, sel);
//   input in, sel;
//   output [1:0] out;

module demux1to2 (
    out,in,sel
);
//port declartions
output [1:0] out;
input in,sel;

//gate level implementations

and a1(out[0],~sel,in);
and a2(out[1],sel,in);

    
endmodule

//stimulus for this

module stimulus ;
//declaring input of design as reg
reg in,sel;
//declaring output of design as wire
wire [1:0] out;

//instantiating design module
 demux1to2 dut(out,in,sel);

 //behavioural block

 initial begin
    $dumpfile("demux1to2.vcd");
    $dumpvars(0,stimulus);
    in=1;sel=0;
    #5 in=1;sel=1;
    #5 in=1;sel=1;
    #5 in=0;sel=0;
    #5 in=0;sel=1;
 end
    
endmodule