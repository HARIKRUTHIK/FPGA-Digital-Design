`timescale 1ns/1ps
module fir_serial_tb;
reg clk,reset; reg [15:0] x; wire [31:0] y;
fir_serial_16bit uut(.clk(clk),.reset(reset),.x(x),.y(y));
always #5 clk=~clk;
initial begin clk=0;reset=1;x=0;#10;reset=0;#10 x=16'd4;#10 x=16'd4;#10 x=16'd4;#10 x=16'd4;#100;$finish;end
initial $monitor("Time=%0t | x=%d | y=%d | count=%d",$time,x,y,uut.count);
endmodule

module fir_filter_tb;
reg clk,reset; reg [15:0] x; wire [31:0] y;
fir_filter_parallel_16bit uut(.clk(clk),.reset(reset),.x(x),.y(y));
always #5 clk=~clk;
initial begin clk=0;reset=1;x=0;#10;reset=0;#10 x=1;#10 x=2;#10 x=3;#10 x=4;#10 x=5;#10 x=6;#100;$finish;end
initial $monitor("Time=%0t | x=%d | y=%d",$time,x,y);
endmodule
