module fulladder(input a,b,cin, output sum,cout);
assign sum = a ^ b ^ cin;
assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module rca_4bit(input [3:0] a,b, input cin, output [3:0] sum, output cout);
wire c1,c2,c3;
fulladder f0(a[0],b[0],cin,sum[0],c1);
fulladder f1(a[1],b[1],c1,sum[1],c2);
fulladder f2(a[2],b[2],c2,sum[2],c3);
fulladder f3(a[3],b[3],c3,sum[3],cout);
endmodule

module adder_subtractor(input [3:0] a,b, input mode, output [3:0] sum, output cout);
wire [3:0] bx;
assign bx = b ^ {4{mode}};
rca_4bit uut(a,bx,mode,sum,cout);
endmodule

module cla_4bit(input [3:0] a,b, input cin, output [3:0] sum, output cout);
wire [3:0] p,g;
wire c1,c2,c3;
assign p = a ^ b;
assign g = a & b;
assign c1 = g[0] | (p[0] & cin);
assign c2 = g[1] | (p[1] & c1);
assign c3 = g[2] | (p[2] & c2);
assign cout = g[3] | (p[3] & c3);
assign sum[0] = p[0] ^ cin;
assign sum[1] = p[1] ^ c1;
assign sum[2] = p[2] ^ c2;
assign sum[3] = p[3] ^ c3;
endmodule

module cselecta(input [3:0] a,b, input cin, output [3:0] sum, output cout);
wire [3:0] s0,s1;
wire c0,c1;
rca_4bit r0(a,b,1'b0,s0,c0);
rca_4bit r1(a,b,1'b1,s1,c1);
assign sum = cin ? s1 : s0;
assign cout = cin ? c1 : c0;
endmodule

module cskipa(input [3:0] a,b, input cin, output [3:0] sum, output cout);
wire c1;
wire [3:0] P;
wire Pblock;
assign P = a ^ b;
rca_4bit r0(a,b,cin,sum,c1);
assign Pblock = P[0] & P[1] & P[2] & P[3];
assign cout = Pblock ? cin : c1;
endmodule

module csavea(input [3:0] x,y,z, output [3:0] sum, output [3:0] cout);
fulladder f0(x[0],y[0],z[0],sum[0],cout[0]);
fulladder f1(x[1],y[1],z[1],sum[1],cout[1]);
fulladder f2(x[2],y[2],z[2],sum[2],cout[2]);
fulladder f3(x[3],y[3],z[3],sum[3],cout[3]);
endmodule

module csaveafinal(input [3:0] sum,cout, output [4:0] result);
assign result = sum + (cout << 1);
endmodule

module consuma(input [3:0] a,b, input cin, output [3:0] sum, output cout);
wire s0,c0;
fulladder f0(a[0],b[0],cin,s0,c0);
wire s10,s11,c10,c11;
fulladder f1(a[1],b[1],1'b0,s10,c10);
fulladder f2(a[1],b[1],1'b1,s11,c11);
wire s1,c1;
assign s1 = c0 ? s11 : s10;
assign c1 = c0 ? c11 : c10;
wire s20,s21,c20,c21;
fulladder f3(a[2],b[2],1'b0,s20,c20);
fulladder f4(a[2],b[2],1'b1,s21,c21);
wire s2,c2;
assign s2 = c1 ? s21 : s20;
assign c2 = c1 ? c21 : c20;
wire s30,s31,c30,c31;
fulladder f5(a[3],b[3],1'b0,s30,c30);
fulladder f6(a[3],b[3],1'b1,s31,c31);
wire s3;
assign s3 = c2 ? s31 : s30;
assign cout = c2 ? c31 : c30;
assign sum = {s3,s2,s1,s0};
endmodule
