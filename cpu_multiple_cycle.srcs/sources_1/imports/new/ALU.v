`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/14 20:39:46
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(a,b,s,y,f,Zero);
       input [31:0] a;
       input [31:0] b;
       input [2:0] s;
       output   reg [31:0] y;
       output  [2:0] f;
       reg CF,V,Z;
       output  Zero;

       parameter ADD=5'h00;
       parameter SUB=5'h01;
       parameter AND=5'h02;
       parameter OR=5'h03;
       parameter NOT=5'h04;
       parameter XOR=5'h05;
       parameter SLT=5'h06;
       parameter NOR=5'h07;
       


       
always@(*)
begin
    case(s)
        ADD:begin
            {CF,y}=a+b;
            V=(a[31]==b[31])&&(y[31]==~a[31]);
         end
        SUB:begin
            {CF,y}=a-b;
            V=(a[31]==~b[31])&&(y[31]==~b[31]);
        end
        AND:begin
            y=a&b;
            V=0;
            CF=0;
        end
        OR:begin
            y=a|b;
            V=0;
            CF=0;
        end
        NOT:begin
            y=~a;
            V=0;
            CF=0;
        end
        XOR:begin
            y=a^b;
            V=0;
            CF=0;
        end 
        SLT: begin
              case ({a[31], b[31]})
                2'b00: begin
                  y = a > b ? 0 : 1;
                end
                2'b01: begin
                  y = 0;
                end
                2'b10: begin
                  y = 1;
                end
                default: begin
                  y = a > b ? 0 : 1;
                end
              endcase
        end
        NOR: begin
              y = ~(a | b);
              CF = 0;
              V = 0;
        end
    endcase
    Z=(y==0);
end
assign f ={CF,V,Z} ;
assign Zero=Z;
       
endmodule
