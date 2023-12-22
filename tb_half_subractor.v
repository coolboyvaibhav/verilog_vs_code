`include "half_subtractor.v"
module top ;
  reg X,Y;
  wire Diff,Bout;

  //instantiate lower block
  half_sub dut(.Diff(Diff),.Bout(Bout),.X(X),.Y(Y));

  //behavioural blocks
  initial begin
    //dumping values in vcd file
    $dumpfile("half_sub.vcd");
    $dumpvars(0,top);
    X=0;Y=0;
    #5
    X=0;Y=1;
    #5
    X=1;Y=0;
    #5
    X=1;Y=1;
    #5
    X=0;Y=0;
    
  end

endmodule





















/* // by nptel professor solution
module half_sub_test;

  reg X, Y;
  wire Diff, Bout;

  parameter STDIN = 32'h8000_0000;
  integer testid;
  integer ret;

  half_sub dut (Diff, Bout, X, Y);
  
  initial begin
      ret = $fscanf(STDIN, "%d", testid);
      case(testid)
	  0: begin #10 X=0; Y=0; end
	  1: begin #10 X=0; Y=1; end
	  2: begin #10 X=1; Y=0; end
	  3: begin #10 X=1; Y=1; end
       default: begin
	    $display("Bad testcase id %d", testid);
	    $finish();
	  end
      endcase
      #5;
	 if ( (testid == 0 && {Diff,Bout} == 2'b00) || 
	      (testid == 1 && {Diff,Bout} == 2'b11) ||
	      (testid == 2 && {Diff,Bout} == 2'b10) || 	
	      (testid == 3 && {Diff,Bout} == 2'b00))
	  pass();
	else
	  fail();
  end
  task fail; begin
    $display("Fail: X=%b, Y=%d, Diff=%b, Bout=%b", X, Y, Diff, Bout);
    $finish();
    end
  endtask
  task pass; begin
    $display("Pass: X=%b, Y=%d, Diff=%b, Bout=%b", X, Y, Diff, Bout);
    $finish();
    end
  endtask
endmodule*/