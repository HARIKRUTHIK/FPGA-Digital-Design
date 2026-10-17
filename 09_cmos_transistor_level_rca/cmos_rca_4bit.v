// =============================================================================
// Module: cmos_rca_4bit
// Description: 4-Bit Ripple Carry Adder cascading transistor-level full adders
//              Models carry propagation delay and glitch characteristics
// =============================================================================

`timescale 1ns/1ps

module cmos_rca_4bit (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire       cin,
    output wire [3:0] sum,
    output wire       cout
);
    wire c1, c2, c3;

    // Transistor-level bit-slices
    cmos_full_adder_transistor_level fa0 (
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .sum(sum[0]),
        .cout(c1)
    );

    cmos_full_adder_transistor_level fa1 (
        .a(a[1]),
        .b(b[1]),
        .cin(c1),
        .sum(sum[1]),
        .cout(c2)
    );

    cmos_full_adder_transistor_level fa2 (
        .a(a[2]),
        .b(b[2]),
        .cin(c2),
        .sum(sum[2]),
        .cout(c3)
    );

    cmos_full_adder_transistor_level fa3 (
        .a(a[3]),
        .b(b[3]),
        .cin(c3),
        .sum(sum[3]),
        .cout(cout)
    );

endmodule
