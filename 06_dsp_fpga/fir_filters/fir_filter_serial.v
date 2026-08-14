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
