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
