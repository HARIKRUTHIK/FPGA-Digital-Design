module digital_clock(input clk,input rst,output reg [5:0] sec,output reg [5:0] min,output reg [4:0] hour);
wire clk1;
clk_div d0(clk,rst,clk1);
always @(posedge clk1 or posedge rst) begin if(rst) sec<=0; else if(sec==59) sec<=0; else sec<=sec+1; end
always @(posedge clk1 or posedge rst) begin
 if(rst) min<=0;
 else if(sec==59) begin if(min==59) min<=0; else min<=min+1; end
end
always @(posedge clk1 or posedge rst) begin
 if(rst) hour<=0;
 else if(sec==59 && min==59) begin if(hour==23) hour<=0; else hour<=hour+1; end
end
endmodule
