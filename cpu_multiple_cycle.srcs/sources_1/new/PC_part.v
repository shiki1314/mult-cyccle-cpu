`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 17:05:28
// Design Name: 
// Module Name: PC_part
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


module PC_part(Zero,PCWriterCond,Pcbranch,PC,lord,PCplus,PCJump,clk,rst,PCWrite,PCSource,is_BEQ);

input  Zero,PCWriterCond,lord,clk,rst,PCWrite,is_BEQ;
input [1:0]PCSource;
input  [31:0]PCJump,Pcbranch,PCplus;
output [31:0]PC;
wire [31:0]PC_out;
wire pc_en;
// assign pc_en = (is_J)?0:((Zero & PCWriterCond) | PCWrite);
assign pc_en = is_BEQ? Zero & PCWriterCond | PCWrite : ~Zero & PCWriterCond | PCWrite;
// always @(*) begin 
//     if(is_J)begin
//         pc_en = 0;
//     end else pc_en =1;
// end
MUX_3ways M1 (.PCplus(PCplus),
    .PCJump(PCJump),
    .Pcbranch(Pcbranch),
    .PCSource(PCSource),
    .PC_out(PC_out));
// always @(posedge clk ) begin
//     if(rst) begin
//          PC<= 0;
//     end else if(pc_en) begin
//          PC<=PC_out ;
//     end
// end PC_in,pc_en,PC,clk,rst
PC_module M2(.PC_in(PC_out),
    .pc_en(pc_en),
    .PC(PC),
    .clk(clk),
    .rst(rst));
endmodule
