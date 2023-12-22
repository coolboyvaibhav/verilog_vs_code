// Write a Verilog module to design a half-subtractor at the behavioral level. The module will take the following arguments:

// Two 1-bit inputs X and Y,
// An 1-bit subtraction output Diff,
// An 1-bit borrow output Bout
// module half_sub(Diff, Bout, X, Y);

// Hint: The  Boolean expression for binary half subtractor is 

// Diff = X  XOR Y  and Bout = X' AND Y

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