// This version doesn't have any delay before display the values.
// If you implement yor lab in TA's way, you should use this one.

`include "lab3.v"

module lab3_tb1;
    reg clk, reset, data;
    wire flag;
    parameter delay = 5;
    integer i;
    PAT lab3(clk, reset, data, flag);
    reg [11:0] data_pattern = 12'b101101011101;
    reg [11:0] reset_pattern = 12'b010000000001;
    initial begin
        $display("cycle | reset | data  | flag");
        clk = 0;
        for(i = 0; i < 12; i = i + 1)begin
            data = data_pattern[i];
            reset = reset_pattern[i];
            #delay clk = ~clk;
            $display("  %2d  |   %b   |   %b   |  %b", $time/10, reset, data, flag);
            #delay clk = ~clk;
        end
        $finish;
    end
endmodule

         