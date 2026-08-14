module fir_filter_serial(
 input clk,input rst,input signed [7:0] x,
 output reg signed [15:0] y
);
reg signed [7:0] x0,x1,x2,x3;
parameter h0=4,h1=3,h2=2,h3=1;
always @(posedge clk or posedge rst) begin
 if(rst) begin x0<=0;x1<=0;x2<=0;x3<=0;y<=0; end
 else begin
  x3<=x2; x2<=x1; x1<=x0; x0<=x;
  y<=h0*x0+h1*x1+h2*x2+h3*x3;
 end
end
endmodule

module fir_filter_pipelined(
 input clk,input rst,input signed [7:0] x,
 output reg signed [15:0] y
);
reg signed [7:0] x0,x1,x2,x3;
reg signed [15:0] m0,m1,m2,m3;
reg signed [15:0] s1,s2;
parameter h0=4,h1=3,h2=2,h3=1;
always @(posedge clk or posedge rst) begin
 if(rst) begin
  x0<=0;x1<=0;x2<=0;x3<=0;
  m0<=0;m1<=0;m2<=0;m3<=0;s1<=0;s2<=0;y<=0;
 end else begin
  x3<=x2; x2<=x1; x1<=x0; x0<=x;
  m0<=h0*x0; m1<=h1*x1; m2<=h2*x2; m3<=h3*x3;
  s1<=m0+m1; s2<=m2+m3;
  y<=s1+s2;
 end
end
endmodule

module fir_serial_16bit(
 input clk,input reset,input [15:0] x,output reg [31:0] y
);
reg signed [15:0] h[0:3];
reg signed [15:0] x_reg[0:3];
reg [1:0] count;
always @(posedge clk or posedge reset) begin
 if(reset) begin
  h[0]<=16'sd4; h[1]<=16'sd3; h[2]<=16'sd2; h[3]<=16'sd1;
  x_reg[0]<=0;x_reg[1]<=0;x_reg[2]<=0;x_reg[3]<=0;y<=0;count<=0;
 end else begin
  if(count==0) begin x_reg[3]<=x_reg[2];x_reg[2]<=x_reg[1];x_reg[1]<=x_reg[0];x_reg[0]<=x;y<=0; end
  y<=y+(h[count]*x_reg[count]);
  if(count==3) count<=0; else count<=count+1'b1;
 end
end
endmodule

module fir_filter_parallel_16bit(
 input clk,input reset,input [15:0] x,output reg [31:0] y
);
parameter N=4;
reg signed [15:0] h[0:N-1];
reg signed [15:0] x_reg[0:N-1];
reg signed [31:0] m[0:N-1];
reg signed [31:0] s1,s2;
integer i;
always @(posedge clk or posedge reset) begin
 if(reset) begin
  h[0]<=16'sd4;h[1]<=16'sd3;h[2]<=16'sd2;h[3]<=16'sd1;
  for(i=0;i<N;i=i+1) begin x_reg[i]<=0;m[i]<=0; end
  s1<=0;s2<=0;y<=0;
 end else begin
  x_reg[3]<=x_reg[2];x_reg[2]<=x_reg[1];x_reg[1]<=x_reg[0];x_reg[0]<=x;
  m[0]<=h[0]*x_reg[0];m[1]<=h[1]*x_reg[1];m[2]<=h[2]*x_reg[2];m[3]<=h[3]*x_reg[3];
  s1<=m[0]+m[1];s2<=m[2]+m[3];y<=s1+s2;
 end
end
endmodule
