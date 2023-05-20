module Problem2(x,y,CLK);
    input [1:0]x;
    output y;
    input CLK;
    reg [1:0] state, next;

    initial begin
        state = 2'b00;
        next = 2'b00;
    end

    always @(posedge CLK) state = next;

    assign y = (state == 2'b11);

    always @(x, state) begin
        case(x) 
            2'b00: if(state == 2'b00) next = 2'b11;
                else if(state == 2'b11) next = 2'b10;
            2'b01: next = 2'b00;
            2'b10: next = 2'b00;
            2'b11: if(state == 2'b00) next = 2'b11;
                else if(state == 2'b11) next = 2'b10;
        endcase
    end
endmodule

module tb;
    parameter delay = 5;
    reg CLK;
    reg [1:0]x_in;
    wire y_out;
    integer i;
    Problem2 p2(.x(x_in), .y(y_out), .CLK(CLK));
    initial begin;
        CLK = 0;
        $display();
        $display("  time │ x_in │ y_out");
        for (i = 0; i < 16; i = i + 1) begin
            x_in[0] = ($urandom & 'b10) == 'b10;
            x_in[1] = ($urandom & 'b10) == 'b10;
            #delay CLK = ~CLK;
            #1;
            $display(
                "   %3d │    %2b │ %b",
                $time, x_in, y_out);
            #4 CLK = ~CLK;

        end
        $display();
        $finish;
    end
endmodule