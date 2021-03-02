`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 14:23:07
// Design Name: 
// Module Name: regflie
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


module regflie(ra0,ra1,ra2,wa,wd,we,clk,rst,rd0,rd1,rd2);
    parameter addr=5;
    parameter num=1<<addr;


    input [addr-1:0]ra0;
    input [addr-1:0]ra1;
    input [addr-1:0]ra2;
    input [addr-1:0]wa;
    input [num-1:0]wd;
    input we;
    input clk;
    input rst;
    output [num-1:0]rd0;
    output [num-1:0]rd1;
    output [num-1:0]rd2;

    reg [num-1:0] regs [num-1:0];
    integer i;
    initial begin
        for(i=0;i<num;i=i+1)begin
            regs[i]=0;
        end
    end
    always @(posedge clk) begin 
            if(rst) 
            for(i=0;i<num;i=i+1)begin
            regs[i]<= 0;
            end 
            else begin
            regs[wa]<=we?wd :regs[wa];
            end
        end
assign rd0=regs[ra0];
assign rd1=regs[ra1]; 
assign rd2=regs[ra2];   
endmodule
