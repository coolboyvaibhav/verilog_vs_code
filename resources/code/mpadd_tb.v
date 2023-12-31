`timescale 1ns/1ps

module mpadd256_parallel (CLK, RST_N, s_out, a_in, b_in, write, start, ready);

	input CLK, RST_N;
	input [255:0] a_in, b_in;
	input write, start;
	output [256:0] s_out;
	output ready;

	reg [256:0] sum;
	reg [255:0] a, b;
	reg ready;

	assign s_out = sum;

	always @(posedge CLK) begin
		if (~RST_N) begin
			ready <= 1'b0;
		end
		else begin
			if (start) begin
				sum <= {1'b0, a} + {1'b0, b};
				ready <= 1'b1;
			end
			else begin
				if (write) begin
					a <= a_in;
					b <= b_in;
				end
				ready <= 1'b0;
			end
		end
	end

endmodule

// 256-bit LFSR for pseudo-random number generation
module lfsr_256 (CLK, RST_N, state, init_val, en);
	
	input CLK, RST_N;
	input [255:0] init_val;
	input en;
	output [255:0] state;

	reg [255:0] state;

	always @(posedge CLK) begin
		if (~RST_N) begin
			state <= init_val;
		end
		else begin
			if (en) begin
				state <= {state[0], state[255] ^ state[0], state[254], state[253] ^ state[0], state[252:251],
					  state[250] ^ state[0], state[249:246], state[245] ^ state[0], state[244:1]};
			end
		end
	end

endmodule


module mpadd256_serial (CLK, RST_N, s_out, a_in, b_in, write, start, ready);

	input CLK, RST_N;
	input [255:0] a_in, b_in;
	input write, start;
	output [256:0] s_out;
	output ready;

	reg [256:0] sum;
	reg [255:0] a, b;
	reg ready;
	
	reg [2:0] state;
	reg [31:0] a_int, b_int;
    
    wire [32:0] s_int;
	
	always @(a, state) begin
		case (state)
			3'd0:	a_int = a[031:000];
			3'd1:	a_int = a[063:032];
			3'd2:	a_int = a[095:064];
			3'd3:	a_int = a[127:096];
			3'd4:	a_int = a[159:128];
			3'd5:	a_int = a[191:160];
			3'd6:	a_int = a[223:192];
			3'd7:	a_int = a[255:224];
		endcase
	end
	
	always @(b, state) begin
		case (state)
			3'd0:	b_int = b[031:000];
			3'd1:	b_int = b[063:032];
			3'd2:	b_int = b[095:064];
			3'd3:	b_int = b[127:096];
			3'd4:	b_int = b[159:128];
			3'd5:	b_int = b[191:160];
			3'd6:	b_int = b[223:192];
			3'd7:	b_int = b[255:224];
		endcase
	end
	
	assign s_out = sum;

    assign s_int = {1'b0, a_int} + {1'b0, b_int} + sum[256];

	always @(posedge CLK) begin
		if (~RST_N) begin
			ready <= 1'b0;
		end
		else begin
			if (start) begin
                sum[031:000] <= s_int[31:0]; sum[256] <= s_int[32];
				state <= state + 1;
            end
			else begin
				if (write) begin
					a <= a_in;
					b <= b_in;
				end
				ready <= 1'b0;
				state <= 3'd0;
				sum[256] <= 1'b0;
			end
            
            if (state > 3'd0) begin
                if (state == 3'd1) begin
                    sum[063:032] <= s_int[31:0]; sum[256] <= s_int[32];
                end
                else if (state == 3'd2) begin
                    sum[095:064] <= s_int[31:0]; sum[256] <= s_int[32];
                end
                else if (state == 3'd3) begin
                    sum[127:096] <= s_int[31:0]; sum[256] <= s_int[32];
                end
                else if (state == 3'd4) begin
                    sum[159:128] <= s_int[31:0]; sum[256] <= s_int[32];
                end
                else if (state == 3'd5) begin
                    sum[191:160] <= s_int[31:0]; sum[256] <= s_int[32];
                end
                else if (state == 3'd6) begin
                    sum[223:192] <= s_int[31:0]; sum[256] <= s_int[32];
                end
                else begin
                    sum[255:224] <= s_int[31:0]; sum[256] <= s_int[32];
                end
				state <= state + 1;
				if (state == 3'd7) begin
					ready <= 1'b1;
				end
			end
		end
	end

endmodule
// Multi-precision adder test-bench
module mpadd_tb ();

	parameter CLOCK_PERIOD = 100; // 10 MHz clock
	parameter NUM_TEST = 1000; // Number of tests

	reg sys_clk, sys_rst_n;
	reg [3:0] state;
	reg en_a, en_b;
	reg write, start;
	reg [9:0] test_err;
	reg [9:0] test_count;

	wire [255:0] a, b;
	wire [256:0] s_out, s_golden;
	wire ready;

	event terminate_sim;

	lfsr_256 u_lfsr_a (.CLK(sys_clk), .RST_N(sys_rst_n), .state(a), .init_val(256'h6B17D1F2E12C4247F8BCE6E563A440F277037D812DEB33A0F4A13945D898C296), .en(en_a));
	lfsr_256 u_lfsr_b (.CLK(sys_clk), .RST_N(sys_rst_n), .state(b), .init_val(256'h4FE342E2FE1A7F9B8EE7EB4A7C0F9E162BCE33576B315ECECBB6406837BF51F5), .en(en_b));

	// Modify the module name for the design being tested
	mpadd256_serial u_DUT (.CLK(sys_clk), .RST_N(sys_rst_n), .s_out(s_out), .a_in(a), .b_in(b), .write(write), .start(start), .ready(ready));

	assign s_golden = {1'b0, a} + {1'b0, b};

	always @(posedge sys_clk) begin
		if (sys_rst_n == 1'b1) begin
			if (state == 4'h0) begin
				if (test_count == NUM_TEST) begin
					-> terminate_sim;
				end
				if (test_count == 0) begin
					en_a <= 1'b1; en_b <= 1'b1;
					state <= 4'h1;
				end
			end
			if (state == 4'h1) begin
				en_a <= 1'b0; en_b <= 1'b0; write <= 1'b1;
				state <= 4'h2;
			end
			if (state == 4'h2) begin
				start <= 1'b1; write <= 1'b0;
				state <= 4'h3;
			end
			if (state == 4'h3) begin
				start <= 1'b0;
				if (ready) begin
					// $display("TEST %d: A = %h, B = %h, S_out = %h, S_golden = %h", test_count + 1, a, b, s_out, s_golden);
					if (s_out != s_golden) begin
						$display("ERROR (%d)", test_count);
						test_err <= test_err + 1;
					end
					if (test_count == NUM_TEST - 1) begin
						state <= 4'h0;
					end
					else begin
						en_a <= 1'b1; en_b <= 1'b1;
						state <= 4'h1;
					end
					test_count <= test_count + 1;
				end
			end
		end
    	end

	// End of simulation
    	initial @(terminate_sim) begin
        	$display("END OF SIMULATION (Time: %g ns)", $time);
        	if(test_err == 0) begin
            		$display("TEST RESULT: PASS (%d / %d)", test_count, test_count);
        	end
        	else begin
            		$display("TEST RESULT: FAIL (%d / %d)", test_err, test_count);
        	end
        	$display("##################\n");
        	#1  $finish;
    	end

	// Initial conditions
	initial begin
	    	sys_clk = 1'b0; sys_rst_n = 1'b0;
        	en_a = 1'b0; en_b = 1'b0;
		state = 4'h0;
		write = 1'b0; start = 1'b0;
        	test_err = 0; test_count = 0;
		#CLOCK_PERIOD sys_rst_n = 1'b1;
		#(CLOCK_PERIOD/2) $display("START OF SIMULATION (Time: %g ns)", $time);
    	end


	// VCD dump
	initial begin
		$dumpfile("mpadd.vcd");
		$dumpvars(0, u_DUT);
	end

	// System clock generator
	always begin
		#(CLOCK_PERIOD/2) sys_clk = ~sys_clk;
	end

endmodule

