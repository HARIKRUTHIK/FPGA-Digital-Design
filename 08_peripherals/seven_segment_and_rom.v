module hex_to_7seg_full(input [3:0] hex,output reg [6:0] seg);
always @(*) begin
 case(hex)
 4'h0:seg=7'b1000000;4'h1:seg=7'b1111001;4'h2:seg=7'b0100100;4'h3:seg=7'b0110000;
 4'h4:seg=7'b0011001;4'h5:seg=7'b0010010;4'h6:seg=7'b0000010;4'h7:seg=7'b1111000;
 4'h8:seg=7'b0000000;4'h9:seg=7'b0010000;4'hA:seg=7'b0001000;4'hB:seg=7'b0000011;
 4'hC:seg=7'b1000110;4'hD:seg=7'b0100001;4'hE:seg=7'b0000110;4'hF:seg=7'b0001110;
 default:seg=7'b1111111;
 endcase
end
endmodule

module adder_7seg(input [3:0] a,b,output [6:0] HEX0,HEX1);
wire [4:0] sum;
assign sum=a+b;
wire [3:0] d0=sum%10,d1=sum/10;
hex_to_7seg_full h0(d0,HEX0);hex_to_7seg_full h1(d1,HEX1);
endmodule

module rom_display(input clk,input rst,output [6:0] HEX0,HEX1);
reg [3:0] addr;
reg [7:0] data[0:7];
initial begin data[0]=8'h23;data[1]=8'h45;data[2]=8'h67;data[3]=8'h89;data[4]=8'h12;data[5]=8'h34;data[6]=8'h56;data[7]=8'h78; end
always @(posedge clk or posedge rst) begin if(rst) addr<=0; else if(addr==7) addr<=0; else addr<=addr+1; end
wire [3:0] d0=data[addr][3:0],d1=data[addr][7:4];
hex_to_7seg_full h0(d0,HEX0);hex_to_7seg_full h1(d1,HEX1);
endmodule
