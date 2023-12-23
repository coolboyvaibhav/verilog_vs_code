// Write a Verilog module to implement a J-K master-slave flip-flop with asynchronous set and reset at the gate level. The module will take as arguments the following:
// 1-bit data input “J”
// 1-bit data input “K”
// 1-bit clock input “Clk”
// 1-bit data input “Set”
// 1-bit data input “Rst”
// 1-bit output “Q”
// 1-bit output “Qb”
// module jk_ms_ff (Q, Qb, J, K, Clk, Set, Rst);

// Hint: Use two or three input NAND gates and NOT gates for implementation and also ensure state transitions only on leading  edge of the clock signal (i.e. 0 to 1 transition). The flip-flop will set Q to logic 1 state when Set signal is kept low; similarly, it will set Qb to logic 1 when Rst input is kept low. The  flip-flop will perform normal operations when both Set and Rst signals are kept high.

module jk_ff (
    Q, Qb, J, K, Clk, Set, Rst
);
//port declartions
output Q,Qb;
input J, K, Clk, Set, Rst;
//wire declartions
wire w1,w2;

//from basic gates 3 input nand gates 
 nand n1(w1,J,Qb,Clk);
 nand n2(w2,K,Q,Clk);

 nand n3(Q,W1,Qb);
 nand n4(Qb,W2,Q);
    
endmodule

module jk_ms_ff (
   Q, Qb, J, K, Clk, Set, Rst
);
//port declartions
output Q,Qb;
input J, K, Clk, Set, Rst;
//wire declartions
wire w1,w2;
//instantiating lower block
jk_ff master(W1,w2,J,K,Clk,Set,Rst);
jk_ff slave(Q,Qb,W1,W2,~Clk,Set,Rst);
endmodule

