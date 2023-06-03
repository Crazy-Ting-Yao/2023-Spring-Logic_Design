`include "lab3.v"

module lab3_tb2;
    reg CLK, RESET, LR_has_Car;
    wire [2:0] HW_light, LR_light;
    parameter delay = 5;
    integer i;
    Traffic_Light_Controller TLC_Lab3(CLK, RESET, LR_has_Car, HW_light, LR_light);
    reg [19:0] LR_pattern = 20'b11111100111111100000;
    initial begin
        $dumpfile("lab3_tb2.vcd");
        $dumpvars(0, lab3_tb2);
        CLK = 0;
        RESET = 1;
        LR_has_Car = 0;
        #delay CLK = ~CLK;
        #delay CLK = ~CLK;
        RESET = 0;
        for(i = 0; i < 20; i = i + 1)begin
            LR_has_Car = LR_pattern[i];
            #delay CLK = ~CLK;
            #delay CLK = ~CLK;
        end
        $finish;
    end
endmodule

         