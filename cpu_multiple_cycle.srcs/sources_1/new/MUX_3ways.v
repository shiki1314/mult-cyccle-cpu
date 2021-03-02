`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 17:22:37
// Design Name: 
// Module Name: MUX_3ways
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


module MUX_3ways(PCplus,PCJump,Pcbranch,PCSource,PC_out);
    input wire [1:0]PCSource;
    input wire [31:0]PCplus,PCJump,Pcbranch;
    output reg [31:0]PC_out;
    always @(*)begin
        case (PCSource)
            0:begin
                PC_out=PCplus;
            end
            1:begin
                PC_out=Pcbranch;
            end
            2:begin
                PC_out=PCJump;
            end
            default:begin

            end
        endcase
    end
endmodule
