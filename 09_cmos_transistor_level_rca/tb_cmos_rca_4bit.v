// =============================================================================
// Testbench: tb_cmos_rca_4bit
// Description: Exhaustive self-checking testbench measuring functional correctness
//              and carry ripple propagation for CMOS 4-bit RCA
// =============================================================================

`timescale 1ns/1ps

module tb_cmos_rca_4bit;

    reg  [3:0] a;
    reg  [3:0] b;
    reg        cin;
    wire [3:0] sum;
    wire       cout;

    // Expected value registers
    reg  [4:0] expected;
    integer errors;
    integer i, j, k;

    // Instantiate UUT
    cmos_rca_4bit uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        $display("------------------------------------------------------------");
        $display("Starting CMOS 4-Bit Transistor RCA Verification");
        $display("------------------------------------------------------------");
        errors = 0;

        // Exhaustive sweep of all 512 input combinations (16 * 16 * 2)
        for (k = 0; k < 2; k = k + 1) begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    a = i;
                    b = j;
                    cin = k;
                    #10; // Allow transistor delay to settle

                    expected = a + b + cin;
                    if ({cout, sum} !== expected) begin
                        $display("[ERROR] Time=%0t | a=%b b=%b cin=%b | Expected=%b Got={%b, %b}",
                                 $time, a, b, cin, expected, cout, sum);
                        errors = errors + 1;
                    end
                end
            end
        end

        // Worst-case ripple delay test case (all propagate bits high)
        $display("\nRunning Worst-Case Carry Propagation Delay Test...");
        a = 4'b1111;
        b = 4'b0000;
        cin = 1'b0;
        #10;
        cin = 1'b1; // Trigger ripple through all 4 stages
        #10;
        if ({cout, sum} !== 5'b10000) begin
            $display("[ERROR] Worst-case ripple check failed!");
            errors = errors + 1;
        end else begin
            $display("[PASS] Worst-case ripple propagation successfully resolved {cout, sum}=5'b10000");
        end

        $display("------------------------------------------------------------");
        if (errors == 0) begin
            $display("ALL 513 TEST VECTORS PASSED SUCCESSFULLY. 0 ERRORS.");
        end else begin
            $display("TEST FAILED WITH %0d ERRORS.", errors);
        end
        $display("------------------------------------------------------------");
        $finish;
    end

endmodule
