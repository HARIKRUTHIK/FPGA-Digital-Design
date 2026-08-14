module csaveafinal(input [3:0] sum,cout, output [4:0] result);
assign result = sum + (cout << 1);
endmodule
