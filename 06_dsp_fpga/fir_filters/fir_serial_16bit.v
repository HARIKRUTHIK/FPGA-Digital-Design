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
