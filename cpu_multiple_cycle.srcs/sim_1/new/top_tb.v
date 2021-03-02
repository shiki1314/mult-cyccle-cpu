`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/09 15:03:40
// Design Name: 
// Module Name: top_tb
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


module DDU_tb();

    reg clk,cont,step,mem,inc,dec,rst;
    integer i;
    initial begin
        rst = 1;
        clk = 0;
        mem = 0;
        step = 0;
        inc = 0;
        dec = 0;
        cont = 1;
        
        #3 rst =0 ;
        
        #80 i=0;

        for(i=0;i<100;i=i+1)begin
            #3 inc = ~inc;
        end
    end
    always #1 clk = ~clk;
    DDU DUT(.clk(clk),
        .cont(cont),
        .rst(rst),
        .mem(mem),
        .step(step),
        .inc(inc),
        .dec(dec));


endmodule

