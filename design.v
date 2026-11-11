// Gate-level 4-bit Carry-Save Adder (3:2 compressor)
// Adds three 4-bit operands X, Y, Z into a sum vector S and a carry vector C.
// Final result = S + (C << 1)
//
// Modus uses a "Cell Boundary" fault model: it puts stuck-at faults on the pins
// of leaf modules (modules that contain only gate primitives) plus the PIs/POs.
// Wrapping every gate in its own one-gate cell makes those cell pins the gate
// pins, so all 20 gates get input and output stuck-at faults.

module XOR2 (input A, input B, output O);
    xor g (O, A, B);
endmodule

module AND2 (input A, input B, output O);
    and g (O, A, B);
endmodule

module OR2 (input A, input B, output O);
    or  g (O, A, B);
endmodule

module csa_4bit (
    input  [3:0] X,
    input  [3:0] Y,
    input  [3:0] Z,
    output [3:0] S,    // bitwise sum
    output [3:0] C     // bitwise carry (weight 2x)
);
    wire fa0_x1, fa0_a1, fa0_a2;
    wire fa1_x1, fa1_a1, fa1_a2;
    wire fa2_x1, fa2_a1, fa2_a2;
    wire fa3_x1, fa3_a1, fa3_a2;

    // Bit 0
    XOR2 U0_1 (.A(X[0]),   .B(Y[0]),   .O(fa0_x1));
    XOR2 U0_2 (.A(fa0_x1), .B(Z[0]),   .O(S[0]));
    AND2 U0_3 (.A(X[0]),   .B(Y[0]),   .O(fa0_a1));
    AND2 U0_4 (.A(fa0_x1), .B(Z[0]),   .O(fa0_a2));
    OR2  U0_5 (.A(fa0_a1), .B(fa0_a2), .O(C[0]));

    // Bit 1
    XOR2 U1_1 (.A(X[1]),   .B(Y[1]),   .O(fa1_x1));
    XOR2 U1_2 (.A(fa1_x1), .B(Z[1]),   .O(S[1]));
    AND2 U1_3 (.A(X[1]),   .B(Y[1]),   .O(fa1_a1));
    AND2 U1_4 (.A(fa1_x1), .B(Z[1]),   .O(fa1_a2));
    OR2  U1_5 (.A(fa1_a1), .B(fa1_a2), .O(C[1]));

    // Bit 2
    XOR2 U2_1 (.A(X[2]),   .B(Y[2]),   .O(fa2_x1));
    XOR2 U2_2 (.A(fa2_x1), .B(Z[2]),   .O(S[2]));
    AND2 U2_3 (.A(X[2]),   .B(Y[2]),   .O(fa2_a1));
    AND2 U2_4 (.A(fa2_x1), .B(Z[2]),   .O(fa2_a2));
    OR2  U2_5 (.A(fa2_a1), .B(fa2_a2), .O(C[2]));

    // Bit 3
    XOR2 U3_1 (.A(X[3]),   .B(Y[3]),   .O(fa3_x1));
    XOR2 U3_2 (.A(fa3_x1), .B(Z[3]),   .O(S[3]));
    AND2 U3_3 (.A(X[3]),   .B(Y[3]),   .O(fa3_a1));
    AND2 U3_4 (.A(fa3_x1), .B(Z[3]),   .O(fa3_a2));
    OR2  U3_5 (.A(fa3_a1), .B(fa3_a2), .O(C[3]));
endmodule
