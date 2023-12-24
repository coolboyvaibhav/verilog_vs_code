module full_adder (
    sum,carry,a,b,cin
);
output sum;
output carry;
input a,b,cin;
//wires
wire w1,w2,w3;
//gate level 
xor x1(w1,a,b);
xor x2(sum,w1,cin);
and a1(w2,w1,cin);
and a2(w3,a,b);
or o1(carry,w2,w3);

    
endmodule

module ripple_adder_4bit (
    sum,cout,A,B,cin
);

output [3:0] sum;
output cout;
input [3:0] A,B;
input cin;

//wire declartions
wire [2:0] c;

//instantiating lower modules
full_adder fa1(sum[0],c[0],A[0],B[0],cin);
full_adder fa2(sum[1],c[1],A[1],B[1],c[0]);
full_adder fa3(sum[2],c[2],A[2],B[2],c[1]);
full_adder fa4(sum[3],cout,A[3],B[3],c[2]);

    
endmodule

//stimulus module
module stimulus;

reg [3:0] A,B;    
reg cin;

wire [3:0] sum;
wire cout;


//instantiating design module
ripple_adder_4bit ra(sum,cout,A,B,cin);

//behavioural block
initial begin
    $dumpfile("ripple_adder_4bit.vcd");
    $dumpvars(0,stimulus);

        A=0; B=4; cin=0;
        #5
        A=0; B=2; cin=1;
        #5
        A=5; B=1; cin=0;
        #5
        A=0; B=4; cin=0;
        #5
        A=7; B=7; cin=0;
        #5
        A=5; B=5; cin=1;
        #5
        A=7; B=0; cin=0;


end
always @(A or B or cin) begin
      $display("the value of A=%d : B=%d  :cin =%d and the sum=%d",A,B,cin,sum);
end

endmodule