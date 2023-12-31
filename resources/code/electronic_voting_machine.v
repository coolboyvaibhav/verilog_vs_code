//

`timescale 1ns/1ps

module button_control (
    validation_of_vote,button,clock,reset
);

//port declartions
output reg validation_of_vote;
input button;
input clock,reset;

reg [30:0] counter;

always @(posedge clock) begin
    if (reset) begin
        counter<=0;
    end
    else
    begin
        if (button & counter <1) begin
            counter<=counter+1;
        end
        else if (!button) begin
            counter<=0;
        end
    end
    
end

always @(posedge clock) begin
    if (reset) begin
        validation_of_vote=<1'b0;
    end
    else 
        begin
            if (counter==10) begin
                validation_of_vote<=1'b1;
            end
            else 
                validation_of_vote<=1'b0;
        end
    
end

endmodule


//assume five people for vote casting 
module mode_control (
    output reg [7:0] LEDs,
    input mode,
    input validation_of_vote,
    // input [7:0] candiate_votes[4:0],
    // input candiate_button_pressed [4:0],
    input clock,
    input reset
);
    
endmodule