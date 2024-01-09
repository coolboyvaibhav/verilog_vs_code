`timescale 1ns/1ps

module udp_edge_trigger_dff (
    q,d,clock,clear
);
output reg q;
input d,clock,clear;

//seq upd initialization
// only one initial statement allowed

initial begin
    q=0;
end



table
  //d   clock  clear    :   q   :   q+;
    ?   ?       1       :   ?   :   0;//clear
    ?   ?       (10)    :   ?   :   -;// retain

    1   (10)     0      :   ?   :   1;
    0   (10)     0      :   ?   :  0;

    ?   (1x)     0      :   ?   :   -;//retain dont know the clock transtition

    ?   (0?)     0      :   ?   :   -;//retain fortransition other than neg edge
    ?   (10)     0      :   ?   :   -;   
    //?   (??)     0      :   ?   :   -;   






endtable

endmodule