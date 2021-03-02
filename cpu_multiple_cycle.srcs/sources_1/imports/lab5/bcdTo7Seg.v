module bcdTo7Seg (
	input [3:0] bcd,
	output reg [6:0] seg
);
	always @(bcd) begin
		case (bcd)
			0: begin
				seg = 7'b1000000;
			end
			1: begin
				seg = 7'b1111001;
			end
			2: begin
				seg = 7'b0100100;
			end
			3: begin
				seg = 7'b0110000;
			end
			4: begin
				seg = 7'b0011001;
			end
			5: begin
				seg = 7'b0010010;
			end
			6: begin
				seg = 7'b0000010;
			end
			7: begin
				seg = 7'b1111000;
			end
			8: begin
				seg = 7'b0000000;
			end
			9: begin
				seg = 7'b0010000;
			end
			10: begin
				seg = 7'b0001000;
			end
			11: begin
				seg = 7'b0000011;
			end
			12: begin
				seg = 7'b1000110;
			end
			13: begin
				seg = 7'b0100001;
			end
			14: begin
				seg = 7'b0000110;
			end
			15: begin
				seg = 7'b0001110;
			end

			default: begin
				// show nothing
				seg = 7'b1111111;
			end
		endcase
	end
endmodule
