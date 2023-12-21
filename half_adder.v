
module half_adder (
    sum,carry,a,b
);
output sum;
output carry;
input a,b;
xor x1(sum,a,b);
and a1(carry,a,b);

    
endmodule