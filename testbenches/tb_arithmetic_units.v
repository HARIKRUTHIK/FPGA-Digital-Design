`timescale 1ns/1ps

module tb_arithmetic_units;

    reg  [3:0] a, b;
    reg        cin;
    wire [3:0] sum_rca, sum_cla, sum_cskip, sum_cselect, sum_cond;
    wire       cout_rca, cout_cla, cout_cskip, cout_cselect, cout_cond;

    // Unit Under Test Instantiations
    rca_4bit uut_rca (
        .a(a), .b(b), .cin(cin),
        .sum(sum_rca), .cout(cout_rca)
    );

    cla_4bit uut_cla (
        .a(a), .b(b), .cin(cin),
        .sum(sum_cla), .cout(cout_cla)
    );

    carry_skip_adder uut_cskip (
        .a(a), .b(b), .cin(cin),
        .sum(sum_cskip), .cout(cout_cskip)
    );

    carry_select_adder uut_cselect (
        .a(a), .b(b), .cin(cin),
        .sum(sum_cselect), .cout(cout_cselect)
    );

    conditional_sum_adder uut_cond (
        .a(a), .b(b), .cin(cin),
        .sum(sum_cond), .cout(cout_cond)
    );

    integer i, j, k;
    integer errors = 0;
    integer test_count = 0;
    reg [4:0] expected;

    initial begin
        $display("=================================================================");
        $display("   ARITHMETIC UNITS EXHAUSTIVE VERIFICATION SUITE");
        $display("=================================================================");

        for (k = 0; k < 2; k = k + 1) begin
            cin = k[0];
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    a = i[3:0];
                    b = j[3:0];
                    #5;
                    expected = a + b + cin;
                    test_count = test_count + 1;

                    // Verify Ripple Carry Adder
                    if ({cout_rca, sum_rca} !== expected) begin
                        $display("[ERROR] RCA Mismatch: a=%d b=%d cin=%b | Expected=%d Got={%b,%d}", 
                                 a, b, cin, expected, cout_rca, sum_rca);
                        errors = errors + 1;
                    end

                    // Verify Carry Look-Ahead Adder
                    if ({cout_cla, sum_cla} !== expected) begin
                        $display("[ERROR] CLA Mismatch: a=%d b=%d cin=%b | Expected=%d Got={%b,%d}", 
                                 a, b, cin, expected, cout_cla, sum_cla);
                        errors = errors + 1;
                    end

                    // Verify Carry Skip Adder
                    if ({cout_cskip, sum_cskip} !== expected) begin
                        $display("[ERROR] Carry-Skip Mismatch: a=%d b=%d cin=%b | Expected=%d Got={%b,%d}", 
                                 a, b, cin, expected, cout_cskip, sum_cskip);
                        errors = errors + 1;
                    end

                    // Verify Carry Select Adder
                    if ({cout_cselect, sum_cselect} !== expected) begin
                        $display("[ERROR] Carry-Select Mismatch: a=%d b=%d cin=%b | Expected=%d Got={%b,%d}", 
                                 a, b, cin, expected, cout_cselect, sum_cselect);
                        errors = errors + 1;
                    end

                    // Verify Conditional Sum Adder
                    if ({cout_cond, sum_cond} !== expected) begin
                        $display("[ERROR] Conditional-Sum Mismatch: a=%d b=%d cin=%b | Expected=%d Got={%b,%d}", 
                                 a, b, cin, expected, cout_cond, sum_cond);
                        errors = errors + 1;
                    end
                end
            end
        end

        $display("-----------------------------------------------------------------");
        $display("Total Input Vectors Evaluated: %0d", test_count);
        $display("Total Adder Check Assertions: %0d", test_count * 5);
        if (errors == 0) begin
            $display("[RESULT] ALL ARITHMETIC UNIT CHECKS PASSED (Zero Discrepancies)");
        end else begin
            $display("[RESULT] VERIFICATION FAILED: %0d Discrepancies Detected", errors);
        end
        $display("=================================================================");
        $finish;
    end

endmodule
