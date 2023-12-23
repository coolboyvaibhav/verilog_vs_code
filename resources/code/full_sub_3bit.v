// Write a Verilog module to implement a 3-bit subtractor by instantiating  half_sub module (defined in Week2: Programming Assignment 1) as many times as required. Other primitive gates may be used if required. The module will take the following arguments:
// Two 3-bit inputs A and B,
// An 1-bit borrow input BI,
// A 3-bit subtraction output Sub,
// An 1-bit borrow output BO
// module full_sub_3bit (Sub, BO, A, B, BI);

// Hint: For inputs Input1, Input2, and borrow input BI, the design of a1-bit full subtractor  using binary half subtractor is

// half_sub m1 (Diff1, Bout1, Input1, Input 2);

// half_sub m2 (Sub, Bout2, Diff1, BI);

// or  m3 (BO, Bout1, Bout2);

// `include "half_subtractor.v"


module half_sub (
    Diff, Bout, X, Y
);
output Diff;
output Bout;
input X,Y;


//method 1 gate level modelling 
// xor x1(Diff,X,Y);
// and a1(Bout,~X,Y);
//method 2 behavioural modelling
assign Diff = X ^ Y;
assign Bout = (~X) & Y;

endmodule


module full_sub(Diff,Bout,A,B,Bin);
//port declaritions
output Diff,Bout;
input A,B,Bin;
//wires
wire Diff1,Bout1,Bout2;

//instantiating half subtractor modules
half_sub hf1(Diff1,Bout1,A,B);
half_sub hf2(Diff,Bout2,Diff1,Bin);
or o1(Bout,Bout1,Bout2);


endmodule


module full_sub_3bit (
    sub,BO,A,B,BI
);
//port decalrations
output [2:0] sub;
output BO;
input [2:0] A,B;
input BI;

// wires
wire B0,B1,B2;
//implementing using lower modules
//instantiating lower modules
full_sub FS1(sub[0],B0,A[0],B[0],BI);
full_sub FS2(sub[1],B1,A[1],B[2],B0);
full_sub FS3(sub[2],B2,A[2],B[2],B1);

assign BO=B2;
    
endmodule

module top ;
    //declaring input of design as reg
    reg [2:0] A,B;
    reg BI;
    //declaring output as wire
    wire [2:0] sub;
    wire BO;

    //instantiating design module
    full_sub_3bit dut(.sub(sub),.BO(BO),.A(A),.B(B),.BI(BI));

    //behavioural blocks
    initial begin
        $dumpfile("full_sub_3bit.vcd");
        $dumpvars(0,top);
        A=0; B=4; BI=0;
        #5
        A=0; B=2; BI=1;
        #5
        A=5; B=1; BI=0;
        #5
        A=0; B=4; BI=0;
        #5
        A=7; B=7; BI=0;
        #5
        A=5; B=5; BI=1;
        #5
        A=7; B=0; BI=0;
        



    end




endmodule