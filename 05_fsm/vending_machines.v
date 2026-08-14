module mealy_vending(input clk,input rst,input [1:0] coin,output reg out);
reg [1:0] state,next;
parameter S0=2'b00,S5=2'b01,S10=2'b10;
always @(posedge clk or posedge rst) begin
 if(rst) state<=S0; else state<=next;
end
always @(*) begin
 next=state; out=0;
 case(state)
  S0: begin if(coin==2'b01) next=S5; else if(coin==2'b10) next=S10; end
  S5: begin if(coin==2'b01) next=S10; else if(coin==2'b10) begin next=S0; out=1; end end
  S10: begin if(coin==2'b01) begin next=S0; out=1; end end
  default: next=S0;
 endcase
end
endmodule

module moore_vending(input clk,input rst,input [1:0] coin,output reg out);
reg [1:0] state;
parameter S0=2'b00,S5=2'b01,S10=2'b10,DISPENSE=2'b11;
always @(posedge clk or posedge rst) begin
 if(rst) state<=S0;
 else begin
  case(state)
   S0: if(coin==2'b01) state<=S5; else if(coin==2'b10) state<=S10;
   S5: if(coin==2'b01) state<=S10; else if(coin==2'b10) state<=DISPENSE;
   S10: if(coin==2'b01) state<=DISPENSE;
   DISPENSE: state<=S0;
   default: state<=S0;
  endcase
 end
end
always @(*) begin
 if(state==DISPENSE) out=1; else out=0;
end
endmodule
