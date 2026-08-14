module rom_display(input clk,input rst,output [6:0] HEX0,HEX1);
reg [3:0] addr;
reg [7:0] data[0:7];
initial begin data[0]=8'h23;data[1]=8'h45;data[2]=8'h67;data[3]=8'h89;data[4]=8'h12;data[5]=8'h34;data[6]=8'h56;data[7]=8'h78; end
always @(posedge clk or posedge rst) begin if(rst) addr<=0; else if(addr==7) addr<=0; else addr<=addr+1; end
wire [3:0] d0=data[addr][3:0],d1=data[addr][7:4];
hex_to_7seg_full h0(d0,HEX0);hex_to_7seg_full h1(d1,HEX1);
endmodule
