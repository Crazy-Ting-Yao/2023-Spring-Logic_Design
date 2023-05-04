`include "Multiplier.v"
module Multiplier_tb;
    parameter delay = 5;

    reg [5:0]in1; 
    reg [1:0]in2;
    wire [7:0]out;
    wire [7:0]is;
    assign is = in1*in2;
    
    integer i;
    integer j;

    initial begin
        in1 = 6'd000000;
        for(i = 0; i < 64; i = i + 1)begin
            in2 = 2'd00;
            for(j=0 ; j < 4; j = j + 1) begin
                #delay;
                $display("time = %4d, in1 = %6b, in2 = %2b, out = %8b", $time, in1, in2, out);
                if(!(is===out))
                    begin
                        $display("You got wrong answer!!");
                        $finish;
                    end
                in2 = in2 + 2'd01;
            end
            in1 = in1 + 6'd000001;
        end
        $display("Congratulations!!");
        $finish;
    end
    Multiplier MU(out, in1, in2);
endmodule