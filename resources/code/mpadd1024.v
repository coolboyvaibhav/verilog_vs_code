`timescale 1ns/1ps
`define TRUE 1'b1
`define FALSE 1'b0
module mpadd1024_parallel (
    CLK,RST_N,a_in,b_in,write,start,s_out, ready
);
input CLK,RST_N;
input [1023:0] a_in,b_in;
input write,start;

output [1024:0] s_out;
output ready;

//registers for storing sum ready and inputs a,b , till next edge
reg [1024:0] sum;
reg [1023:0] a,b;
reg ready;

//assigning sum of register to output wire
assign s_out=sum;//in assignment left side should always be wire

//do changes only in positive edge of clock
always @(posedge CLK) begin
    if (~RST_N) begin//active low reset
        ready <= `FALSE;//not ready 
    end
    else begin
        if (start) begin//only when start of addition is true
            sum <= {1'b0 ,a}+{1'b0,b};
            ready <= `TRUE;
        end
        // addition done now store in reg
        else begin
            if (write) begin
					a <= a_in;
					b <= b_in;                   
            end
            ready <= `FALSE;
        end

    end
end
   
endmodule