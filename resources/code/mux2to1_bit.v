module mux2to1_4bit (
    f,a,b,sel
);
    

output [3:0] f;
input [3:0] a,b;
input sel;

assign f=sel?b:a;


endmodule


module tb_mux2to1_4bit;
wire [3:0] f;
reg [3:0] a,b;
reg sel;
 

mux2to1_4bit DUT(f,a,b,sel);

//behavioural block
initial begin
    $monitor($time  ,"  f=%d , a=%d , b=%d ,sel=%b \n",f,a,b,sel);
    #5 a=1;b=8;sel=0;
    #5 a=2;b=9;sel=1;
    #5 a=3;b=10;sel=0;
    #5 a=4;b=11;sel=1;
    #5 a=5;b=12;sel=0;
    #5 a=6;b=13;sel=1;
    #5 a=7;b=14;sel=0;

    #100 $finish;
end

initial begin
    $dumpfile("mux2to1_4bit.vcd");
    $dumpvars(0,tb_mux2to1_4bit);
end

endmodule
