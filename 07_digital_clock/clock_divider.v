module clk_div(input clk,input rst,output reg clk_out);
reg [25:0] count;
always @(posedge clk or posedge rst) begin
 if(rst) begin count<=0;clk_out<=0; end
 else if(count==25_000_000-1) begin count<=0;clk_out<=~clk_out; end
 else count<=count+1;
end
endmodule
