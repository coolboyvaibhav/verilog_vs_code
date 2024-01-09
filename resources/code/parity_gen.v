

module parity_gen (
    z,x,clk
);
output reg z;
input clk,x;

reg even_odd;
parameter EVEN=0,ODD=1;

always @(posedge clk ) begin
    case (even_odd)

        EVEN:begin
            z<=x?1:0;
            even_odd<=x?ODD:EVEN;
        end 
        ODD: begin
            z<=x?0:1;
            even_odd<=x?EVEN:ODD;
        end
        default:begin
            even_odd<=EVEN;
        end
    endcase
    
end
    
endmodule


module stimulus;
wire z;
reg clk,x;

parameter time_period=10;

parity_gen dut( z,x,clk);

initial begin
    #10 x=0;#10 x=1;#10 x=1;#10 x=1;

    #100 $finish;
end

initial begin
    $dumpfile("parity_gen.vcd");
    $dumpvars(0,stimulus);
    $monitor($time ," z=%b, x=%b",z,x);
    clk=1'b0;

end

always #(time_period/2) clk=~clk;



endmodule