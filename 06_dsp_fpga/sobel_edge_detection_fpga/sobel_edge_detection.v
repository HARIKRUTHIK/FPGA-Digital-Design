module sobel_edge_detection #(parameter WIDTH=8)(
 input wire clk,input wire rst,
 input wire [WIDTH-1:0] pixel_in,
 input wire [WIDTH-1:0] pixel_in_top,pixel_in_bottom,pixel_in_left,pixel_in_right,
 input wire [WIDTH-1:0] pixel_in_tl,pixel_in_tr,pixel_in_bl,pixel_in_br,
 output reg [WIDTH-1:0] edge_out,output reg ready
);
reg signed [7:0] sobel_x[0:2][0:2];
reg signed [7:0] sobel_y[0:2][0:2];
reg signed [15:0] gradient_x,gradient_y;
reg signed [31:0] gradient_magnitude;
always @(posedge clk or posedge rst) begin
 if(rst) begin
  sobel_x[0][0]<=-1;sobel_x[0][1]<=0;sobel_x[0][2]<=1;
  sobel_x[1][0]<=-2;sobel_x[1][1]<=0;sobel_x[1][2]<=2;
  sobel_x[2][0]<=-1;sobel_x[2][1]<=0;sobel_x[2][2]<=1;
  sobel_y[0][0]<=-1;sobel_y[0][1]<=-2;sobel_y[0][2]<=-1;
  sobel_y[1][0]<=0;sobel_y[1][1]<=0;sobel_y[1][2]<=0;
  sobel_y[2][0]<=1;sobel_y[2][1]<=2;sobel_y[2][2]<=1;
  gradient_x<=0;gradient_y<=0;gradient_magnitude<=0;edge_out<=0;ready<=0;
 end else begin
  gradient_x <= (sobel_x[0][0]*pixel_in_tl)+(sobel_x[0][1]*pixel_in_top)+(sobel_x[0][2]*pixel_in_tr)+
                (sobel_x[1][0]*pixel_in_left)+(sobel_x[1][1]*pixel_in)+(sobel_x[1][2]*pixel_in_right)+
                (sobel_x[2][0]*pixel_in_bl)+(sobel_x[2][1]*pixel_in_bottom)+(sobel_x[2][2]*pixel_in_br);
  gradient_y <= (sobel_y[0][0]*pixel_in_tl)+(sobel_y[0][1]*pixel_in_top)+(sobel_y[0][2]*pixel_in_tr)+
                (sobel_y[1][0]*pixel_in_left)+(sobel_y[1][1]*pixel_in)+(sobel_y[1][2]*pixel_in_right)+
                (sobel_y[2][0]*pixel_in_bl)+(sobel_y[2][1]*pixel_in_bottom)+(sobel_y[2][2]*pixel_in_br);
  gradient_magnitude <= (gradient_x*gradient_x)+(gradient_y*gradient_y);
  if(gradient_magnitude[31:8]>8'd255) edge_out<=8'd255;
  else edge_out<=gradient_magnitude[15:8];
  ready<=1'b1;
 end
end
endmodule
