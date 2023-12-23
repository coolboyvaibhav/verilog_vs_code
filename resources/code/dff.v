
module dff (
    d,CLK,q,q_bar
);

input d,CLK;
output q,q_bar;

wire d,CLK;
reg q,q_bar;

always @(posedge CLK) begin
    q<= d;
    q_bar <=!d;
end    
endmodule