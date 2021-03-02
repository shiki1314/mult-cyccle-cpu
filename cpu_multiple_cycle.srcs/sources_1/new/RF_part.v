`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 18:17:41
// Design Name: 
// Module Name: RF_part
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


module RF_part(clk,rst,rs,rt,rd,alu_out,data,Regdst,MemtoReg,RegWrite,reg_A,reg_B,regdata,addr);
    input  clk,rst;
    input  [4:0]rs,rt,rd;
    input  [31:0]alu_out,data;
    input Regdst,MemtoReg,RegWrite;
    input [7:0]addr;
    output [ 31:0]reg_A,reg_B,regdata;
    wire [4:0]wa;
    wire [31:0]wd;
    assign wa = Regdst? rd:rt;
    assign wd = MemtoReg? data:alu_out;
    regflie M1(.ra0(rs),
        .ra1(rt),
        .ra2(addr),
        .wa(wa),
        .wd(wd),
        .we(RegWrite),
        .clk(clk),
        .rst(rst),
        .rd0(reg_A),
        .rd1(reg_B),
        .rd2(regdata));
    
endmodule
