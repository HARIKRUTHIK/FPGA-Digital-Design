module fifo #(parameter WIDTH=8, parameter DEPTH=16)(
 input clk,input rst,input wr_en,input rd_en,
 input [WIDTH-1:0] data_in,
 output reg [WIDTH-1:0] data_out,
 output full,output empty
);
reg [WIDTH-1:0] mem [0:DEPTH-1];
reg [$clog2(DEPTH)-1:0] wr_ptr;
reg [$clog2(DEPTH)-1:0] rd_ptr;
reg [$clog2(DEPTH):0] count;
always @(posedge clk or posedge rst) begin
 if(rst) wr_ptr<=0;
 else if(wr_en && !full) begin
  mem[wr_ptr] <= data_in;
  if(wr_ptr==DEPTH-1) wr_ptr<=0; else wr_ptr<=wr_ptr+1;
 end
end
always @(posedge clk or posedge rst) begin
 if(rst) begin rd_ptr<=0; data_out<=0; end
 else if(rd_en && !empty) begin
  data_out<=mem[rd_ptr];
  if(rd_ptr==DEPTH-1) rd_ptr<=0; else rd_ptr<=rd_ptr+1;
 end
end
always @(posedge clk or posedge rst) begin
 if(rst) count<=0;
 else begin
  case({wr_en && !full,rd_en && !empty})
   2'b10: count<=count+1;
   2'b01: count<=count-1;
   default: count<=count;
  endcase
 end
end
assign full=(count==DEPTH);
assign empty=(count==0);
endmodule

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
