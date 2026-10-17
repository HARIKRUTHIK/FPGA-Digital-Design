`timescale 1ns/1ps

module tb_multipliers;

    reg clk;
    reg rst;
    reg [3:0] a;
    reg [3:0] b;
    wire [7:0] p_4x4;

    reg [3:0] a_4x3;
    reg [2:0] b_4x3;
    wire [6:0] p_4x3;

    seq_multiplier uut_4x4 (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .P(p_4x4)
    );

    seq_multiplier4x3 uut_4x3 (
        .clk(clk),
        .rst(rst),
        .A(a_4x3),
        .B(b_4x3),
        .P(p_4x3)
    );

    always #5 clk = ~clk;

    integer i, j;
    integer errors = 0;
    integer total_tests = 0;

    initial begin
        clk = 0;
        rst = 1;
        a = 0;
        b = 0;
        a_4x3 = 0;
        b_4x3 = 0;
        #20;
        rst = 0;

        $display("=================================================================");
        $display("   SEQUENTIAL MULTIPLIERS AUTOMATED VERIFICATION");
        $display("=================================================================");

        // Test 4x4 Sequential Multiplier
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                rst = 1;
                a = i[3:0];
                b = j[3:0];
                #10;
                rst = 0;
                #60; // 5 clock cycles for computation
                total_tests = total_tests + 1;
                if (p_4x4 !== (i * j)) begin
                    $display("[ERROR] 4x4 Multiplier Mismatch: %0d x %0d | Expected=%0d Got=%0d", 
                             i, j, (i * j), p_4x4);
                    errors = errors + 1;
                end
            end
        end

        // Test 4x3 Sequential Multiplier
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                rst = 1;
                a_4x3 = i[3:0];
                b_4x3 = j[2:0];
                #10;
                rst = 0;
                #50; // 4 clock cycles for computation
                total_tests = total_tests + 1;
                if (p_4x3 !== (i * j)) begin
                    $display("[ERROR] 4x3 Multiplier Mismatch: %0d x %0d | Expected=%0d Got=%0d", 
                             i, j, (i * j), p_4x3);
                    errors = errors + 1;
                end
            end
        end

        $display("-----------------------------------------------------------------");
        $display("Total Multiplier Executions: %0d", total_tests);
        if (errors == 0) begin
            $display("[RESULT] ALL MULTIPLIER TESTS PASSED (Zero Discrepancies)");
        end else begin
            $display("[RESULT] FAILED: %0d Discrepancies Detected", errors);
        end
        $display("=================================================================");
        $finish;
    end

endmodule
