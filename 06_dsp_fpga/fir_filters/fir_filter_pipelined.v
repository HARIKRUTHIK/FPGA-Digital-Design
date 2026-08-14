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
