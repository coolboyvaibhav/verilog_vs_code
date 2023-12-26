# Practice questions of  Verilog 

## Hello World :
file name: hello_world.v

 Print Hello world in verilog.

## Half Adder :
file name: half_adder.v

Sum = A XOR B  
Carry = A AND B 

## Traffic signal controller using finite state machine approach:



## Digital Lock: 
file name : dlock.v

It is required to implement a digital lock that will accept a specific bit sequence  “101100” through an input button “b_in” serially in synchronism with the negative edge of an input clock, and will generate an “unlock” signal “1” as output; for any other bit sequence the “unlock” signal will remain at logic “0”.  An active low “clear” signal is used to asynchronously reset the lock in its initial/default state.

Write a Verilog module to implement the specification as Moore machine using the following template:
    module dlock (unlock, b_in, clear, clk);


## Division by Repeated Subtraction :
file name : division.v

It is required to design an 8-bit divider by implementing  the data path and control path separately. The operation will take as inputs divisor p and dividend n, and provides outputs quotient q and remainder r such that n = p x q + r. At the beginning two registers P and N will be loaded with p and n respectively. At each iteration p will be subtracted from N, storing the result back in N, as long as p <= N, and also increment a counter Q that is initialized to 0. At the end, Q will contain the quotient (q), and N will contain the remainder (r).



The data path will consist of two 8-bit registers N and  P, an 8-bit counter Q,  an 8-bit subtractor,  and an 8-bit comparator. The comparator takes two numbers N and P as inputs and outputs PgtN = 0, if P > N; otherwise it will give PgtN = 1. The control path will generate the following active-high control signals in synchronism with the positive edge of the clock, and also implement the following FSM with states S0 to S4.

| Signal | Description                                        |
|--------|----------------------------------------------------|
| LoadN  | Load input data in register N at the +ve clock edge.  |
| LoadS  | Load N with the subtraction result at the +ve clock edge. |
| LoadP  | Load input data in register P at the +ve clock edge.  |
| Clear  | Clear registers/counters to 0 at the +ve clock edge.  |
| IncQ   | Increment counter Q at the +ve clock edge.  |
| Stop   | Stop computing if comparator output PgtN is 0.  |

<!-- ![Alt text](C:\iverilog\bin\iverilog_test\control_flow3.png "a title") -->
![Memory models](/resources/images/control_flow3.png)<br>

An external signal Start will start the division operation, and registers N and P are loaded with inputs provided through common data input, Data_in. Write Verilog modules to implement all the component hardware units and use them as building blocks to design data path and control path as per the following template:
                    module div_datapath (PgtN, LoadN, LoadS, LoadP, Clear, IncQ, Data_in, Clk);
                    module div_ctrlpath (LoadN, LoadP, Clear, IncQ, Stop, Clk, PgtN, Start);

 Important Note: Please use variables Nw and Qw as the output interface of registers N and Q respectively inside div_datapath module. This is essential for the verification of your design using the configured testbench.


## D flip-flop   
file name : dff.v  



## a two agent arbiter

For this tutorial, we'll be building a two agent arbiter: a device that selects among two agents competing for mastership. Here are some specs we might write up.


 -> Two agent arbiter.  
 ->Active high asynchronous reset.  
 ->Fixed priority, with agent 0 having priority over agent 1  
 ->Grant will be asserted as long as request is asserted.

 ![Memory models](/resources/images/aribiter_signal.gif)<br>	 	

Once we have the specs, we can draw the block diagram, which is basically an abstraction of the data flow through a system (what goes into or comes out of the black boxes?). Since the example that we have taken is a simple one, we can have a block diagram as shown below. We don't worry about what's inside the magical black boxes just yet.
 ![Memory models](/resources/images/aribiter_fsm.gif)<br>
	
Each of the circles represents a state that the machine can be in. Each state corresponds to an output. The arrows between the states are state transitions, labeled by the event that causes the transition. For instance, the leftmost orange arrow means that if the machine is in state GNT0 (outputting the signal that corresponds to GNT0) and receives an input of !req_0, the machine moves to state IDLE and outputs the signal that corresponds to that. This state machine describes all the logic of the system that you'll need. The next step is to put it all in Verilog.

**Low level design**
To see how Verilog helps us design our arbiter, let's go on to our state machine - now we're getting into the low-level design and peeling away the cover of the previous diagram's black box to see how our inputs affect the machine.

# ESDCS lab
## 8 bit ripple carry adder
file name : adder.v  




## 8 bit counter
file name : counter.v  
In the next part of this tutorial, we compile and simulate an 8-bit counter design with design and 
testbench modules specified in separate Verilog source files. We also view the simulation waveforms.
Create a file named counter.v with the following content:
module counter (out, CLK, RST_N);

## 256 bit adder
file name : mpadd.v  
Serial and Parallel addition of 256 bits done



# FPGA Questions
## Exercise 1
file name : ripple_adder_4bit.v  

Write a Verilog gate level model for a 4-bit ripple adder. Do the functional and 
timing simulation. Analyze which input takes maximum delay and give it in testbench 
along with few other inputs and show the post-routing timing delays in report. Target 
Device is Xilinx Artix-7 XC7A35T- ICPG236C (Family Artix-7, Part XC7A35T, 
Package CPG236, Speed Grade -1

$ Sum = x' y' z+x' yz+xy' z'+xyz $  

$ Carry = xy+xz+yz $  

## Exercise 2
Write Verilog code to implement a 4-bit, 4-to-1 multiplexer with structural design (4-
to-1 multiplexer should be made with 2-to-1 multiplexer). Do the functional and 
timing simulation. Target Device is Xilinx Artix-7 XC7A35T- ICPG236C (Family 
Artix-7, Part XC7A35T, Package CPG236, Speed Grade -1)

file name : mux4to1.v  

### 2-to-1 mux
**y=I0.sel-bar+I1.sel** 



## Exercise 3
file name : carry_look_ahead_adder.v  

Write Verilog model with continuous assignment for a 4-bit carry look-ahead adder. 
Do the functional and timing simulation. Use the same input combination as in 
Exercise 1. Compare the delays and note them. Target Device is Xilinx Artix-7 
XC7A35T- ICPG236C (Family Artix-7, Part XC7A35T, Package CPG236, Speed 
Grade -1




## Exercise 4

file name : carry_look_ahead_adder.v  

Design a normalizing circuit for de-normal floating-point numbers. Assume 8-bit size 
for mantissa, including the leading 1. Mantissa of normalized floating point would read 
1.xxx … xx (x: 0 or 1). Example of a de-normalized floating point would be 0.00001xx 
… xxx (x: 0 or 1). This number is normalized by shifting the number left by 5 places. 
Assume that de-normalized number is available is available as input, after normalizing 
the number, result is available at the output. Also, output the value to be subtracted from 
exponent to an output port to be used by the exponent circuit. 


Try at least two different ways of implementing it. Draw the schematic of the circuit 
before coding in each case. Target Device is Xilinx Artix-7 XC7A35T- ICPG236C (Family 
Artix-7, Part XC7A35T, Package CPG236, Speed Grade -1). Do the functional simulation. 
After elaboration, verify the RTL schematic. Do the Implementation and post-route
timing simulation. Note down the maximum clock frequency from timing report and the 
resource utilization in terms of LUTs, (slices) and FFs in each case.

