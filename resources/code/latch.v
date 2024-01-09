`timescale 1ns/1ps

module sr_latch (
    Q,Qbar,S,R
);
output Q,Qbar;
input S,R;

assign Q=~(R & Qbar);
assign Qbar=~(S & Q);

endmodule

/************** test bench *************/
module stimulus;
wire Q,Qbar;
reg S,R;

sr_latch dut( Q,Qbar,S,R);
initial begin
    $dumpfile("latch.vcd");
    $dumpvars(0,stimulus);
end
initial begin
    $monitor($time  ,"  Q=%b , Qbar=%b ,S=%b ,R=%b \n",Q,Qbar,S,R);
    S=0;R=1;
 
    #5 S=1;R=1;
    #5 S=1;R=0;
    #5 S=1;R=1;
    #5 S=0;R=0;
    #5 S=1;R=1;
   #100 $finish; 
end

endmodule
