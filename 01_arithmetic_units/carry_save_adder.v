module csavea(input [3:0] x,y,z, output [3:0] sum, output [3:0] cout);
fulladder f0(x[0],y[0],z[0],sum[0],cout[0]);
fulladder f1(x[1],y[1],z[1],sum[1],cout[1]);
fulladder f2(x[2],y[2],z[2],sum[2],cout[2]);
fulladder f3(x[3],y[3],z[3],sum[3],cout[3]);
endmodule
