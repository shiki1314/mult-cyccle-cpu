`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/09 13:48:23
// Design Name: 
// Module Name: ALU_control_part
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


module ALU_control_part(op,funct,ALUOp,AlUcontrol);
    input [5:0]op,funct;
    input [1:0]ALUOp;
    output reg [4:0]AlUcontrol;
    parameter ADDi=6'b001000,SLTi=6'b001010,ANDi=6'b001100,ORi=6'b001101,XORi=6'b001110;
    parameter ADD = 3'b000, SUB = 3'b001, AND = 3'b010, OR = 3'b011;
    parameter NOT = 3'b100, XOR = 3'b101, SLT = 3'b110, NOR = 3'b111;
    parameter ADD_funct=6'b100000,SUB_funct=6'b100010,AND_funct=6'b100100,
              OR_funct=6'b100101,XOR_funct=6'b100110,SLT_funct=6'b101010,
              NOR_funct=6'b100111;
    reg [4:0]R_out,I_out;
    always @(*) begin 
        case(ALUOp)
            2'b00:begin
                AlUcontrol=ADD;
            end // 2'b00:
            2'b01:begin
                AlUcontrol=SUB;
            end // 2'b01:
            2'b10:begin
                AlUcontrol=R_out;
            end // 2'b10:
            default : begin
                AlUcontrol=I_out;
            end // default :
        endcase // ALUOp
    end
    always @(*) begin 
        case(funct)
            ADD_funct:begin
                R_out=ADD;
            end
            SUB_funct:begin
                R_out=SUB;
            end
            AND_funct:begin
                R_out=AND;
            end
            OR_funct:begin
                R_out=OR;
            end
            XOR_funct:begin
                R_out=XOR;
            end
            SLT_funct:begin
                R_out=SLT;
            end
            NOR_funct:begin
                R_out=NOR;
            end
            default:begin
                R_out=ADD;
            end
        endcase // funct
    end
    always @(*) begin 
        case(op)
            ADDi:begin
                I_out=ADD;
            end
            ANDi:begin
                I_out=AND;
            end
            ORi:begin
                I_out=OR;
            end
            XORi:begin
                I_out=XOR;
            end
            SLTi:begin
                I_out=SLT;
            end
            default:begin
                I_out=ADD;
            end
        endcase // op
    end
endmodule // ALU_control_part
