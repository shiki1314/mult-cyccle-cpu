`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/23 13:37:07
// Design Name: 
// Module Name: DDU
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


module DDU(clk,rst,cont,step,mem,inc,dec,led,an,seg);
    input clk,cont,step,mem,inc,dec,rst;
    output [15:0]led;
    output reg [7:0]an;
    output [6:0]seg;
    wire CLK_CPU;
    wire clk_1000HZ;
    wire [31:0]mem_rf_data;
    wire [31:0]PC,memdata,regdata,Address;
    wire [7:0]addr; 
    wire LORD;   
    reg [3:0]num;
    reg [2:0] cur;
    parameter STAY=0,INC=1,DEC=2;


    counter M1(.clk(clk),
        .ce(1),
        .clk_1000HZ(clk_1000HZ));
    bcdTo7Seg M2(.bcd(num),
        .seg(seg));
    CPU M3 (.clk(CLK_CPU),
        .addr(addr),
        .pc(PC),
        .rst(rst),
        .memdata(memdata),
        .regdata(regdata),
        .LORD(LORD),
        .Address(Address));
    reg [1:0]state;
    reg [7:0]mem_rf_addr;
    initial begin
        state =0;
        mem_rf_addr = 0;
        cur = 0;
    end
    always @(posedge clk_1000HZ ) begin 
        if(state==STAY)begin
            if(inc)begin
                state <= INC;
                mem_rf_addr <= mem_rf_addr+1;
            end
            else if(dec)begin
                state <= DEC;
                mem_rf_addr <= mem_rf_addr-1;
            end
        end
        else if(state == INC) begin
            if(~inc) begin
                state <= STAY;
            end
        end
        else if(state == DEC) begin
            if(~dec) begin
                state <= STAY;
            end
        end
    end

    reg [1:0]run_state;
    always @(posedge clk_1000HZ) begin
        if (run_state == 2'd1) begin
            run_state <= 2'd2;
        end else if (run_state == 2'd2) begin
            if ( step == 0 ) begin
                run_state <= 2'd0;
            end
        end else if (step == 1) begin
                run_state <= 2'd1;
        end
    end
    always @(posedge clk_1000HZ ) begin 
        cur <= cur+1;
    end
    always @(*) begin 
        case (cur)
            3'd0: begin
                an = 8'b11111110;
                num = mem_rf_data[3:0];
            end
            3'd1: begin
                an = 8'b11111101;
                num = mem_rf_data[7:4];
            end
            3'd2: begin
                an = 8'b11111011;
                num = mem_rf_data[11:8];
            end
            3'd3: begin
                an = 8'b11110111;
                num = mem_rf_data[15:12];
            end
            3'd4: begin
                an = 8'b11101111;
                num = mem_rf_data[19:16];
            end
            3'd5: begin
                an = 8'b11011111;
                num = mem_rf_data[23:20];
            end
            3'd6: begin
                an = 8'b10111111;
                num = mem_rf_data[27:24];
            end
            3'd7: begin
                an = 8'b01111111;
                num = mem_rf_data[31:28];
            end
            default: begin
                an <= 8'b11111111;
            end
        endcase
    end
assign addr = mem_rf_addr;
assign CLK_CPU = cont? clk_1000HZ:(clk_1000HZ&& (run_state == 2'd1 ));
assign mem_rf_data = mem? memdata:regdata;
assign led = {addr, PC[9:2]};
endmodule
