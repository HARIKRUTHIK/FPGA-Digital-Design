module async_fifo(
 input wclk,input rclk,input rst,input wren,input rden,input [7:0] din,
 output reg [7:0] dout,output full,output empty
);
reg [7:0] mem [0:7];
reg [3:0] wptr,rptr;
reg [3:0] rptr_w1,rptr_w2,wptr_r1,wptr_r2;
always @(posedge wclk or posedge rst) begin
 if(rst) wptr<=0;
 else if(wren && !full) begin mem[wptr[2:0]]<=din; wptr<=wptr+1; end
end
always @(posedge rclk or posedge rst) begin
 if(rst) begin rptr<=0; dout<=0; end
 else if(rden && !empty) begin dout<=mem[rptr[2:0]]; rptr<=rptr+1; end
end
always @(posedge wclk or posedge rst) begin
 if(rst) begin rptr_w1<=0; rptr_w2<=0; end
 else begin rptr_w1<=rptr; rptr_w2<=rptr_w1; end
end
always @(posedge rclk or posedge rst) begin
 if(rst) begin wptr_r1<=0; wptr_r2<=0; end
 else begin wptr_r1<=wptr; wptr_r2<=wptr_r1; end
end
assign empty=(wptr==rptr_r2);
assign full=((wptr[2:0]==rptr_w2[2:0]) && (wptr[3]!=rptr_w2[3]));
endmodule
