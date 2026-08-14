module clk_div(input clk,input rst,output reg clk_out);
reg [25:0] count;
always @(posedge clk or posedge rst) begin
 if(rst) begin count<=0;clk_out<=0; end
 else if(count==25_000_000-1) begin count<=0;clk_out<=~clk_out; end
 else count<=count+1;
end
endmodule

module digital_clock(input clk,input rst,output reg [5:0] sec,output reg [5:0] min,output reg [4:0] hour);
wire clk1;
clk_div d0(clk,rst,clk1);
always @(posedge clk1 or posedge rst) begin if(rst) sec<=0; else if(sec==59) sec<=0; else sec<=sec+1; end
always @(posedge clk1 or posedge rst) begin
 if(rst) min<=0;
 else if(sec==59) begin if(min==59) min<=0; else min<=min+1; end
end
always @(posedge clk1 or posedge rst) begin
 if(rst) hour<=0;
 else if(sec==59 && min==59) begin if(hour==23) hour<=0; else hour<=hour+1; end
end
endmodule

module real_clock(
 input clk,input rst,
 output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,
 output [5:0] sec_out,min_out,
 output [4:0] hour_out
);
reg [25:0] count;
reg tick_1hz;
always @(posedge clk or negedge rst) begin
 if(!rst) begin count<=0;tick_1hz<=0; end
 else if(count==49_999_999) begin count<=0;tick_1hz<=1; end
 else begin count<=count+1;tick_1hz<=0; end
end
reg [5:0] sec,min;
reg [4:0] hour;
always @(posedge clk or negedge rst) begin
 if(!rst) begin sec<=0;min<=0;hour<=0; end
 else if(tick_1hz) begin
  if(sec==59) begin
   sec<=0;
   if(min==59) begin min<=0; if(hour==23) hour<=0; else hour<=hour+1; end
   else min<=min+1;
  end else sec<=sec+1;
 end
end
assign sec_out=sec; assign min_out=min; assign hour_out=hour;
wire [3:0] sec_l=sec%10,sec_h=sec/10,min_l=min%10,min_h=min/10,hour_l=hour%10,hour_h=hour/10;
hex_to_7seg d0(sec_l,HEX0);hex_to_7seg d1(sec_h,HEX1);hex_to_7seg d2(min_l,HEX2);hex_to_7seg d3(min_h,HEX3);hex_to_7seg d4(hour_l,HEX4);hex_to_7seg d5(hour_h,HEX5);
endmodule

module hex_to_7seg(input [3:0] hex,output reg [6:0] seg);
always @(*) begin
 case(hex)
 4'h0:seg=7'b1000000;4'h1:seg=7'b1111001;4'h2:seg=7'b0100100;4'h3:seg=7'b0110000;
 4'h4:seg=7'b0011001;4'h5:seg=7'b0010010;4'h6:seg=7'b0000010;4'h7:seg=7'b1111000;
 4'h8:seg=7'b0000000;4'h9:seg=7'b0010000;default:seg=7'b1111111;
 endcase
end
endmodule
