module HalfAdder(s, c, a, b);
    input a,b;
    output s, c;
    xor XOR1(s, a, b);
    and AND1(c, a, b);
endmodule

module two_two_Multi(out, a, b);
    input [1:0] a;
    input [1:0] b;
    output [3:0] out;

    wire A0B1, A1B0, A1B1, C;

    and AND_OUT0(out[0], a[0], b[0]);
    and AND_A0B1(A0B1, a[0], b[1]);
    and AND_A1B0(A1B0, a[1], b[0]);
    and AND_A1B1(A1B1, a[1], b[1]);
    
    HalfAdder ha1(out[1], C, A0B1, A1B0);
    HalfAdder ha2(out[2], out[3], C, A1B1); 
endmodule

module CLA(a, b, s, cin, cout);
    input [3:0]a;
    input [3:0]b;
    input cin;
    output [3:0]s; 
    output cout;

    wire G0, G1, G2, G3, P0, P1, P2, P3;
    wire C1, C2, C3;
    wire cout;

    xor XOR_P0(P0, a[0], b[0]);
    xor XOR_P1(P1, a[1], b[1]);
    xor XOR_P2(P2, a[2], b[2]);
    xor XOR_P3(P3, a[3], b[3]);

    and AND_G0(G0, a[0], b[0]);
    and AND_G1(G1, a[1], b[1]);
    and AND_G2(G2, a[2], b[2]);
    and AND_G3(G3, a[3], b[3]);    

    assign C1 = G0 | (P0 & cin);
    assign C2 = G1 | (P1 & C1);
    assign C3 = G2 | (P2 & C2);
    assign cout = G3 | (P3 & C3);
    
    xor XOR_S0(s[0], cin, P0);
    xor XOR_S1(s[1], C1,  P1);
    xor XOR_S2(s[2], C2,  P2);
    xor XOR_S3(s[3], C3,  P3);   

endmodule

module Multiplier(out, in1, in2);
    input [5:0] in1;
    input [1:0] in2;
    output [7:0] out;

    wire [3:0]f;
    wire [3:0]g;
    wire [3:0]h; 

    two_two_Multi TT1(f, in1[1:0], in2);
    two_two_Multi TT2(g, in1[3:2], in2);
    two_two_Multi TT3(h, in1[5:4], in2);

    wire [3:0]T1 = {g[1:0],2'b00};
    wire [3:0]T2 = {2'b00,g[3:2]};
    wire carry0, carry1, carry2;
    assign carry0 = 0;

    CLA CLA1(T1, f, out[3:0], carry0, carry1);
    CLA CLA2(T2, h, out[7:4], carry1, carry2);
endmodule


