`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 20:45:43
// Design Name: 
// Module Name: MUX_4ways
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


module MUX_4ways(din1,din2,din3,din4,dout,ALUsrcB);
    input [31:0]din1,din2,din3,din4;
    input [1:0]ALUsrcB;
    output reg[31:0]dout;
    always @(*) begin
        case(ALUsrcB)
            0:dout=din1;
            1:dout=din2;
            2:dout=din3;
            3:dout=din4;
    endcase // ALUSrcB
    end
endmodule
