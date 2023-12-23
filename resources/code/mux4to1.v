

module mux2to1 (
    y,i0,i1,sel
);
output [3:0] y;
input [3:0] i0,i1;
input sel;

assign y=(i0 & (~sel)) | (i1 & (sel))  ;


endmodule

module mux4to1 (
    y,i0,i1,i2,i3,s0,s1
);
output [3:0] y;
input [3:0] i0,i1,i2,i3;
input s0,s1;

//wires
wire [3:0] w1,w2;

//instantiate lower blocks
mux2to1 m1(w1,i0,i1,s0);
mux2to1 m2(w2,i2,i3,s0);
mux2to1 m3(y,w1,w2,s1);

endmodule

//stimulus 
module stimulus;
wire  [3:0] y;
reg [3:0] i0,i1,i2,i3;
reg s0,s1;

//instantiating design module
mux4to1 dut(y,i0,i1,i2,i3,s0,s1);

//behavioural block
initial begin
    $dumpfile("mux4to1.vcd");
    $dumpvars(0,stimulus);
    i0=1;i1=2;i2=2;i3=3;
    s0=0;s1=0;
    #5
    s0=1;s1=0;
    #5
    s0=0;s1=1;
    #5
    s0=1;s1=1;
    #5
    s0=0;s1=0;

end
always @(i0 or i1 or i2 or i3 or s0 or s1) begin
    $display("y=%d : s1=%b :s0=%b\n",y,s1,s0);
end



endmodule