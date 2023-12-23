module fulladd (s, cout, a, b, cin);

	input a, b, cin;
	output s, cout;

	assign s = a ^ b ^ cin;
	assign cout = (a & b) | (b & cin) | (cin & a);

endmodule

module rca8 (s, cout, a, b, cin);

	input [7:0] a, b;
	input cin;
	output [7:0] s;
	output cout;

	wire [8:0] c;

	assign c[0] = cin;
	assign cout = c[8];

	genvar i;

	generate
		for (i = 0; i < 8; i = i + 1) begin : gen_ripple_carry_add
			fulladd fa (
			.s(s[i]), .cout(c[i+1]),
			.a(a[i]), .b(b[i]), .cin(c[i])
			);
		end
	endgenerate

endmodule

module add8 (s, cout, a, b, cin);

	input [7:0] a, b;
	input cin;
	output [7:0] s;
	output cout;
	
	assign {cout, s} = a + b + cin;

endmodule

module add8_clk (out, in1, in2, CLK, RST_N);

	input CLK, RST_N;
	input [7:0] in1, in2;
	output [8:0] out;
	
	wire [7:0] in1, in2;
	reg [7:0] in1_reg, in2_reg;
	reg [8:0] out;
	
	always @(posedge CLK) begin
		if (!RST_N) begin
			in1_reg <= 0;
			in2_reg <= 0;
			out <= 0;
		end
		else begin
			in1_reg <= in1;
			in2_reg <= in2;
			out <= in1_reg + in2_reg;
		end
	end

endmodule


// Code your testbench here
// or browse Examples
module top;
  
  reg [7:0] A,B;
  reg cin;
  wire [7:0] s;
  wire cout;
  
  //instantiate
  rca8 r1(s,cout,A,B,cin);
  
  
  //
  //behavioural block
initial begin
    $dumpfile("rca8.vcd");
    $dumpvars(0,top);

        A=0; B=4; cin=0;
        #5
        A=0; B=2; cin=1;
        #5
        A=5; B=1; cin=0;
        #5
        A=0; B=4; cin=0;
        #5
        A=7; B=7; cin=0;
        #5
        A=5; B=5; cin=1;
        #5
        A=7; B=0; cin=0;


end
always @(A or B or cin) begin
  $display("the value of A=%d : B=%d  :cin =%d and the sum=%d",A,B,cin,s);
end
endmodule
  