module cselecta(input [3:0] a,b, input cin, output [3:0] sum, output cout);
wire [3:0] s0,s1;
wire c0,c1;
rca_4bit r0(a,b,1'b0,s0,c0);
rca_4bit r1(a,b,1'b1,s1,c1);
assign sum = cin ? s1 : s0;
assign cout = cin ? c1 : c0;
endmodule
