module cskipa(input [3:0] a,b, input cin, output [3:0] sum, output cout);
wire c1;
wire [3:0] P;
wire Pblock;
assign P = a ^ b;
rca_4bit r0(a,b,cin,sum,c1);
assign Pblock = P[0] & P[1] & P[2] & P[3];
assign cout = Pblock ? cin : c1;
endmodule
