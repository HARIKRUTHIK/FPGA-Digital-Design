`timescale 1ns/1ps

module tb_fsm;

    reg clk;
    reg rst;
    reg [1:0] coin; // 2'b01 = 5 Rs, 2'b10 = 10 Rs
    wire out_mealy;
    wire out_moore;

    mealy_vending uut_mealy (
        .clk(clk),
        .rst(rst),
        .coin(coin),
        .out(out_mealy)
    );

    moore_vending uut_moore (
        .clk(clk),
        .rst(rst),
        .coin(coin),
        .out(out_moore)
    );

    always #5 clk = ~clk;

    integer errors = 0;

    initial begin
        clk = 0;
        rst = 1;
        coin = 2'b00;
        #15;
        rst = 0;
        #10;

        $display("=================================================================");
        $display("   FINITE STATE MACHINE (FSM) AUTOMATED VERIFICATION");
        $display("=================================================================");

        // Test Scenario 1: Insert 5 then 10 -> Total 15 (Dispense)
        $display("[SCENARIO 1] Coin sequence: 5 Rs -> 10 Rs (Total 15)");
        @(posedge clk); #1 coin = 2'b01; // S5
        @(posedge clk); #1 coin = 2'b10; // S5 + 10 -> Mealy triggers immediately, Moore transitions to DISPENSE
        #2;
        if (!out_mealy) begin
            $display("[ERROR] Mealy did not assert output on 5+10 sequence");
            errors = errors + 1;
        end
        @(posedge clk); #2 coin = 2'b00;
        if (!out_moore) begin
            $display("[ERROR] Moore did not assert output on DISPENSE state");
            errors = errors + 1;
        end
        @(posedge clk); #2;

        // Reset
        rst = 1; #10; rst = 0; #10;

        // Test Scenario 2: Insert 10 then 5 -> Total 15 (Dispense)
        $display("[SCENARIO 2] Coin sequence: 10 Rs -> 5 Rs (Total 15)");
        @(posedge clk); #1 coin = 2'b10; // S10
        @(posedge clk); #1 coin = 2'b01; // S10 + 5 -> Dispense
        #2;
        if (!out_mealy) begin
            $display("[ERROR] Mealy did not assert output on 10+5 sequence");
            errors = errors + 1;
        end
        @(posedge clk); #2 coin = 2'b00;
        if (!out_moore) begin
            $display("[ERROR] Moore did not assert output on DISPENSE state");
            errors = errors + 1;
        end
        @(posedge clk); #2;

        // Reset
        rst = 1; #10; rst = 0; #10;

        // Test Scenario 3: Insert 5, 5, 5 -> Total 15 (Dispense)
        $display("[SCENARIO 3] Coin sequence: 5 Rs -> 5 Rs -> 5 Rs (Total 15)");
        @(posedge clk); #1 coin = 2'b01; // S5
        @(posedge clk); #1 coin = 2'b01; // S10
        @(posedge clk); #1 coin = 2'b01; // S15 -> Dispense
        #2;
        if (!out_mealy) begin
            $display("[ERROR] Mealy did not assert output on 5+5+5 sequence");
            errors = errors + 1;
        end
        @(posedge clk); #2 coin = 2'b00;
        if (!out_moore) begin
            $display("[ERROR] Moore did not assert output on DISPENSE state");
            errors = errors + 1;
        end

        $display("-----------------------------------------------------------------");
        if (errors == 0) begin
            $display("[RESULT] ALL FSM PROTOCOL CHECKS PASSED (Zero Discrepancies)");
        end else begin
            $display("[RESULT] FAILED: %0d Discrepancies Detected", errors);
        end
        $display("=================================================================");
        $finish;
    end

endmodule
