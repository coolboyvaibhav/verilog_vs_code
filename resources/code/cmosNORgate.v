module my_nor (
    output out,
    input a,
    input b
);

// cmos(output,input,control)

//internal wires
wire c;

supply1 vdd;
supply0 gnd;

nmos (out,gnd,a);
nmos (out,gnd,b);

pmos (c,vdd,a);
pmos (out,c,b);


    
endmodule



module stimulus;
wire out;
reg a,b;

my_nor DUT(out,a,b);


initial begin
    $monitor($time ," out=%d , a=%d , b=%d \n",out,a,b);
    #5 a=0;b=0;
    #5 a=0;b=1;
    #5 a=1;b=0;
    #5 a=1;b=1;
    #100 $finish;

end

initial begin
    $dumpfile("cmosNORgate.vcd");
    $dumpvars(0,stimulus);
end

 
endmodule