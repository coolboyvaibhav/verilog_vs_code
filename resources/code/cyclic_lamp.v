
/*

*/

//1st method
module cyclic_lamp (
    light,clk
);
output reg [2:0] light;
input clk;

parameter s0=0,s1=1,s2=2 ;
parameter RED =3'b001,GREEN=3'b010,YELLOW=3'b100;

reg [0:1] state;

always @(posedge clk ) begin
    case (state)
        s0:begin////       in red state
            light<=GREEN;
            state<=s1;
        end 
        s1:begin
            light<=YELLOW;
            state<=s2;
        end
        s2:begin
            light<=RED;
            state<=s0;
        end
        default:begin
            light<=RED;
            state<=s0;
        end
    endcase
end
    
endmodule

//*  second method*/

module cyclic_lamp (
    light,clk
);
output reg [2:0] light;
input clk;

parameter s0=0,s1=1,s2=2 ;
parameter RED =3'b001,GREEN=3'b010,YELLOW=3'b100;

reg [0:1] state;

always @(posedge clk ) begin
    case (state)
        s0:begin////       in red state
            
            state<=s1;
        end 
        s1:begin
            
            state<=s2;
        end
        s2:begin
            
            state<=s0;
        end
        default:begin
            state<=s0;
        end
    endcase
end

always @(state) begin
    case (state)
        s0:light<=GREEN;
        s1:light<=YELLOW;
        s2:light<=RED; 
        default:light<=RED;  
    endcase
    
end
    
endmodule




///test bench

module tb_cyclic_lamp;

wire [2:0] light;
reg clk;

parameter time_period=10;
cyclic_lamp dut(light,clk);

always #(time_period/2) clk=~clk;

initial begin
    clk=0;
    #100 $finish;
end

initial begin
    $dumpfile("cyclic_lamp.vcd");
    $dumpvars(0,tb_cyclic_lamp);
    $monitor($time ," RGY=%b",light);
end

endmodule
