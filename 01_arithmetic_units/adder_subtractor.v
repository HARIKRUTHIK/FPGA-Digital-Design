module adder_subtractor(input [3:0] a,b, input mode, output [3:0] sum, output cout);
wire [3:0] bx;
assign bx = b ^ {4{mode}};
rca_4bit uut(a,bx,mode,sum,cout);
endmodule
