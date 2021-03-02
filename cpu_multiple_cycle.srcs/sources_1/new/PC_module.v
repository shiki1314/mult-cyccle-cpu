`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 17:31:52
// Design Name: 
// Module Name: PC_module
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


module PC_module(PC_in,pc_en,PC,clk,rst);
    input wire [31:0]PC_in;
    input clk,rst,pc_en;
    output  reg [31:0]PC;

    always @(posedge clk) begin 
        if(rst) begin
             PC<= 0;
        end else  begin
             PC<=(pc_en)?PC_in:PC ;
        end
    end
endmodule
