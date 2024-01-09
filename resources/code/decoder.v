module decoder (
    out ,in,sel
);
output [1:0] out;
input in,sel;

// assign out[sel]=in;
assign out[0]=sel?0:in;
assign out[1]=sel?in:0;   
endmodule


// test bench
module stimulus ;

wire [1:0] out;
reg in,sel;

decoder dut(out ,in,sel);

initial begin
    $monitor($time  ,"  out=%d , in=%d ,sel=%b \n",out,in,sel);
    #5 in=0;sel=0;
    #10 in=0;sel=1;
    #10 in=1;sel=0;
    #10 in=1;sel=1;
   #100 $finish; 
end

 initial begin
    $dumpfile("decoder.vcd");
    $dumpvars(0,stimulus);
end
 
endmodule