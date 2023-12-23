

module carry_look_ahead_adder (
    sum,cout,a,b,cin
);
output [3:0] sum;
output cout;

input [3:0] a,b;
input cin;

//internal wires
wire p0,p1,p2,p3,g0,g1,g2,g3;
wire c4,c3,c2,c1;

//computing p for each stages
assign p0=a[0] ^ b[0],
       p1=a[1] ^ b[1],
       p2=a[2] ^ b[2],
       p3=a[3] ^ b[3];

//computing g for each stages
assign g0=a[0] & b[0],
       g1=a[1] & b[1],
       g2=a[2] & b[2],
       g3=a[3] & b[3];


//carry look ahead computations
assign c1=g0 | (p0 & cin),
c2=g1 | (p1 & g0) | (p1 & p0 & cin),
c3=g2 | (p2 & g1) | (p2 & p1 & g0) |(p2 & p1 & p0 & cin ),
c4=g3 | (p3 & g2) | (p3 & p2 & g1) |(p3 & p2 & p1 & g0 ) |(p3 & p2 & p1 & p0 & cin );

//compute sum
assign sum[0]=p0 ^ cin,
       sum[1]=p1 ^ c1,
	   sum[2]=p2 ^ c2,
	   sum[3]=p3 ^ c3;

//cout
assign cout=c4;


endmodule


//test bench

module top;
wire [3:0] sum;
wire cout;

reg [3:0] a,b;
reg cin;

//instantion of design block
carry_look_ahead_adder dut(sum,cout,a,b,cin);

//behavioural block
initial begin
    $dumpfile("carry_look_ahead_adder.vcd");
    $dumpvars(0,top);
    a=4'b0000;b=4'b0000;
    cin=0;
    #5
    a=4'b0001;b=4'b0000;
    cin=0;   
    #5
    a=4'b0000;b=4'b0001;
    cin=0;
    #5
    a=4'b1000;b=4'b1000;
    cin=1;
    #5
    a=4'b1100;b=4'b0011;
    cin=1;
end

always @(a or b or cin) begin
    $display("a=%d,b=%d,cin=%d : sum=%d  cout=%d",a,b,cin,sum,cout);
end

endmodule