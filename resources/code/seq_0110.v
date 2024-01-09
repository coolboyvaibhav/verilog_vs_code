module seq_0110 (
    z,x,clk,reset
);

output reg z;
input x,clk,reset;

//states as 4 digits to be recurring so four states require
parameter s0=0,s1=1,s2=2,s3=3;

reg [0:1] PS,NS;
always @(posedge clk or posedge reset) begin
    if (reset) PS<=s0;
    else PS<=NS;
end

always @(PS or x) begin
    case (PS)
        s0:begin
            z<=x?0:0;
            NS<=x?s0:s1;
        end
        s1:begin
            z<=x?0:0;
            NS<=x?s2:s1;
        end
        s2:begin
            z<=x?0:0;
            NS<=x?s3:s1;
        end
        s3:begin
            z<=x?0:1;
            NS<=x?s0:s1;
        end 
        
    endcase
end

endmodule

module stimulus;

wire z;
reg x,clk,reset;
parameter time_period=10;


seq_0110 dut( z,x,clk,reset);


initial begin
    #12 x=0;#10 x=0;#10 x=1;#10 x=1;
    #10 x=0;#10 x=1;#10 x=1;#10 x=0;

    #100 $finish;
end

always #(time_period/2) clk=~clk;
initial begin
    $dumpfile("seq_0110.vcd");
    $dumpvars(0,stimulus);
    $monitor($time ," z=%b, x=%b",z,x);
    clk=1'b0;

end
endmodule