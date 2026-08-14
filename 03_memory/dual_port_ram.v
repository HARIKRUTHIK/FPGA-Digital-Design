module dual_port_ram(
 input clk,
 input wen,
 input [7:0] din,
 input [5:0] waddr,
 input [5:0] raddr,
 output reg [7:0] dout
);
reg [7:0] mem [0:49];
always @(posedge clk) begin
 if(wen) mem[waddr] <= din;
 dout <= mem[raddr];
end
endmodule
