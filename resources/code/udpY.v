// Write a Verilog module using user-defined primitive to implement the function Y = A.B’.D + B.C.D’ + A.C, where dot (.) indicates AND operation, plus (+) indicates OR operation and X’ indicates complement (NOT) of X, as per the following template:

//      primitive udpY (Y, A, B, C, D);

primitive
    udpY (
    Y,A,B,C,D
);
//port declartions
output Y;
input A,B,C,D;
//

//Y = AB'D + BCD' + AC
  table
  // A B C D : Y
     1 ? 1 ? : 1;
     1 0 0 1 : 1;
     0 1 1 0 : 1;
     0 0 ? ? : 0;
     0 1 0 ? : 0;
     1 1 0 ? : 0;
     0 1 1 1 : 0;
     1 0 0 0 : 0;
  endtable
endprimitive


//test bench for primitive 

module top ;
reg A,B,C,D;
wire Y;
//instantiate lower block
udpY dut(Y,A,B,C,D);

//behaviour block
initial begin
    $dumpfile("udPY.vcd");
    $dumpvars(0,top);
    A=1; B=0; C=0; D=1;
    #5 A=0; B=1; C=1; D=0;
    #5 A=0; B=1; C=0; D=0;
    #5 A=1; B=1; C=1; D=1;
    #5 A=0; B=0; C=1; D=0;
    #5 A=1; B=0; C=1; D=1;
    #5 A=0; B=1; C=0; D=1;

end
    
endmodule

