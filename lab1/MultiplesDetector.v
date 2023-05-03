module MultiplesDetector_G(in, out);

    parameter n=4;

    input [n-1:0]in;
    output out;

    wire and0, and1, and2;
    wire not_a, not_b, not_c, not_d;

    not not_gate0(not_a, in[3]);
    not not_gate1(not_b, in[2]);
    not not_gate2(not_c, in[1]);
    not not_gate3(not_d, in[0]);

    and and_gate1(and0, not_b, not_c, in[3]);
    and and_gate2(and1, in[1], not_b, not_a);
    and and_gate3(and2, in[1], in[2], in[3]);

    or or_gate(out, not_d, and0, and1, and2);
endmodule

module MultiplesDetector_D(in, out);
    parameter n=4;

    input [n-1:0] in;
    output out;
    
    assign out = !in[0]
                 | (!in[1] & !in[2] & in[3])
                 | (in[1] & !in[2] & !in[3])
                 | (in[1] & in[2] & in[3]);
endmodule

module MultiplesDetector_B(in, out);
    parameter n=4;

    input [n-1:0] in;
    output out;
    reg out;

    always @(*) begin
        case(in)
            0, 2, 3, 4, 6, 8, 9, 10, 12, 14, 15:begin
                out = 1'b1;
            end
            default :begin
                out = 1'b0;
            end
        endcase
    end
endmodule