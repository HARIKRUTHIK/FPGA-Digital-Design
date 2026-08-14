module ram_file(
 input clk,
 input wen,
 input [7:0] din,
 input [5:0] addr,
 output reg [7:0] dout
);
reg [7:0] mem [0:49];
initial begin
 $readmemh("input.txt",mem);
end
always @(posedge clk) begin
 if(wen) mem[addr] <= din;
 else dout <= mem[addr];
end
endmodule
