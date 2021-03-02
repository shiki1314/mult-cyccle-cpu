`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 15:52:36
// Design Name: 
// Module Name: top
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


module CPU(clk,rst,memdata,regdata,addr,pc,LORD,Address);
    input clk;
    input rst;
    output [31:0]memdata,regdata,pc,Address;
    output LORD;
    input [7:0]addr;
    // input step,cont,inc,dec,mem;
    // output [6:0]seg;
    // output [7:0]AN;
    // output [15:0]led;
    // output [31:0] out;
    wire [31:0]PC,Imm,Jump,PCplus;
    wire [31:0]instr,data;
    wire [5:0]op,funct;
    wire [4:0]rs,rt,rd;
    wire [31:0]reg_A,reg_B;
    wire [31:0]alu_out,alu_result;
    wire PCWriterCond,PCWrite,lord,MemRead,MemWrite,MemtoReg,IRWrite,ALUSrcA,RegWrite,Regdst,Zero;
    wire [1:0]PCSource;
    wire [1:0]ALUsrcB;
    wire [4:0]AlUcontrol;
    wire [1:0]ALUOp;
    wire is_J;
    wire is_BEQ;
    // wire [7:0]addr;
    // wire [31:0]regdata,memdata;
    // wire CLK_used;
    // assign out = instr;
    assign op = instr[31:26];
    assign funct = instr [5:0];
    assign rs = instr [25:21];
    assign rt = instr [20:16];
    assign rd = instr [15:11];
    assign Imm = instr[15] ? {16'hffff,instr[15:0]}:{16'h0000,instr[15:0]};
    assign Jump = {PC[31:28],instr[25:0],2'b00};
    assign pc = PC;
    assign LORD = lord;
    assign Address = alu_out;
    // assign PCplus=(is_J)?alu_result-4:alu_result;

    PC_part M1 (.PC(PC),
        .Zero(Zero),
        .PCWriterCond(PCWriterCond),
        .PCWrite(PCWrite),
        .lord(lord),
        .PCplus(alu_result),
        .PCJump(Jump),
        .Pcbranch(alu_out),
        .clk(clk),
        .rst(rst),
        .PCSource(PCSource),
        .is_BEQ(is_BEQ));
    MEM_part M2 (.PC(PC),
        .lord(lord),
        .writerdata(reg_B),
        .address(alu_out),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .data(data),
        .instr(instr),
        .IRWrite(IRWrite),
        .clk(clk),
        .rst(rst),
        .memdata(memdata),
        .addr(addr)
        );
    RF_part M3 (.clk(clk),
        .rst(rst),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .alu_out(alu_out),
        .data(data),
        .Regdst(Regdst),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .reg_B(reg_B),
        .reg_A(reg_A),
        .regdata(regdata),
        .addr(addr)
        );
    ALU_part M4(.clk(clk),
        .rst(rst),
        .PC(PC),
        .reg_A(reg_A),
        .reg_B(reg_B),
        .Imm(Imm),
        .ALUsrcB(ALUsrcB),
        .ALUSrcA(ALUSrcA),
        .AlUcontrol(AlUcontrol),
        .Zero(Zero),
        .alu_result(alu_result),
        .alu_out(alu_out));
    Control_part M5(.clk(clk),
        .op(op),
        .rst(rst),
        .PCWrite(PCWrite),
        .PCWriterCond(PCWriterCond),
        .lord(lord),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .IRWrite(IRWrite),
        .PCSource(PCSource),
        .ALUOp(ALUOp),
        .ALUsrcB(ALUsrcB),
        .ALUSrcA(ALUSrcA),
        .RegWrite(RegWrite),
        .Regdst(Regdst),
        .is_BEQ(is_BEQ));
    ALU_control_part M6(.op(op),
        .funct(funct),
        .ALUOp(ALUOp),
        .AlUcontrol(AlUcontrol));
    // DDU_part M7(.clk(clk),
    //     .cont(cont),
    //     .inc(inc),
    //     .dec(dec),
    //     .mem(mem),
    //     .addr(addr),
    //     .regdata(regdata),
    //     .memdata(memdata),
    //     .seg(seg),
    //     .AN(AN),
    //     .step(step),
    //     .PC(PC),
    //     .led(led),
    //     .CLK_used(CLK_used),
    //     .rst(rst));

endmodule
