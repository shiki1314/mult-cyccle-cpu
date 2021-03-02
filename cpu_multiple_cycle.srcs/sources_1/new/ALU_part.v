`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 20:17:32
// Design Name: 
// Module Name: ALU_part
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


module ALU_part(clk,rst,PC,reg_A,reg_B,Imm,ALUsrcB,ALUSrcA,AlUcontrol,Zero,alu_result, alu_out);
    input  clk,rst;
    input  [31:0]PC,reg_A,reg_B,Imm;
    input [1:0]ALUsrcB;
    input ALUSrcA;
    input [4:0]AlUcontrol;
    output Zero;
    output [31:0]alu_result;
    output reg [31:0]alu_out;
    wire [31:0]a,b;
    assign a = ALUSrcA?reg_A:PC;
    
ALU M1(.a(a),
    .b(b),
    .s(AlUcontrol),
    .Zero(Zero),
    .y(alu_result));
MUX_4ways M2(.din1(reg_B),
    .din2(4),
    .din3(Imm),
    .din4(Imm<<2),
    .dout(b),
    .ALUsrcB(ALUsrcB));
always @(posedge clk) begin 
    alu_out<=alu_result;
end
endmodule
