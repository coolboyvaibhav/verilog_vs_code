module adder16alu (
    sign,zero,carry,parity,overflow,out,a,b
);

output sign,zero,carry,parity,overflow;
output [15:0] out;
input [15:0] a,b;

assign {carry,out}=a+b;
assign sign=out[15];//sign bit 
assign parity=~^out;//wheather the numbero f 1's in sum is even or odd--->exnor of sum bits
assign zero=~|out;//weather sum is zero or not ----> nor operation of sum bits
assign overflow=(a[15] & b[15] & ~out[15]) | (~a[15] & ~b[15] & out[15]); // overflow flag condition  

    
endmodule


//test bench 


module top ;


wire sign,zero,carry,parity,overflow;
wire [15:0] out;
reg [15:0] a,b;

//instantiating design module
adder16alu dut( sign,zero,carry,parity,overflow,out,a,b);

//behavioural block
initial begin
    //dump file and variables
    $dumpfile("adder16alu.vcd");
    $dumpvars(0,top);

    //
    a=15;b=16;
    #10
    a=65536;b=2;
    #10
    a=11111;b=0;
    #10
    a=0;b=0;
    #10
    a=0;b=1;
    #10
    a=16'h8fff;b=16'h8000;
    #10
    a=16'hfffe;b=16'h0002;
    #5
    $finish;

end

endmodule