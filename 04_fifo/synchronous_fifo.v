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
