

module mux2to1 (
    //y,i0,i1,sel
    out,in,sel
);

/*method 1 */
// output  y;
// input  i0,i1;
// input sel;
// assign y=(i0 & (~sel)) | (i1 & (sel))  ;



/*method 2*/
output out;
input [1:0] in;
input sel;
// wires
wire t1,t2,t3;

not g1(t1,sel);//
and g2(t2,in[0],t1);//t2= sel bar and i0
and g3(t3,in[1],sel);//t3=sel and i1
or g4(out,t2,t3);//out =t2 or t3
endmodule

module mux4to1 (
    //y,i0,i1,i2,i3,s0,s1
    out,in,sel
);

/*///method 1
output [3:0] y;
input [3:0] i0,i1,i2,i3;
input s0,s1;

//wires
wire [3:0] w1,w2;

//instantiate lower blocks
mux2to1 m1(w1,i0,i1,s0);
mux2to1 m2(w2,i2,i3,s0);
mux2to1 m3(y,w1,w2,s1);
*/

//method 2
output out;
input [3:0] in;
input [1:0] sel;
wire [1:0] t;

mux2to1 m0(t[0],in[1:0],sel[0]);
mux2to1 m1(t[1],in[3:2],sel[0]);
mux2to1 m2(out,t,sel[1]);




endmodule

//stimulus 
module stimulus;

/*
wire   y;
reg  i0,i1,i2,i3;
reg s0,s1;
*/


wire out;
reg [3:0] in ;
reg [1:0] sel;


//instantiating design module
    //method 1
// mux4to1 dut(y,i0,i1,i2,i3,s0,s1);

//method 2
mux4to1 dut(out,in,sel);

//behavioural block
initial begin
    $dumpfile("mux4to1.vcd");
    $dumpvars(0,stimulus);
    in=4'b1010;
    sel=2'b00;
    #5
    sel=2'b01;
    #5
    sel=2'b10;
    #5
    sel=2'b11;
    #5
    sel=2'b00;

end
always @(in or sel) begin
    $display("out=%b :sel=%b\n",out,sel);
end



endmodule