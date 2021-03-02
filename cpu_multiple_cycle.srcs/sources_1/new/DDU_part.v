`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/10 22:15:58
// Design Name: 
// Module Name: DDU_part
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


module DDU_part(clk,rst,cont,inc,dec,mem,addr,regdata,memdata,seg,AN,step,PC,led,CLK_used);
    input clk,rst,cont,inc,dec,mem,step;
    input [31:0]regdata,memdata,PC;
    output reg [7:0]addr;
    output [6:0]seg;
    output reg[7:0]AN;
    output [15:0]led;
    output CLK_used;
    wire [31:0]mem_rf;
    wire clk_1000HZ;
    counter M(.clk(clk),
        .clk_1000HZ(clk_1000HZ),
        .ce(1));
    reg [3:0]num;
    reg [2:0]cur;
    bcdTo7Seg M1(.bcd(num),
        .seg(seg));
    assign CLK_used=(cont)?clk_1000HZ:(clk_1000HZ & (run_state == 2'd1));
    assign mem_rf=(mem)?memdata:regdata;
    assign led={addr,PC[9:2]};
    initial begin
        addr=0;
        cur=0;
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
    // always @(posedge CLK_used ) begin 
    //     if(inc)begin
    //         addr<=addr+1;
    //     end
    //     else if(dec)begin
    //         addr<=addr-1;
    //     end
    // end
    reg [1:0]state;

    parameter STAY = 2'd0, INC = 2'd1, DEC = 2'd2;

        always @(posedge clk_1000HZ) begin
            if(rst == 1) begin
                addr <= 0;
            end
            else if (state == STAY) begin
            if (inc) begin
                state <= INC;
                addr <= addr + 1;
            end else if (dec) begin
                state <= DEC;
                addr <= addr - 1;
            end
            end else if (state == INC) begin
            if (~inc) begin
                state <= STAY;
            end
            end else begin
            if (~dec) begin
                state <= STAY;
            end
        end
    end

    always @(posedge clk_1000HZ ) begin 
        cur<=cur+1;
        case(cur)
            0:begin
                AN<=8'b11111110;
            end
            1:begin
                AN<=8'b11111101;
            end
            2:begin
                AN<=8'b11111011;
            end
            3:begin
                AN<=8'b11110111;
            end
            4:begin
                AN<=8'b11101111;
            end
            5:begin
                AN<=8'b11011111;
            end
            6:begin
                AN<=8'b10111111;
            end
            7:begin
                AN<=8'b01111111;
            end
        endcase // cur
    end
    always @(*) begin 
        case(cur)
            0:begin
                num=mem_rf[3:0];
            end
            1:begin
                num=mem_rf[7:4];
            end
            2:begin
                num=mem_rf[11:8];
            end
            3:begin
                num=mem_rf[15:12];
            end
            4:begin
                num=mem_rf[19:16];
            end
            5:begin
                num=mem_rf[23:20];
            end
            6:begin
                num=mem_rf[27:24];
            end
            7:begin
                num=mem_rf[31:28];
            end
            endcase // cur
    end
endmodule
