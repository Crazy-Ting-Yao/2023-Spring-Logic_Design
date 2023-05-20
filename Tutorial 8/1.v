module problem1(x, y, Clock);
    input x;
    output y;
    input Clock;
    reg [1:0] state, tmp;
    initial begin
        state = 2'b00;
        tmp = 2'b00;
    end
    always @(posedge Clock) state <= tmp;
    wire y = (state == 2'b00 && x==1'b0) || (state == 2'b10 && x == 1'b1);
    always @(posedge Clock, x) begin
        if(x==1'b1)
            case (state)
                2'b00:  tmp = 2'b01; 
                2'b01:  tmp = 2'b10; 
                2'b10:  tmp = 2'b00; 
                endcase
    end
endmodule

module tb;
    parameter delay = 5;
    reg CLK, x_in;
    wire y_out;
    integer i;
    problem1 p1(x_in, y_out, CLK);
    initial begin;
        CLK = 0;
        $display();
        $display("  time │ x_in │ y_out");
        for (i = 0; i < 16; i = i + 1) begin
            x_in = ($urandom & 'b10) == 'b10;
            // ;
            #delay CLK = ~CLK;
            $display(
                "   %3d │    %b │ %b",
                $time, x_in, y_out);
            #delay;
            CLK = ~CLK;
        end
        $display();
        $finish;
    end
endmodule