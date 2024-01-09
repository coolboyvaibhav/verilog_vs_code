

primitive udp_mux4to1(out,i0,i1,i2,i3,s1,s0);
output out;
input i0,i1,i2,i3,s1,s0;

table
  //i0  i1  i2  i3  s1  s0  :   out
    1   ?   ?   ?   0   0   :   1;
    0   ?   ?   ?   0   0   :   0;
    ?   1   ?   ?   0   1   :   1;
    ?   0   ?   ?   0   1   :   0;
    ?   ?   1   ?   1   0   :   1;
    ?   ?   0   ?   1   0   :   0;
    ?   ?   ?   1   1   1   :   1;
    ?   ?   ?   0   1   1   :   0;
    ?   ?   ?   ?   x   ?   :   x;
    ?   ?   ?   ?   ?   x   :   x;


endtable
endprimitive