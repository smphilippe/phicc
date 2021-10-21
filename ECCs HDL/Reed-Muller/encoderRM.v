//`timescale 1ns / 1ps

module encoderRM(clk, data_in, cw_out);
	input  clk;
	input  [15:0] data_in;
	output  [31:0] cw_out;
	
	reg [31:0] matrix[15:0];
	reg [31:0] cw;
	reg [15:0] aux;
	integer i;	
	//wire clock=en;
   always @(posedge clk)
	begin

		matrix[0] = 	32'b11111111111111111111111111111111;
		matrix[1] = 	32'b10101010101010101010101010101010;
		matrix[2] = 	32'b11001100110011001100110011001100;
		matrix[3] = 	32'b11110000111100001111000011110000;
		matrix[4] = 	32'b11111111000000001111111100000000;
		matrix[5] = 	32'b11111111111111110000000000000000;
		matrix[6] = 	32'b10001000100010001000100010001000;
		matrix[7] = 	32'b10100000101000001010000010100000;
		matrix[8] = 	32'b10101010000000001010101000000000;
		matrix[9] = 	32'b10101010101010100000000000000000;
		matrix[10] = 	32'b11000000110000001100000011000000;
		matrix[11] =	32'b11001100000000001100110000000000;
		matrix[12] =	32'b11001100110011000000000000000000;
		matrix[13] =	32'b11110000000000001111000000000000;
		matrix[14] = 	32'b11110000111100000000000000000000;
		matrix[15] = 	32'b11111111000000000000000000000000;
	
		for (i=0; i < 32; i=i+1)
		begin
			aux[0]=data_in[0]& matrix[0][i];
			aux[1]=data_in[1]& matrix[1][i];
			aux[2]=data_in[2]& matrix[2][i];
			aux[3]=data_in[3]& matrix[3][i];
			aux[4]=data_in[4]& matrix[4][i];
			aux[5]=data_in[5]& matrix[5][i];
			aux[6]=data_in[6]& matrix[6][i];
			aux[7]=data_in[7]& matrix[7][i];
			aux[8]=data_in[8]& matrix[8][i];
			aux[9]=data_in[9]& matrix[9][i];
			aux[10]=data_in[10]& matrix[10][i];
			aux[11]=data_in[11]& matrix[11][i];
			aux[12]=data_in[12]& matrix[12][i];
			aux[13]=data_in[13]& matrix[13][i];
			aux[14]=data_in[14]& matrix[14][i];
			aux[15]=data_in[15]& matrix[15][i];
			
			cw[i]=aux[0]^aux[1]^aux[2]^aux[3]^aux[4]^aux[5]^aux[6]^aux[7]^aux[8]^aux[9]^aux[10]^aux[11]^aux[12]^aux[13]^aux[14]^aux[15];
		end
	
	end
	assign cw_out= cw;
endmodule