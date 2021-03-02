`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 15:33:34
// Design Name: 
// Module Name: counter
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


module counter  (d,pe,ce,rst,clk,q,clk_1000HZ);
        input [9:0]d;
        input pe;
        input ce;
        input rst;
        input clk;
        output reg [20:0] q;
        output reg clk_1000HZ;
        initial begin
            q=0;
            clk_1000HZ=0;
        end
        always @(posedge clk && ce) begin 
            if(rst) begin
                 q<= 0;
                 clk_1000HZ<=0;
            end else if(pe) begin
                 q<=d ;
            end else  begin
                q<=q+1;
            end
            if (q==99999) begin
                q<=0;
                clk_1000HZ<=~clk_1000HZ;
            end
        end
endmodule
