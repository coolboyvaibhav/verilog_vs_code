`include "half_adder.v"

module tb_half_adder;

reg A,B;
wire SUM,CARRY;

//instantiation of lower module
half_adder hf(.sum(SUM),.carry(CARRY),.a(A),.b(B));
initial begin
    $dumpfile("half_adder.vcd");
    $dumpvars(0,tb_half_adder);


    A=0;B=0;
    #5
    A=0;B=1;
    #5
    A=1;B=0;
    #5
    A=1;B=1;
    #5
    A=0;B=0;

end

endmodule