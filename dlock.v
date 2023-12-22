// Digital Lock: 
// It is required to implement a digital lock that will accept a specific bit sequence  “101100” through an input button “b_in” 
//serially in synchronism with the negative edge of an input clock, and will generate an “unlock” signal “1” as output; for any other 
//bit sequence the “unlock” signal will remain at logic “0”.  An active low “clear” signal is used to asynchronously reset the lock in its initial/default state.

// Write a Verilog module to implement the specification as Moore machine using the following template:
//     module dlock (unlock, b_in, clear, clk);
//important to note serially in synchronism with the negative edge of an input clock statement
module dlock (
    unlock, b_in, clear, clk
);
output reg unlock;
input b_in,clear,clk;


reg [2:0] state; // The machine states 
parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100, S5=3'b101, S6=3'b110, S7=3'b111; 

always @(negedge clk or clear) begin
    if (clear==0) begin
        state<=S0;
    end
    else case (state)
        S0: state <= b_in ? S1 : S7;
 	    S1: state <= b_in ? S7 : S2;
	    S2: state <= b_in ? S3 : S7;
 	    S3: state <= b_in ? S4 : S7;
	    S4: state <= b_in ? S7 : S5;
	    S5: state <= b_in ? S7 : S6;
	    S6: state <= S6;
	    S7: state <= S7; 
        default:state<=0; 
    endcase 
end
always @(state) begin
    case (state)
        S0, S1, S2, S3, S4, S5, S7: unlock = 0;
        S6: unlock = 1; 
    endcase
end     
endmodule


//stimulus 
module stimulus;
    reg b_in,clear,clk;
    wire unlock;
    
endmodule