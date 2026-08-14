module adder_7seg(input [3:0] a,b,output [6:0] HEX0,HEX1);
wire [4:0] sum;
assign sum=a+b;
wire [3:0] d0=sum%10,d1=sum/10;
hex_to_7seg_full h0(d0,HEX0);hex_to_7seg_full h1(d1,HEX1);
endmodule
