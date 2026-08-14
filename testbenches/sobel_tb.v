`timescale 1ns/1ps
module tb_sobel_edge_detection;
parameter WIDTH=8;
reg clk,rst;
reg [WIDTH-1:0] pixel_in,pixel_in_top,pixel_in_bottom,pixel_in_left,pixel_in_right,pixel_in_tl,pixel_in_tr,pixel_in_bl,pixel_in_br;
wire [WIDTH-1:0] edge_out; wire ready;
sobel_edge_detection #(WIDTH) uut(.clk(clk),.rst(rst),.pixel_in(pixel_in),.pixel_in_top(pixel_in_top),.pixel_in_bottom(pixel_in_bottom),.pixel_in_left(pixel_in_left),.pixel_in_right(pixel_in_right),.pixel_in_tl(pixel_in_tl),.pixel_in_tr(pixel_in_tr),.pixel_in_bl(pixel_in_bl),.pixel_in_br(pixel_in_br),.edge_out(edge_out),.ready(ready));
always #5 clk=~clk;
initial begin
 clk=0;rst=1;pixel_in=0;pixel_in_top=0;pixel_in_bottom=0;pixel_in_left=0;pixel_in_right=0;pixel_in_tl=0;pixel_in_tr=0;pixel_in_bl=0;pixel_in_br=0;
 #10;rst=0;
 pixel_in=50;pixel_in_top=50;pixel_in_bottom=50;pixel_in_left=50;pixel_in_right=50;pixel_in_tl=50;pixel_in_tr=50;pixel_in_bl=50;pixel_in_br=50;
 #10;
 pixel_in=10;pixel_in_top=10;pixel_in_bottom=255;pixel_in_left=10;pixel_in_right=10;pixel_in_tl=10;pixel_in_tr=10;pixel_in_bl=255;pixel_in_br=255;
 #10;
 pixel_in=10;pixel_in_top=10;pixel_in_bottom=10;pixel_in_left=10;pixel_in_right=255;pixel_in_tl=10;pixel_in_tr=255;pixel_in_bl=10;pixel_in_br=255;
 #10;
 pixel_in=128;pixel_in_top=50;pixel_in_bottom=200;pixel_in_left=50;pixel_in_right=200;pixel_in_tl=0;pixel_in_tr=100;pixel_in_bl=150;pixel_in_br=255;
 #20;$finish;
end
initial $monitor("Time=%0t | Edge=%d | Ready=%b",$time,edge_out,ready);
endmodule
