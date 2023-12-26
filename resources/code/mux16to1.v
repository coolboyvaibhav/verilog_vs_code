

module mux16to1 (
    out,in,sel
);
output out;
input [15:0] in;
input [3:0] sel;

//simple behavioural implmentation
assign out=in[sel];

    
endmodule

//stimulus

module stimulus;
    
wire out;
reg [15:0] in ;
reg [3:0] sel;

//instantiate design 
mux16to1 dut(out,in,sel);

//behavioural block
initial begin
    //dump in vcd file
    $dumpfile("mux16to1.vcd");
    $dumpvars(0,stimulus);
    //
    in=16'b1010101010101010;
    sel=4'b0000;
    #5
    sel=4'b0001;
    #5
    sel=4'b0010;
    #5
    sel=4'b0011;
    #5
    sel=4'b0100;
    #5
    sel=4'b0101;
    #5
    sel=4'b0110;
    #5
    sel=4'b0111;
    #5
    sel=4'b1000;
    #5
    sel=4'b1001;
    #5
    sel=4'b1010;



end

always @(in or sel) begin
    $display("out=%b :sel=%b\n",out,sel);
end
endmodule