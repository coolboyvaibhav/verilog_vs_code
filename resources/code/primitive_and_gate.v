

primitive udp_and(out,a,b);
output out;
input a,b;

table
    //a     b   :   out
      0     0   :   0;
      0     1   :   0;
      1     0   :   0;
      1     1   :   1;
endtable
endprimitive

