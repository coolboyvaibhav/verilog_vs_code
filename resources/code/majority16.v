// Write a Verilog module to implement a 16-bit majority function using behavioral description. The module will take as input a 16-bit data, Data and provide a single-bit output, Out, indicating the logic state of the most number of input bits, i.e. if at least 9 out of 16 input signals are at logic 1, the logic state of Out will be 1; otherwise Out will remain at  logic 0. The template of the function will be as follows :

//        module majority16 (Out, Data);

// Hint: May use Verilog loop constructs for the design.

module majority16 (
    Out, Data
);
output Out;
input [0:15] Data;

//to count the 1s 
  reg [0:4] count;
  integer i;

//if count >8 ,Out =1;
assign Out = count > 4'b1000 ? 1 : 0;//taken 5 becaus

always @(Data) begin//whenever Data value changes then come to this block
    count=4'b0;
    for (i=0;i<16 ;i=i+1 ) begin
        if (Data[i]==1'b1) begin
            count=count+1;
        end
    end
end
endmodule


//test bench for given module

module top;
//
reg [0:15] Data;
wire Out;
//instantiate 
majority16 dut(Out,Data);

//behavioural block
initial begin
    $dumpfile("majority16.vcd");
    $dumpvars(0,top);
    #5 Data=16'b1001000101111101;
    #5 Data=16'b0101010101010101;
    #5 Data=16'b1111001101010101;
    #5 Data=16'b0010111111011110;
    #5 Data=16'b1111111111111111;
    #5 Data=16'b1111010110101111;
    #5 Data=16'b1111100000110000;
    #5 Data=16'b0;
end


endmodule