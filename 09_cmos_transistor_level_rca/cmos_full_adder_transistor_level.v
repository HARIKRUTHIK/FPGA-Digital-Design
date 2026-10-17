// =============================================================================
// Module: cmos_full_adder_transistor_level
// Description: Transistor-level switch implementation of 1-Bit Full Adder
//              using complementary static CMOS logic (PUN and PDN networks)
// =============================================================================

`timescale 1ns/1ps

module cmos_full_adder_transistor_level (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);
    supply1 vdd;
    supply0 gnd;

    // Inverted inputs for complementary switching
    wire a_bar, b_bar, cin_bar;
    not n1 (a_bar, a);
    not n2 (b_bar, b);
    not n3 (cin_bar, cin);

    // Carry Generate & Invert: Cout_bar = ~ ( (A & B) | (Cin & (A | B)) )
    wire cout_bar;
    wire c_net1, c_net2, c_net3;

    // Pull-Up Network for Cout_bar (PMOS)
    pmos (c_net1, vdd, a);
    pmos (cout_bar, c_net1, b);
    pmos (c_net2, vdd, cin);
    pmos (cout_bar, c_net2, a);
    pmos (cout_bar, c_net2, b);

    // Pull-Down Network for Cout_bar (NMOS)
    nmos (c_net3, gnd, a);
    nmos (cout_bar, c_net3, b);
    nmos (cout_bar, gnd, cin);

    // Complement to produce True Cout
    not (cout, cout_bar);

    // Sum Logic: Sum = A ^ B ^ Cin
    // Switch-level complex CMOS implementation using Cout_bar optimization
    // Sum_bar = A.B.Cin + Cout_bar.(A + B + Cin)
    wire sum_bar;
    wire s_p1, s_p2, s_n1, s_n2;

    // PMOS Pull-Up for Sum_bar
    pmos (s_p1, vdd, a);
    pmos (s_p1, vdd, b);
    pmos (s_p1, vdd, cin);
    pmos (sum_bar, s_p1, cout);

    pmos (s_p2, vdd, a);
    pmos (s_p2, s_p2, b);
    pmos (sum_bar, s_p2, cin);

    // NMOS Pull-Down for Sum_bar
    nmos (s_n1, gnd, a);
    nmos (s_n1, gnd, b);
    nmos (s_n1, gnd, cin);
    nmos (sum_bar, s_n1, cout_bar);

    nmos (s_n2, gnd, a);
    nmos (s_n2, s_n2, b);
    nmos (sum_bar, s_n2, cin);

    // Output inverter for True Sum
    not (sum, sum_bar);

endmodule
