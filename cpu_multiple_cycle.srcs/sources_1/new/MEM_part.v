`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 17:47:28
// Design Name: 
// Module Name: MEM_part
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


module MEM_part(addr,PC,lord,writerdata,address,MemRead,MemWrite,data,instr,IRWrite,clk,rst,memdata,Address);
    input wire [31:0]PC,writerdata,address;
    input wire lord,MemRead,MemWrite,IRWrite,clk,rst;
    input [7:0]addr;
    output [31:0]memdata;
    output reg [31:0]instr;
    output reg [31:0]data;
    output [31:0] Address;
    wire [31:0]mem_out;

assign Address = lord?address:PC;
// assign data = mem_out;
dist_mem_gen_0 M(.a(Address[9:2]),
    .d(writerdata),
    .dpra(addr),
    .clk(clk),
    .we(MemWrite),
    .dpo(memdata),
    .spo(mem_out));

always @(posedge clk) begin 
    if(IRWrite)begin
        instr<=mem_out;
    end
        data <= mem_out;
end

endmodule
