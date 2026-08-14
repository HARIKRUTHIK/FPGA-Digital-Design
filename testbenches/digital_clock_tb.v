`timescale 1ns/1ps
module real_clock_tb;
reg clk,rst;
wire [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
wire [5:0] sec_out,min_out; wire [4:0] hour_out;
real_clock uut(.clk(clk),.rst(rst),.HEX0(HEX0),.HEX1(HEX1),.HEX2(HEX2),.HEX3(HEX3),.HEX4(HEX4),.HEX5(HEX5),.sec_out(sec_out),.min_out(min_out),.hour_out(hour_out));
always #5 clk=~clk;
initial begin clk=0;rst=0;#20;rst=1;#5000;$stop;end
endmodule
