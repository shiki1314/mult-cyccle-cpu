`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 20:50:10
// Design Name: 
// Module Name: Control_part
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


module Control_part(clk,op,rst,PCWrite,PCWriterCond,lord,MemRead,MemWrite,MemtoReg,IRWrite,PCSource,ALUOp,ALUsrcB,ALUSrcA,RegWrite,Regdst,is_BEQ);
    input clk,rst;
    input [5:0]op;
    output reg PCWrite,PCWriterCond,lord,MemRead,MemWrite,MemtoReg,IRWrite,ALUSrcA,RegWrite,Regdst;
    output reg [1:0]PCSource,ALUOp,ALUsrcB;
    output is_BEQ;//其实是用来判断B类指令的信号
    reg [3:0]state;
    wire is_R_type,is_I_type,is_B,is_mem,is_J;
    parameter start=0,IF=1,ID=2,mem_3=3,I_3=4,R_3=5,BEQ_3=6,BNE_3=7,J_3=8,mem_l=9,mem_s=10,R_4=11,I_4=12,m_5=13;
    parameter R_type=6'b000000,J_type=6'b000010,LW=6'b100011,SW=6'b101011,BEQ=6'b000100,BNE=6'b000101;
    parameter ADDi=6'b001000,SLTi=6'b001010,ANDi=6'b001100,ORi=6'b001101,XORi=6'b001110;
    assign is_R_type=(op==R_type);
    assign is_I_type=(op==ADDi)|(op==SLTi)|(op==ANDi)|(op==ORi)|(op==XORi);
    assign is_B=(op==BNE)|(op==BEQ);
    assign is_J=(op==J_type);
    assign is_mem=(op==LW)|(op==SW);
    assign is_BEQ=(op==BEQ);
    initial begin
        state=start;
    end
    // always @(posedge clk ) begin 
    //     state<=next_state;
    // end
    always @(posedge clk ) begin 
        case(state)
            start:begin
                state<=IF;
            end
            IF:begin
                state<=ID;
            end
            ID:begin
                if(is_mem) begin
                    state<=mem_3;
                end
                else if(is_I_type)begin
                    state<=I_3;
                end
                else if(is_R_type)begin
                    state<=R_3;
                end
                else if(is_B)begin
                    if(op==BNE)begin
                        state<=BNE_3;
                    end else if(op == BEQ)begin
                        state <= BEQ_3;
                    end
                end
                else begin 
                    state<=J_3;
                end
            end
            mem_3:begin
                state<=(op==LW)?mem_l:mem_s;
            end
            I_3:begin
                state<=I_4;
            end
            R_3:begin
                state<=R_4;
            end
            mem_l:begin
                state<=m_5;
            end
            default begin
                state<=IF;
            end
        endcase // state
        end
        always @(*) begin
            case(state) 
            IF: begin
                // is_J=~(op==J_type);
                PCWriterCond = 0;
                PCWrite =1;
                lord = 0;
                MemRead = 1;
                MemWrite = 0;
                MemtoReg = 0;
                IRWrite = 1;
                PCSource = 0;
                ALUOp = 0;
                ALUsrcB = 2'b01;
                ALUSrcA = 0;
                RegWrite = 0;
                Regdst = 0;
            end
            ID: begin
                PCWrite = 0;
                IRWrite = 0;
                ALUSrcA = 0;
                ALUsrcB = 2'b11;

                PCWriterCond = 0;
                lord = 0;
                MemRead = 0;
                MemWrite = 0;
                MemtoReg = 0;
                PCSource = 0;
                ALUOp = 0;
                RegWrite = 0;
                Regdst = 0;
            end
            mem_3: begin
                // is_J=(op==J_type);
                ALUSrcA=1;
                ALUsrcB=2'b10;
            end
            I_3: begin
                // is_J=(op==J_type);
                ALUsrcB=2'b10;
                ALUSrcA=1;
                ALUOp=2'b11;
            end
            R_3: begin
                // is_J=(op==J_type);
                ALUSrcA=1;
                ALUsrcB=2'b00;
                ALUOp=2'b10;
            end
            BEQ_3: begin
                // is_BEQ=1;
                ALUSrcA=1;
                ALUsrcB=2'b00;
                ALUOp=2'b01;
                PCWriterCond=1;
                PCSource=2'b01;
            end
            BNE_3: begin 
                // is_BEQ=0;
                ALUSrcA=1;
                ALUsrcB=2'b00;
                ALUOp=2'b01;
                PCWriterCond=1;
                PCSource=2'b01;
            end
            J_3: begin
                // is_J=(op==J_type);
                PCWrite=1;
                PCSource=2'b10;
            end
            mem_l:begin
                // is_J=(op==J_type);
                MemRead=1;
                lord=1;
            end
            mem_s:begin
                // is_J=(op==J_type);
                MemWrite=1;
                lord=1;
            end
            R_4:begin
                // is_J=(op==J_type);
                Regdst=1;
                RegWrite=1;
                MemtoReg=0;
            end
            I_4:begin
                // is_J=(op==J_type);
                Regdst=0;
                RegWrite=1;
                MemtoReg=0;
            end
            m_5: begin
                // is_J=(op==J_type);
                Regdst=0;
                RegWrite=1;
                MemtoReg=1;
            end
        endcase
        end
endmodule
