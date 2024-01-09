`timescale 1ns/1ps

module udp_latch (
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
    ?   ?       1       :   ?   :   0;
    1   1       0       :   ?   :   1;
    0   1       0       :   ?   :   0;
    ?   0       0       :   ?   :   -;//retain original value



endtable

endmodule