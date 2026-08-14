module seq_multiplier4x3(input clk,rst, input [3:0] A, input [2:0] B, output reg [6:0] P);
reg [2:0] Q;
reg [2:0] count;
reg [6:0] temp;
always @(posedge clk or posedge rst) begin
 if(rst) begin Q<=B; temp<=0; P<=0; count<=0; end
 else if(count < 3) begin
  if(Q[0]) temp <= temp + (A << count);
  else temp <= temp;
  Q <= Q >> 1;
  count <= count + 1;
 end else P <= temp;
end
endmodule
