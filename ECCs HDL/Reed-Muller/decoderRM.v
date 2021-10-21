module decoderRM(clk, IN_wrongcodeword, OUT_originalword);

	input  [31:0] IN_wrongcodeword;
	input clk;
	output  [15:0] OUT_originalword;

	// matrix variable is a 15 address x 32 bits memory. It's the generator matrix. 
	reg [31:0] 	matrix[14:0];
	
	
	reg [7:0] 	aXX[9:0];
	reg [15:0] 	aX[4:0];
	reg [31:0] 	rX[3:0];
	reg [9:0] 	AXX;
	reg [4:0] 	AX;
	reg [4:0]	cont;
	reg [31:0]	codeword;

	always @(clk)
	begin
		//$display("codeword recebida: %b", IN_wrongcodeword);
		matrix[0] = 	32'b10101010101010101010101010101010;
		matrix[1] = 	32'b11001100110011001100110011001100;
		matrix[2] = 	32'b11110000111100001111000011110000;
		matrix[3] = 	32'b11111111000000001111111100000000;
		matrix[4] = 	32'b11111111111111110000000000000000;
		matrix[5] = 	32'b10001000100010001000100010001000;
		matrix[6] = 	32'b10100000101000001010000010100000;
		matrix[7] = 	32'b10101010000000001010101000000000;
		matrix[8] = 	32'b10101010101010100000000000000000;
		matrix[9] = 	32'b11000000110000001100000011000000;
		matrix[10] =	32'b11001100000000001100110000000000;
		matrix[11] =	32'b11001100110011000000000000000000;
		matrix[12] =	32'b11110000000000001111000000000000;
		matrix[13] = 	32'b11110000111100000000000000000000;
		matrix[14] = 	32'b11111111000000000000000000000000;
		
		cont = 0;
		aXX[0][0] = IN_wrongcodeword[0]  ^ IN_wrongcodeword[1] ^ IN_wrongcodeword[2] ^ IN_wrongcodeword[3];
		if(aXX[0][0]) cont = cont + 1;
		aXX[0][1] = IN_wrongcodeword[4]  ^ IN_wrongcodeword[5] ^ IN_wrongcodeword[6] ^ IN_wrongcodeword[7];
		if(aXX[0][1]) cont = cont + 1;
    	aXX[0][2] = IN_wrongcodeword[8]  ^ IN_wrongcodeword[9] ^ IN_wrongcodeword[10] ^ IN_wrongcodeword[11];
    	if(aXX[0][2]) cont = cont + 1;
    	aXX[0][3] = IN_wrongcodeword[12] ^ IN_wrongcodeword[13] ^ IN_wrongcodeword[14] ^ IN_wrongcodeword[15];
    	if(aXX[0][3]) cont = cont + 1;
    	aXX[0][4] = IN_wrongcodeword[16] ^ IN_wrongcodeword[17] ^ IN_wrongcodeword[18] ^ IN_wrongcodeword[19];
    	if(aXX[0][4]) cont = cont + 1;
    	aXX[0][5] = IN_wrongcodeword[20] ^ IN_wrongcodeword[21] ^ IN_wrongcodeword[22] ^ IN_wrongcodeword[23];
    	if(aXX[0][5]) cont = cont + 1;
    	aXX[0][6] = IN_wrongcodeword[24] ^ IN_wrongcodeword[25] ^ IN_wrongcodeword[26] ^ IN_wrongcodeword[27];
    	if(aXX[0][6]) cont = cont + 1;
    	aXX[0][7] = IN_wrongcodeword[28] ^ IN_wrongcodeword[29] ^ IN_wrongcodeword[30] ^ IN_wrongcodeword[31];
		if(aXX[0][7]) cont = cont + 1;
		

		
		if(cont > 8 - cont) 
			AXX[0] = 1;
		else
			AXX[0] = 0;
			
		cont = 0;
		aXX[1][0] = IN_wrongcodeword[0]  ^ IN_wrongcodeword[1] ^ IN_wrongcodeword[4] ^ IN_wrongcodeword[5];
		if(aXX[1][0]) cont = cont + 1;
    	aXX[1][1] = IN_wrongcodeword[2]  ^ IN_wrongcodeword[3] ^ IN_wrongcodeword[6] ^ IN_wrongcodeword[7];
    	if(aXX[1][1]) cont = cont + 1;
    	aXX[1][2] = IN_wrongcodeword[8]  ^ IN_wrongcodeword[9] ^ IN_wrongcodeword[12] ^ IN_wrongcodeword[13];
    	if(aXX[1][2]) cont = cont + 1;
    	aXX[1][3] = IN_wrongcodeword[10] ^ IN_wrongcodeword[11] ^ IN_wrongcodeword[14] ^ IN_wrongcodeword[15];
    	if(aXX[1][3]) cont = cont + 1;
    	aXX[1][4] = IN_wrongcodeword[16] ^ IN_wrongcodeword[17] ^ IN_wrongcodeword[20] ^ IN_wrongcodeword[21];
    	if(aXX[1][4]) cont = cont + 1;
    	aXX[1][5] = IN_wrongcodeword[18] ^ IN_wrongcodeword[19] ^ IN_wrongcodeword[22] ^ IN_wrongcodeword[23];
    	if(aXX[1][5]) cont = cont + 1;
    	aXX[1][6] = IN_wrongcodeword[24] ^ IN_wrongcodeword[25] ^ IN_wrongcodeword[28] ^ IN_wrongcodeword[29];
    	if(aXX[1][6]) cont = cont + 1;
    	aXX[1][7] = IN_wrongcodeword[26] ^ IN_wrongcodeword[27] ^ IN_wrongcodeword[30] ^ IN_wrongcodeword[31];
		if(aXX[1][7]) cont = cont + 1;
				
		
		if(cont > 8 - cont) 
			AXX[1] = 1;
		else
			AXX[1] = 0;
			
		cont = 0;
		aXX[2][0] = IN_wrongcodeword[0]  ^ IN_wrongcodeword[1] ^ IN_wrongcodeword[8] ^ IN_wrongcodeword[9];
		if(aXX[2][0]) cont = cont + 1;
    	aXX[2][1] = IN_wrongcodeword[2]  ^ IN_wrongcodeword[3] ^ IN_wrongcodeword[10] ^ IN_wrongcodeword[11];
    	if(aXX[2][1]) cont = cont + 1;
    	aXX[2][2] = IN_wrongcodeword[4]  ^ IN_wrongcodeword[5] ^ IN_wrongcodeword[12] ^ IN_wrongcodeword[13];
    	if(aXX[2][2]) cont = cont + 1;
    	aXX[2][3] = IN_wrongcodeword[6]  ^ IN_wrongcodeword[7] ^ IN_wrongcodeword[14] ^ IN_wrongcodeword[15];
    	if(aXX[2][3]) cont = cont + 1;
    	aXX[2][4] = IN_wrongcodeword[16] ^ IN_wrongcodeword[17] ^ IN_wrongcodeword[24] ^ IN_wrongcodeword[25];
    	if(aXX[2][4]) cont = cont + 1;
    	aXX[2][5] = IN_wrongcodeword[18] ^ IN_wrongcodeword[19] ^ IN_wrongcodeword[26] ^ IN_wrongcodeword[27];
    	if(aXX[2][5]) cont = cont + 1;
    	aXX[2][6] = IN_wrongcodeword[20] ^ IN_wrongcodeword[21] ^ IN_wrongcodeword[28] ^ IN_wrongcodeword[29];
    	if(aXX[2][6]) cont = cont + 1;
    	aXX[2][7] = IN_wrongcodeword[22] ^ IN_wrongcodeword[23] ^ IN_wrongcodeword[30] ^ IN_wrongcodeword[31];
		if(aXX[2][7]) cont = cont + 1;

		if(cont > 8 - cont) 
			AXX[2] = 1;
		else
			AXX[2] = 0;
	
		cont = 0;
		aXX[3][0] = IN_wrongcodeword[0] ^ IN_wrongcodeword[1] ^ IN_wrongcodeword[16] ^ IN_wrongcodeword[17];
		if(aXX[3][0]) cont = cont + 1;
    	aXX[3][1] = IN_wrongcodeword[2] ^ IN_wrongcodeword[3] ^ IN_wrongcodeword[18] ^ IN_wrongcodeword[19];
    	if(aXX[3][1]) cont = cont + 1;
    	aXX[3][2] = IN_wrongcodeword[4] ^ IN_wrongcodeword[5] ^ IN_wrongcodeword[20] ^ IN_wrongcodeword[21]; 
    	if(aXX[3][2]) cont = cont + 1;
    	aXX[3][3] = IN_wrongcodeword[6] ^ IN_wrongcodeword[7] ^ IN_wrongcodeword[22] ^ IN_wrongcodeword[23];
    	if(aXX[3][3]) cont = cont + 1;
    	aXX[3][4] = IN_wrongcodeword[8] ^ IN_wrongcodeword[9] ^ IN_wrongcodeword[24] ^ IN_wrongcodeword[25];
    	if(aXX[3][4]) cont = cont + 1;
    	aXX[3][5] = IN_wrongcodeword[10] ^ IN_wrongcodeword[11] ^ IN_wrongcodeword[26] ^ IN_wrongcodeword[27];
    	if(aXX[3][5]) cont = cont + 1;
    	aXX[3][6] = IN_wrongcodeword[12] ^ IN_wrongcodeword[13] ^ IN_wrongcodeword[28] ^ IN_wrongcodeword[29];
    	if(aXX[3][6]) cont = cont + 1;
    	aXX[3][7] = IN_wrongcodeword[14] ^ IN_wrongcodeword[15] ^ IN_wrongcodeword[30] ^ IN_wrongcodeword[31];
		if(aXX[3][7]) cont = cont + 1;
		
		if(cont > 8 - cont) 
			AXX[3] = 1;
		else
			AXX[3] = 0;
		
		cont = 0;
		aXX[4][0] = IN_wrongcodeword[0] ^ IN_wrongcodeword[2] ^ IN_wrongcodeword[4] ^ IN_wrongcodeword[6];
    	if(aXX[4][0]) cont = cont + 1;
    	aXX[4][1] = IN_wrongcodeword[1] ^ IN_wrongcodeword[3] ^ IN_wrongcodeword[5] ^ IN_wrongcodeword[7];	
    	if(aXX[4][1]) cont = cont + 1;
    	aXX[4][2] = IN_wrongcodeword[8] ^ IN_wrongcodeword[10] ^ IN_wrongcodeword[12] ^ IN_wrongcodeword[14];
    	if(aXX[4][2]) cont = cont + 1;
    	aXX[4][3] = IN_wrongcodeword[9] ^ IN_wrongcodeword[11] ^ IN_wrongcodeword[13] ^ IN_wrongcodeword[15];
    	if(aXX[4][3]) cont = cont + 1;
    	aXX[4][4] = IN_wrongcodeword[16] ^ IN_wrongcodeword[18] ^ IN_wrongcodeword[20] ^ IN_wrongcodeword[22];
    	if(aXX[4][4]) cont = cont + 1;
    	aXX[4][5] = IN_wrongcodeword[17] ^ IN_wrongcodeword[19] ^ IN_wrongcodeword[21] ^ IN_wrongcodeword[23];
    	if(aXX[4][5]) cont = cont + 1;
    	aXX[4][6] = IN_wrongcodeword[24] ^ IN_wrongcodeword[26] ^ IN_wrongcodeword[28] ^ IN_wrongcodeword[30];
    	if(aXX[4][6]) cont = cont + 1;
    	aXX[4][7] = IN_wrongcodeword[25] ^ IN_wrongcodeword[27] ^ IN_wrongcodeword[29] ^ IN_wrongcodeword[31];
    	if(aXX[4][7]) cont = cont + 1;
    	
    	
    	if(cont > 8 - cont) 
			AXX[4] = 1;
		else
			AXX[4] = 0;
			
		cont = 0;
		aXX[5][0] = IN_wrongcodeword[0] ^ IN_wrongcodeword[2] ^ IN_wrongcodeword[8] ^ IN_wrongcodeword[10];
    	if(aXX[5][0]) cont = cont + 1;
    	aXX[5][1] = IN_wrongcodeword[1] ^ IN_wrongcodeword[3] ^ IN_wrongcodeword[9] ^ IN_wrongcodeword[11];
    	if(aXX[5][1]) cont = cont + 1;
    	aXX[5][2] = IN_wrongcodeword[4] ^ IN_wrongcodeword[6] ^ IN_wrongcodeword[12] ^ IN_wrongcodeword[14];	
    	if(aXX[5][2]) cont = cont + 1;
    	aXX[5][3] = IN_wrongcodeword[5] ^ IN_wrongcodeword[7] ^ IN_wrongcodeword[13] ^ IN_wrongcodeword[15];
    	if(aXX[5][3]) cont = cont + 1;
    	aXX[5][4] = IN_wrongcodeword[16] ^ IN_wrongcodeword[18] ^ IN_wrongcodeword[24] ^ IN_wrongcodeword[26];
    	if(aXX[5][4]) cont = cont + 1;
    	aXX[5][5] = IN_wrongcodeword[17] ^ IN_wrongcodeword[19] ^ IN_wrongcodeword[25] ^ IN_wrongcodeword[27];
    	if(aXX[5][5]) cont = cont + 1;
    	aXX[5][6] = IN_wrongcodeword[20] ^ IN_wrongcodeword[22] ^ IN_wrongcodeword[28] ^ IN_wrongcodeword[30];
    	if(aXX[5][6]) cont = cont + 1;
    	aXX[5][7] = IN_wrongcodeword[21] ^ IN_wrongcodeword[23] ^ IN_wrongcodeword[29] ^ IN_wrongcodeword[31];
		if(aXX[5][7]) cont = cont + 1;
		
		if(cont > 8 - cont) 
			AXX[5] = 1;
		else
			AXX[5] = 0;
			
		cont = 0;
		aXX[6][0] = IN_wrongcodeword[0] ^ IN_wrongcodeword[2] ^ IN_wrongcodeword[16] ^ IN_wrongcodeword[18];
		if(aXX[6][0]) cont = cont + 1;
    	aXX[6][1] = IN_wrongcodeword[1] ^ IN_wrongcodeword[3] ^ IN_wrongcodeword[17] ^ IN_wrongcodeword[19];
    	if(aXX[6][1]) cont = cont + 1;
    	aXX[6][2] = IN_wrongcodeword[4] ^ IN_wrongcodeword[6] ^ IN_wrongcodeword[20] ^ IN_wrongcodeword[22];
    	if(aXX[6][2]) cont = cont + 1;
    	aXX[6][3] = IN_wrongcodeword[5] ^ IN_wrongcodeword[7] ^ IN_wrongcodeword[21] ^ IN_wrongcodeword[23];
    	if(aXX[6][3]) cont = cont + 1;
    	aXX[6][4] = IN_wrongcodeword[8] ^ IN_wrongcodeword[10] ^ IN_wrongcodeword[24] ^ IN_wrongcodeword[26];
    	if(aXX[6][4]) cont = cont + 1;
    	aXX[6][5] = IN_wrongcodeword[9] ^ IN_wrongcodeword[11] ^ IN_wrongcodeword[25] ^ IN_wrongcodeword[27];
    	if(aXX[6][5]) cont = cont + 1;
    	aXX[6][6] = IN_wrongcodeword[12] ^ IN_wrongcodeword[14] ^ IN_wrongcodeword[28] ^ IN_wrongcodeword[30];
    	if(aXX[6][6]) cont = cont + 1;
    	aXX[6][7] = IN_wrongcodeword[13] ^ IN_wrongcodeword[15] ^ IN_wrongcodeword[29] ^ IN_wrongcodeword[31];
		if(aXX[6][7]) cont = cont + 1;
		
		if(cont > 8 - cont) 
			AXX[6] = 1;
		else
			AXX[6] = 0;
			
		cont = 0;
		aXX[7][0] = IN_wrongcodeword[0] ^ IN_wrongcodeword[4] ^ IN_wrongcodeword[8] ^ IN_wrongcodeword[12];
   	if(aXX[7][0]) cont = cont + 1;
   	aXX[7][1] = IN_wrongcodeword[1] ^ IN_wrongcodeword[5] ^ IN_wrongcodeword[9] ^ IN_wrongcodeword[13];
    	if(aXX[7][1]) cont = cont + 1;
    	aXX[7][2] = IN_wrongcodeword[2] ^ IN_wrongcodeword[6] ^ IN_wrongcodeword[10] ^ IN_wrongcodeword[14];
    	if(aXX[7][2]) cont = cont + 1;
    	aXX[7][3] = IN_wrongcodeword[3] ^ IN_wrongcodeword[7] ^ IN_wrongcodeword[11] ^ IN_wrongcodeword[15];
    	if(aXX[7][3]) cont = cont + 1;
    	aXX[7][4] = IN_wrongcodeword[16] ^ IN_wrongcodeword[20] ^ IN_wrongcodeword[24] ^ IN_wrongcodeword[28];
    	if(aXX[7][4]) cont = cont + 1;
    	aXX[7][5] = IN_wrongcodeword[17] ^ IN_wrongcodeword[21] ^ IN_wrongcodeword[25] ^ IN_wrongcodeword[29];
    	if(aXX[7][5]) cont = cont + 1;
    	aXX[7][6] = IN_wrongcodeword[18] ^ IN_wrongcodeword[22] ^ IN_wrongcodeword[26] ^ IN_wrongcodeword[30];
    	if(aXX[7][6]) cont = cont + 1;
    	aXX[7][7] = IN_wrongcodeword[19] ^ IN_wrongcodeword[23] ^ IN_wrongcodeword[27] ^ IN_wrongcodeword[31];
		if(aXX[7][7]) cont = cont + 1;
		
		if(cont > 8 - cont) 
			AXX[7] = 1;
		else
			AXX[7] = 0;
		
		cont = 0;
		aXX[8][0] = IN_wrongcodeword[0] ^ IN_wrongcodeword[4] ^ IN_wrongcodeword[16] ^ IN_wrongcodeword[20];
		if(aXX[8][0]) cont = cont + 1;
    	aXX[8][1] = IN_wrongcodeword[1] ^ IN_wrongcodeword[5] ^ IN_wrongcodeword[17] ^ IN_wrongcodeword[21];
    	if(aXX[8][1]) cont = cont + 1;
    	aXX[8][2] = IN_wrongcodeword[2] ^ IN_wrongcodeword[6] ^ IN_wrongcodeword[18] ^ IN_wrongcodeword[22];
    	if(aXX[8][2]) cont = cont + 1;
    	aXX[8][3] = IN_wrongcodeword[3] ^ IN_wrongcodeword[7] ^ IN_wrongcodeword[19] ^ IN_wrongcodeword[23];
    	if(aXX[8][3]) cont = cont + 1;
    	aXX[8][4] = IN_wrongcodeword[8] ^ IN_wrongcodeword[12] ^ IN_wrongcodeword[24] ^ IN_wrongcodeword[28];
    	if(aXX[8][4]) cont = cont + 1;
    	aXX[8][5] = IN_wrongcodeword[9] ^ IN_wrongcodeword[13] ^ IN_wrongcodeword[25] ^ IN_wrongcodeword[29];
    	if(aXX[8][5]) cont = cont + 1;
    	aXX[8][6] = IN_wrongcodeword[10] ^ IN_wrongcodeword[14] ^ IN_wrongcodeword[26] ^ IN_wrongcodeword[30];
    	if(aXX[8][6]) cont = cont + 1;
    	aXX[8][7] = IN_wrongcodeword[11] ^ IN_wrongcodeword[15] ^ IN_wrongcodeword[27] ^ IN_wrongcodeword[31];
    	if(aXX[8][7]) cont = cont + 1;
		
		if(cont > 8 - cont) 
			AXX[8] = 1;
		else
			AXX[8] = 0;
		
		cont = 0;
		aXX[9][0] = IN_wrongcodeword[0] ^ IN_wrongcodeword[8] ^ IN_wrongcodeword[16] ^ IN_wrongcodeword[24];
    	if(aXX[9][0]) cont = cont + 1;
    	aXX[9][1] = IN_wrongcodeword[1] ^ IN_wrongcodeword[9] ^ IN_wrongcodeword[17] ^ IN_wrongcodeword[25];
    	if(aXX[9][1]) cont = cont + 1;
    	aXX[9][2] = IN_wrongcodeword[2] ^ IN_wrongcodeword[10] ^ IN_wrongcodeword[18] ^ IN_wrongcodeword[26];
    	if(aXX[9][2]) cont = cont + 1;
    	aXX[9][3] = IN_wrongcodeword[3] ^ IN_wrongcodeword[11] ^ IN_wrongcodeword[19] ^ IN_wrongcodeword[27];
    	if(aXX[9][3]) cont = cont + 1;
    	aXX[9][4] = IN_wrongcodeword[4] ^ IN_wrongcodeword[12] ^ IN_wrongcodeword[20] ^ IN_wrongcodeword[28];
    	if(aXX[9][4]) cont = cont + 1;
    	aXX[9][5] = IN_wrongcodeword[5] ^ IN_wrongcodeword[13] ^ IN_wrongcodeword[21] ^ IN_wrongcodeword[29];
    	if(aXX[9][5]) cont = cont + 1;
    	aXX[9][6] = IN_wrongcodeword[6] ^ IN_wrongcodeword[14] ^ IN_wrongcodeword[22] ^ IN_wrongcodeword[30];
    	if(aXX[9][6]) cont = cont + 1;
    	aXX[9][7] = IN_wrongcodeword[7] ^ IN_wrongcodeword[15] ^ IN_wrongcodeword[23] ^ IN_wrongcodeword[31];
		if(aXX[9][7]) cont = cont + 1;
	
		if(cont > 8 - cont) 
			AXX[9] = 1;
		else
			AXX[9] = 0;	
			
		if(~AXX[0]) matrix[5] = 32'b0;
		if(~AXX[1]) matrix[6] = 32'b0;
		if(~AXX[2]) matrix[7] = 32'b0;
		if(~AXX[3]) matrix[8] = 32'b0;
		if(~AXX[4]) matrix[9] = 32'b0;
		if(~AXX[5]) matrix[10] = 32'b0;
		if(~AXX[6]) matrix[11] = 32'b0;
		if(~AXX[7]) matrix[12] = 32'b0;
		if(~AXX[8]) matrix[13] = 32'b0;
		if(~AXX[9]) matrix[14] = 32'b0;
		
		rX[0] = matrix[5] ^ matrix[6] ^ matrix[7] ^ matrix[8] ^ matrix[9] ^ matrix[10] ^ matrix[11] ^ matrix[12] ^ matrix[13] ^ matrix[14];
		rX[1] = rX[0] ^ IN_wrongcodeword;
		
		//$display("rX[1]: %b", rX[1]);
		
		cont = 0;
		aX[0][0] = rX[1][0] ^ rX[1][1];
		if(aX[0][0]) cont = cont + 1;
    	aX[0][1] = rX[1][2] ^ rX[1][3];
    	if(aX[0][1]) cont = cont + 1;
    	aX[0][2] = rX[1][4] ^ rX[1][5];
    	if(aX[0][2]) cont = cont + 1;
    	aX[0][3] = rX[1][6] ^ rX[1][7];
    	if(aX[0][3]) cont = cont + 1;
    	aX[0][4] = rX[1][8] ^ rX[1][9];
    	if(aX[0][4]) cont = cont + 1;
    	aX[0][5] = rX[1][10] ^ rX[1][11];
    	if(aX[0][5]) cont = cont + 1;
    	aX[0][6] = rX[1][12] ^ rX[1][13];
    	if(aX[0][6]) cont = cont + 1;
    	aX[0][7] = rX[1][14] ^ rX[1][15];
    	if(aX[0][7]) cont = cont + 1;
    	aX[0][8] = rX[1][16] ^ rX[1][17];
    	if(aX[0][8]) cont = cont + 1;
    	aX[0][9] = rX[1][18] ^ rX[1][19];
    	if(aX[0][9]) cont = cont + 1;
    	aX[0][10] = rX[1][20] ^ rX[1][21];
    	if(aX[0][10]) cont = cont + 1;
    	aX[0][11] = rX[1][22] ^ rX[1][23];
    	if(aX[0][11]) cont = cont + 1;
    	aX[0][12] = rX[1][24] ^ rX[1][25];
    	if(aX[0][12]) cont = cont + 1;
    	aX[0][13] = rX[1][26] ^ rX[1][27];
    	if(aX[0][13]) cont = cont + 1;
    	aX[0][14] = rX[1][28] ^ rX[1][29];
    	if(aX[0][14]) cont = cont + 1;
    	aX[0][15] = rX[1][30] ^ rX[1][31];
		if(aX[0][15]) cont = cont + 1;
		
		if(cont > 16 - cont) 
			AX[0] = 1;
		else
			AX[0] = 0;
			
		cont = 0;
		aX[1][0] = rX[1][0] ^ rX[1][2];
    	if(aX[1][0]) cont = cont + 1;
    	aX[1][1] = rX[1][1] ^ rX[1][3];
    	if(aX[1][1]) cont = cont + 1;
    	aX[1][2] = rX[1][4] ^ rX[1][6];
    	if(aX[1][2]) cont = cont + 1;
    	aX[1][3] = rX[1][5] ^ rX[1][7];
    	if(aX[1][3]) cont = cont + 1;
    	aX[1][4] = rX[1][8] ^ rX[1][10];
    	if(aX[1][4]) cont = cont + 1;
    	aX[1][5] = rX[1][9] ^ rX[1][11];
    	if(aX[1][5]) cont = cont + 1;
    	aX[1][6] = rX[1][12] ^ rX[1][14];
    	if(aX[1][6]) cont = cont + 1;
    	aX[1][7] = rX[1][13] ^ rX[1][15];
    	if(aX[1][7]) cont = cont + 1;
    	aX[1][8] = rX[1][16] ^ rX[1][18];	// calcula a lógica majoritária
    	if(aX[1][8]) cont = cont + 1;
    	aX[1][9] = rX[1][17] ^ rX[1][19];
    	if(aX[1][9]) cont = cont + 1;
    	aX[1][10] = rX[1][20] ^ rX[1][22];
    	if(aX[1][10]) cont = cont + 1;
    	aX[1][11] = rX[1][21] ^ rX[1][23];
    	if(aX[1][11]) cont = cont + 1;
    	aX[1][12] = rX[1][24] ^ rX[1][26];
    	if(aX[1][12]) cont = cont + 1;
    	aX[1][13] = rX[1][25] ^ rX[1][27];
    	if(aX[1][13]) cont = cont + 1;
    	aX[1][14] = rX[1][28] ^ rX[1][30];
    	if(aX[1][14]) cont = cont + 1;
    	aX[1][15] = rX[1][29] ^ rX[1][31];
		if(aX[1][15]) cont = cont + 1;
		
		if(cont > 16 - cont) 
			AX[1] = 1;
		else
			AX[1] = 0;
			
		cont = 0;
		aX[2][0] = rX[1][0] ^ rX[1][4];
    	if(aX[2][0]) cont = cont + 1;
    	aX[2][1] = rX[1][1] ^ rX[1][5];
    	if(aX[2][1]) cont = cont + 1;
    	aX[2][2] = rX[1][2] ^ rX[1][6];
    	if(aX[2][2]) cont = cont + 1;
    	aX[2][3] = rX[1][3] ^ rX[1][7];
    	if(aX[2][3]) cont = cont + 1;
    	aX[2][4] = rX[1][8] ^ rX[1][12];
    	if(aX[2][4]) cont = cont + 1;
    	aX[2][5] = rX[1][9] ^ rX[1][13];
    	if(aX[2][5]) cont = cont + 1;
    	aX[2][6] = rX[1][10] ^ rX[1][14];
    	if(aX[2][6]) cont = cont + 1;
    	aX[2][7] = rX[1][11] ^ rX[1][15];
    	if(aX[2][7]) cont = cont + 1;
    	aX[2][8] = rX[1][16] ^ rX[1][20];	// calcula a lógica majoritária
    	if(aX[2][8]) cont = cont + 1;
    	aX[2][9] = rX[1][17] ^ rX[1][21];
    	if(aX[2][9]) cont = cont + 1;
    	aX[2][10] = rX[1][18] ^ rX[1][22];
    	if(aX[2][10]) cont = cont + 1;
    	aX[2][11] = rX[1][19] ^ rX[1][23];
    	if(aX[2][11]) cont = cont + 1;
    	aX[2][12] = rX[1][24] ^ rX[1][28];
    	if(aX[2][12]) cont = cont + 1;
    	aX[2][13] = rX[1][25] ^ rX[1][29];
    	if(aX[2][13]) cont = cont + 1;
    	aX[2][14] = rX[1][26] ^ rX[1][30];
    	if(aX[2][14]) cont = cont + 1;
    	aX[2][15] = rX[1][27] ^ rX[1][31];
		if(aX[2][15]) cont = cont + 1;
		
		if(cont > 16 - cont) 
			AX[2] = 1;
		else
			AX[2] = 0;
		
		cont = 0;
		aX[3][0] = rX[1][0] ^ rX[1][8];
    	if(aX[3][0]) cont = cont + 1;
    	aX[3][1] = rX[1][1] ^ rX[1][9];
    	if(aX[3][1]) cont = cont + 1;
    	aX[3][2] = rX[1][2] ^ rX[1][10];
    	if(aX[3][2]) cont = cont + 1;
    	aX[3][3] = rX[1][3] ^ rX[1][11];
    	if(aX[3][3]) cont = cont + 1;
    	aX[3][4] = rX[1][4] ^ rX[1][12];
    	if(aX[3][4]) cont = cont + 1;
    	aX[3][5] = rX[1][5] ^ rX[1][13];
    	if(aX[3][5]) cont = cont + 1;
    	aX[3][6] = rX[1][6] ^ rX[1][14];
    	if(aX[3][6]) cont = cont + 1;
    	aX[3][7] = rX[1][7] ^ rX[1][15];	// calcula a lógica majoritária
    	if(aX[3][7]) cont = cont + 1;
    	aX[3][8] = rX[1][16] ^ rX[1][24];
    	if(aX[3][8]) cont = cont + 1;
    	aX[3][9] = rX[1][17] ^ rX[1][25];
    	if(aX[3][9]) cont = cont + 1;
    	aX[3][10] = rX[1][18] ^ rX[1][26];
    	if(aX[3][10]) cont = cont + 1;
    	aX[3][11] = rX[1][19] ^ rX[1][27];
    	if(aX[3][11]) cont = cont + 1;
    	aX[3][12] = rX[1][20] ^ rX[1][28];
    	if(aX[3][12]) cont = cont + 1;
    	aX[3][13] = rX[1][21] ^ rX[1][29];
    	if(aX[3][13]) cont = cont + 1;
    	aX[3][14] = rX[1][22] ^ rX[1][30];
    	if(aX[3][14]) cont = cont + 1;
    	aX[3][15] = rX[1][23] ^ rX[1][31];
    	if(aX[3][15]) cont = cont + 1;
    	
    	if(cont > 16 - cont) 
			AX[3] = 1;
		else
			AX[3] = 0;
			
		cont = 0;
		aX[4][0] = rX[1][0] ^ rX[1][16];
    	if(aX[4][0]) cont = cont + 1;
    	aX[4][1] = rX[1][1] ^ rX[1][17];
    	if(aX[4][1]) cont = cont + 1;
    	aX[4][2] = rX[1][2] ^ rX[1][18];
    	if(aX[4][2]) cont = cont + 1;
    	aX[4][3] = rX[1][3] ^ rX[1][19];
    	if(aX[4][3]) cont = cont + 1;
    	aX[4][4] = rX[1][4] ^ rX[1][20];
    	if(aX[4][4]) cont = cont + 1;
    	aX[4][5] = rX[1][5] ^ rX[1][21];	// calcula a lógica majoritária
    	if(aX[4][5]) cont = cont + 1;
    	aX[4][6] = rX[1][6] ^ rX[1][22];
    	if(aX[4][6]) cont = cont + 1;
    	aX[4][7] = rX[1][7] ^ rX[1][23];
    	if(aX[4][7]) cont = cont + 1;
    	aX[4][8] = rX[1][8] ^ rX[1][24];
    	if(aX[4][8]) cont = cont + 1;
    	aX[4][9] = rX[1][9] ^ rX[1][25];
    	if(aX[4][9]) cont = cont + 1;
    	aX[4][10] = rX[1][10] ^ rX[1][26];
    	if(aX[4][10]) cont = cont + 1;
    	aX[4][11] = rX[1][11] ^ rX[1][27];
    	if(aX[4][11]) cont = cont + 1;
    	aX[4][12] = rX[1][12] ^ rX[1][28];
    	if(aX[4][12]) cont = cont + 1;
    	aX[4][13] = rX[1][13] ^ rX[1][29];
    	if(aX[4][13]) cont = cont + 1;
    	aX[4][14] = rX[1][14] ^ rX[1][30];
    	if(aX[4][14]) cont = cont + 1;
    	aX[4][15] = rX[1][15] ^ rX[1][31];
		if(aX[4][15]) cont = cont + 1;
		
		if(cont > 16 - cont) 
			AX[4] = 1;
		else
			AX[4] = 0;
		
		if(~AX[0]) matrix[0] = 32'b0;
		if(~AX[1]) matrix[1] = 32'b0;
		if(~AX[2]) matrix[2] = 32'b0;
		if(~AX[3]) matrix[3] = 32'b0;
		if(~AX[4]) matrix[4] = 32'b0;
		//$display("matrix[0]: %b", matrix[0]);
		
		rX[2] = matrix[0] ^ matrix[1] ^ matrix[2] ^ matrix[3] ^ matrix[4];
		rX[3] = rX[1] ^ rX[2];
		codeword = IN_wrongcodeword ^ rX[3];
		//$display("rX[3]: %b", rX[3]);
		
		// a partir daqui, vamos recalculas as lógicas majoritárias.
		
		cont = 0;
		aXX[0][0] = codeword[0]  ^ codeword[1] ^ codeword[2] ^ codeword[3];
		if(aXX[0][0]) cont = cont + 1;
		aXX[0][1] = codeword[4]  ^ codeword[5] ^ codeword[6] ^ codeword[7];
		if(aXX[0][1]) cont = cont + 1;
    	aXX[0][2] = codeword[8]  ^ codeword[9] ^ codeword[10] ^ codeword[11];
    	if(aXX[0][2]) cont = cont + 1;
    	aXX[0][3] = codeword[12] ^ codeword[13] ^ codeword[14] ^ codeword[15];
    	if(aXX[0][3]) cont = cont + 1;
    	aXX[0][4] = codeword[16] ^ codeword[17] ^ codeword[18] ^ codeword[19];
    	if(aXX[0][4]) cont = cont + 1;
    	aXX[0][5] = codeword[20] ^ codeword[21] ^ codeword[22] ^ codeword[23];
    	if(aXX[0][5]) cont = cont + 1;
    	aXX[0][6] = codeword[24] ^ codeword[25] ^ codeword[26] ^ codeword[27];
    	if(aXX[0][6]) cont = cont + 1;
    	aXX[0][7] = codeword[28] ^ codeword[29] ^ codeword[30] ^ codeword[31];
		if(aXX[0][7]) cont = cont + 1;
		
		if(cont > 8 - cont) 
			AXX[0] = 1;
		else
			AXX[0] = 0;
			
		cont = 0;
		aXX[1][0] = codeword[0]  ^ codeword[1] ^ codeword[4] ^ codeword[5];
		if(aXX[1][0]) cont = cont + 1;
    	aXX[1][1] = codeword[2]  ^ codeword[3] ^ codeword[6] ^ codeword[7];
    	if(aXX[1][1]) cont = cont + 1;
    	aXX[1][2] = codeword[8]  ^ codeword[9] ^ codeword[12] ^ codeword[13];
    	if(aXX[1][2]) cont = cont + 1;
    	aXX[1][3] = codeword[10] ^ codeword[11] ^ codeword[14] ^ codeword[15];
    	if(aXX[1][3]) cont = cont + 1;
    	aXX[1][4] = codeword[16] ^ codeword[17] ^ codeword[20] ^ codeword[21];
    	if(aXX[1][4]) cont = cont + 1;
    	aXX[1][5] = codeword[18] ^ codeword[19] ^ codeword[22] ^ codeword[23];
    	if(aXX[1][5]) cont = cont + 1;
    	aXX[1][6] = codeword[24] ^ codeword[25] ^ codeword[28] ^ codeword[29];
    	if(aXX[1][6]) cont = cont + 1;
    	aXX[1][7] = codeword[26] ^ codeword[27] ^ codeword[30] ^ codeword[31];
		if(aXX[1][7]) cont = cont + 1;
		
		if(cont > 8 - cont) 
			AXX[1] = 1;
		else
			AXX[1] = 0;
			
		cont = 0;
		aXX[2][0] = codeword[0]  ^ codeword[1] ^ codeword[8] ^ codeword[9];
		if(aXX[2][0]) cont = cont + 1;
    	aXX[2][1] = codeword[2]  ^ codeword[3] ^ codeword[10] ^ codeword[11];
    	if(aXX[2][1]) cont = cont + 1;
    	aXX[2][2] = codeword[4]  ^ codeword[5] ^ codeword[12] ^ codeword[13];
    	if(aXX[2][2]) cont = cont + 1;
    	aXX[2][3] = codeword[6]  ^ codeword[7] ^ codeword[14] ^ codeword[15];
    	if(aXX[2][3]) cont = cont + 1;
    	aXX[2][4] = codeword[16] ^ codeword[17] ^ codeword[24] ^ codeword[25];
    	if(aXX[2][4]) cont = cont + 1;
    	aXX[2][5] = codeword[18] ^ codeword[19] ^ codeword[26] ^ codeword[27];
    	if(aXX[2][5]) cont = cont + 1;
    	aXX[2][6] = codeword[20] ^ codeword[21] ^ codeword[28] ^ codeword[29];
    	if(aXX[2][6]) cont = cont + 1;
    	aXX[2][7] = codeword[22] ^ codeword[23] ^ codeword[30] ^ codeword[31];
		if(aXX[2][7]) cont = cont + 1;
		
		if(cont > 8 - cont) 
			AXX[2] = 1;
		else
			AXX[2] = 0;
	
		cont = 0;
		aXX[3][0] = codeword[0] ^ codeword[1] ^ codeword[16] ^ codeword[17];
		if(aXX[3][0]) cont = cont + 1;
    	aXX[3][1] = codeword[2] ^ codeword[3] ^ codeword[18] ^ codeword[19];
    	if(aXX[3][1]) cont = cont + 1;
    	aXX[3][2] = codeword[4] ^ codeword[5] ^ codeword[20] ^ codeword[21]; 
    	if(aXX[3][2]) cont = cont + 1;
    	aXX[3][3] = codeword[6] ^ codeword[7] ^ codeword[22] ^ codeword[23];
    	if(aXX[3][3]) cont = cont + 1;
    	aXX[3][4] = codeword[8] ^ codeword[9] ^ codeword[24] ^ codeword[25];
    	if(aXX[3][4]) cont = cont + 1;
    	aXX[3][5] = codeword[10] ^ codeword[11] ^ codeword[26] ^ codeword[27];
    	if(aXX[3][5]) cont = cont + 1;
    	aXX[3][6] = codeword[12] ^ codeword[13] ^ codeword[28] ^ codeword[29];
    	if(aXX[3][6]) cont = cont + 1;
    	aXX[3][7] = codeword[14] ^ codeword[15] ^ codeword[30] ^ codeword[31];
		if(aXX[3][7]) cont = cont + 1;
			
		if(cont > 8 - cont) 
			AXX[3] = 1;
		else
			AXX[3] = 0;
		
		cont = 0;
		aXX[4][0] = codeword[0] ^ codeword[2] ^ codeword[4] ^ codeword[6];
    	if(aXX[4][0]) cont = cont + 1;
    	aXX[4][1] = codeword[1] ^ codeword[3] ^ codeword[5] ^ codeword[7];	
    	if(aXX[4][1]) cont = cont + 1;
    	aXX[4][2] = codeword[8] ^ codeword[10] ^ codeword[12] ^ codeword[14];
    	if(aXX[4][2]) cont = cont + 1;
    	aXX[4][3] = codeword[9] ^ codeword[11] ^ codeword[13] ^ codeword[15];
    	if(aXX[4][3]) cont = cont + 1;
    	aXX[4][4] = codeword[16] ^ codeword[18] ^ codeword[20] ^ codeword[22];
    	if(aXX[4][4]) cont = cont + 1;
    	aXX[4][5] = codeword[17] ^ codeword[19] ^ codeword[21] ^ codeword[23];
    	if(aXX[4][5]) cont = cont + 1;
    	aXX[4][6] = codeword[24] ^ codeword[26] ^ codeword[28] ^ codeword[30];
    	if(aXX[4][6]) cont = cont + 1;
    	aXX[4][7] = codeword[25] ^ codeword[27] ^ codeword[29] ^ codeword[31];
    	if(aXX[4][7]) cont = cont + 1;
    	
    	if(cont > 8 - cont) 
			AXX[4] = 1;
		else
			AXX[4] = 0;
			
		cont = 0;
		aXX[5][0] = codeword[0] ^ codeword[2] ^ codeword[8] ^ codeword[10];
    	if(aXX[5][0]) cont = cont + 1;
    	aXX[5][1] = codeword[1] ^ codeword[3] ^ codeword[9] ^ codeword[11];
    	if(aXX[5][1]) cont = cont + 1;
    	aXX[5][2] = codeword[4] ^ codeword[6] ^ codeword[12] ^ codeword[14];	
    	if(aXX[5][2]) cont = cont + 1;
    	aXX[5][3] = codeword[5] ^ codeword[7] ^ codeword[13] ^ codeword[15];
    	if(aXX[5][3]) cont = cont + 1;
    	aXX[5][4] = codeword[16] ^ codeword[18] ^ codeword[24] ^ codeword[26];
    	if(aXX[5][4]) cont = cont + 1;
    	aXX[5][5] = codeword[17] ^ codeword[19] ^ codeword[25] ^ codeword[27];
    	if(aXX[5][5]) cont = cont + 1;
    	aXX[5][6] = codeword[20] ^ codeword[22] ^ codeword[28] ^ codeword[30];
    	if(aXX[5][6]) cont = cont + 1;
    	aXX[5][7] = codeword[21] ^ codeword[23] ^ codeword[29] ^ codeword[31];
		if(aXX[5][7]) cont = cont + 1;
		
		if(cont > 8 - cont) 
			AXX[5] = 1;
		else
			AXX[5] = 0;
			
		cont = 0;
		aXX[6][0] = codeword[0] ^ codeword[2] ^ codeword[16] ^ codeword[18];
		if(aXX[6][0]) cont = cont + 1;
    	aXX[6][1] = codeword[1] ^ codeword[3] ^ codeword[17] ^ codeword[19];
    	if(aXX[6][1]) cont = cont + 1;
    	aXX[6][2] = codeword[4] ^ codeword[6] ^ codeword[20] ^ codeword[22];
    	if(aXX[6][2]) cont = cont + 1;
    	aXX[6][3] = codeword[5] ^ codeword[7] ^ codeword[21] ^ codeword[23];
    	if(aXX[6][3]) cont = cont + 1;
    	aXX[6][4] = codeword[8] ^ codeword[10] ^ codeword[24] ^ codeword[26];
    	if(aXX[6][4]) cont = cont + 1;
    	aXX[6][5] = codeword[9] ^ codeword[11] ^ codeword[25] ^ codeword[27];
    	if(aXX[6][5]) cont = cont + 1;
    	aXX[6][6] = codeword[12] ^ codeword[14] ^ codeword[28] ^ codeword[30];
    	if(aXX[6][6]) cont = cont + 1;
    	aXX[6][7] = codeword[13] ^ codeword[15] ^ codeword[29] ^ codeword[31];
		if(aXX[6][7]) cont = cont + 1;
		
		if(cont > 8 - cont) 
			AXX[6] = 1;
		else
			AXX[6] = 0;
			
		cont = 0;
		aXX[7][0] = codeword[0] ^ codeword[4] ^ codeword[8] ^ codeword[12];
   	if(aXX[7][0]) cont = cont + 1;
   	aXX[7][1] = codeword[1] ^ codeword[5] ^ codeword[9] ^ codeword[13];
    	if(aXX[7][1]) cont = cont + 1;
    	aXX[7][2] = codeword[2] ^ codeword[6] ^ codeword[10] ^ codeword[14];
    	if(aXX[7][2]) cont = cont + 1;
    	aXX[7][3] = codeword[3] ^ codeword[7] ^ codeword[11] ^ codeword[15];
    	if(aXX[7][3]) cont = cont + 1;
    	aXX[7][4] = codeword[16] ^ codeword[20] ^ codeword[24] ^ codeword[28];
    	if(aXX[7][4]) cont = cont + 1;
    	aXX[7][5] = codeword[17] ^ codeword[21] ^ codeword[25] ^ codeword[29];
    	if(aXX[7][5]) cont = cont + 1;
    	aXX[7][6] = codeword[18] ^ codeword[22] ^ codeword[26] ^ codeword[30];
    	if(aXX[7][6]) cont = cont + 1;
    	aXX[7][7] = codeword[19] ^ codeword[23] ^ codeword[27] ^ codeword[31];
		if(aXX[7][7]) cont = cont + 1;
		
		if(cont > 8 - cont) 
			AXX[7] = 1;
		else
			AXX[7] = 0;
		
		cont = 0;
		aXX[8][0] = codeword[0] ^ codeword[4] ^ codeword[16] ^ codeword[20];
		if(aXX[8][0]) cont = cont + 1;
    	aXX[8][1] = codeword[1] ^ codeword[5] ^ codeword[17] ^ codeword[21];
    	if(aXX[8][1]) cont = cont + 1;
    	aXX[8][2] = codeword[2] ^ codeword[6] ^ codeword[18] ^ codeword[22];
    	if(aXX[8][2]) cont = cont + 1;
    	aXX[8][3] = codeword[3] ^ codeword[7] ^ codeword[19] ^ codeword[23];
    	if(aXX[8][3]) cont = cont + 1;
    	aXX[8][4] = codeword[8] ^ codeword[12] ^ codeword[24] ^ codeword[28];
    	if(aXX[8][4]) cont = cont + 1;
    	aXX[8][5] = codeword[9] ^ codeword[13] ^ codeword[25] ^ codeword[29];
    	if(aXX[8][5]) cont = cont + 1;
    	aXX[8][6] = codeword[10] ^ codeword[14] ^ codeword[26] ^ codeword[30];
    	if(aXX[8][6]) cont = cont + 1;
    	aXX[8][7] = codeword[11] ^ codeword[15] ^ codeword[27] ^ codeword[31];
    	if(aXX[8][7]) cont = cont + 1;
		
		if(cont > 8 - cont) 
			AXX[8] = 1;
		else
			AXX[8] = 0;
		
		cont = 0;
		aXX[9][0] = codeword[0] ^ codeword[8] ^ codeword[16] ^ codeword[24];
    	if(aXX[9][0]) cont = cont + 1;
    	aXX[9][1] = codeword[1] ^ codeword[9] ^ codeword[17] ^ codeword[25];
    	if(aXX[9][1]) cont = cont + 1;
    	aXX[9][2] = codeword[2] ^ codeword[10] ^ codeword[18] ^ codeword[26];
    	if(aXX[9][2]) cont = cont + 1;
    	aXX[9][3] = codeword[3] ^ codeword[11] ^ codeword[19] ^ codeword[27];
    	if(aXX[9][3]) cont = cont + 1;
    	aXX[9][4] = codeword[4] ^ codeword[12] ^ codeword[20] ^ codeword[28];
    	if(aXX[9][4]) cont = cont + 1;
    	aXX[9][5] = codeword[5] ^ codeword[13] ^ codeword[21] ^ codeword[29];
    	if(aXX[9][5]) cont = cont + 1;
    	aXX[9][6] = codeword[6] ^ codeword[14] ^ codeword[22] ^ codeword[30];
    	if(aXX[9][6]) cont = cont + 1;
    	aXX[9][7] = codeword[7] ^ codeword[15] ^ codeword[23] ^ codeword[31];
		if(aXX[9][7]) cont = cont + 1;
		
		if(cont > 8 - cont) 
			AXX[9] = 1;
		else
			AXX[9] = 0;
			
		if(~AXX[0]) matrix[5] = 32'b0;
		if(~AXX[1]) matrix[6] = 32'b0;
		if(~AXX[2]) matrix[7] = 32'b0;
		if(~AXX[3]) matrix[8] = 32'b0;
		if(~AXX[4]) matrix[9] = 32'b0;
		if(~AXX[5]) matrix[10] = 32'b0;
		if(~AXX[6]) matrix[11] = 32'b0;
		if(~AXX[7]) matrix[12] = 32'b0;
		if(~AXX[8]) matrix[13] = 32'b0;
		if(~AXX[9]) matrix[14] = 32'b0;
		
		rX[0] = matrix[5] ^ matrix[6] ^ matrix[7] ^ matrix[8] ^ matrix[9] ^ matrix[10] ^ matrix[11] ^ matrix[12] ^ matrix[13] ^ matrix[14];
		rX[1] = rX[0] ^ codeword;
		//$display("rX[1]: %b", rX[1]);
		
		cont = 0;
		aX[0][0] = rX[1][0] ^ rX[1][1];
		if(aX[0][0]) cont = cont + 1;
    	aX[0][1] = rX[1][2] ^ rX[1][3];
    	if(aX[0][1]) cont = cont + 1;
    	aX[0][2] = rX[1][4] ^ rX[1][5];
    	if(aX[0][2]) cont = cont + 1;
    	aX[0][3] = rX[1][6] ^ rX[1][7];
    	if(aX[0][3]) cont = cont + 1;
    	aX[0][4] = rX[1][8] ^ rX[1][9];
    	if(aX[0][4]) cont = cont + 1;
    	aX[0][5] = rX[1][10] ^ rX[1][11];
    	if(aX[0][5]) cont = cont + 1;
    	aX[0][6] = rX[1][12] ^ rX[1][13];
    	if(aX[0][6]) cont = cont + 1;
    	aX[0][7] = rX[1][14] ^ rX[1][15];
    	if(aX[0][7]) cont = cont + 1;
    	aX[0][8] = rX[1][16] ^ rX[1][17];
    	if(aX[0][8]) cont = cont + 1;
    	aX[0][9] = rX[1][18] ^ rX[1][19];
    	if(aX[0][9]) cont = cont + 1;
    	aX[0][10] = rX[1][20] ^ rX[1][21];
    	if(aX[0][10]) cont = cont + 1;
    	aX[0][11] = rX[1][22] ^ rX[1][23];
    	if(aX[0][11]) cont = cont + 1;
    	aX[0][12] = rX[1][24] ^ rX[1][25];
    	if(aX[0][12]) cont = cont + 1;
    	aX[0][13] = rX[1][26] ^ rX[1][27];
    	if(aX[0][13]) cont = cont + 1;
    	aX[0][14] = rX[1][28] ^ rX[1][29];
    	if(aX[0][14]) cont = cont + 1;
    	aX[0][15] = rX[1][30] ^ rX[1][31];
		if(aX[0][15]) cont = cont + 1;
		
		//$display("cont: %b", cont);
		if(cont > 16 - cont) 
			AX[0] = 1;
		else
			AX[0] = 0;
			
		cont = 0;
		aX[1][0] = rX[1][0] ^ rX[1][2];
    	if(aX[1][0]) cont = cont + 1;
    	aX[1][1] = rX[1][1] ^ rX[1][3];
    	if(aX[1][1]) cont = cont + 1;
    	aX[1][2] = rX[1][4] ^ rX[1][6];
    	if(aX[1][2]) cont = cont + 1;
    	aX[1][3] = rX[1][5] ^ rX[1][7];
    	if(aX[1][3]) cont = cont + 1;
    	aX[1][4] = rX[1][8] ^ rX[1][10];
    	if(aX[1][4]) cont = cont + 1;
    	aX[1][5] = rX[1][9] ^ rX[1][11];
    	if(aX[1][5]) cont = cont + 1;
    	aX[1][6] = rX[1][12] ^ rX[1][14];
    	if(aX[1][6]) cont = cont + 1;
    	aX[1][7] = rX[1][13] ^ rX[1][15];
    	if(aX[1][7]) cont = cont + 1;
    	aX[1][8] = rX[1][16] ^ rX[1][18];	// calcula a lógica majoritária
    	if(aX[1][8]) cont = cont + 1;
    	aX[1][9] = rX[1][17] ^ rX[1][19];
    	if(aX[1][9]) cont = cont + 1;
    	aX[1][10] = rX[1][20] ^ rX[1][22];
    	if(aX[1][10]) cont = cont + 1;
    	aX[1][11] = rX[1][21] ^ rX[1][23];
    	if(aX[1][11]) cont = cont + 1;
    	aX[1][12] = rX[1][24] ^ rX[1][26];
    	if(aX[1][12]) cont = cont + 1;
    	aX[1][13] = rX[1][25] ^ rX[1][27];
    	if(aX[1][13]) cont = cont + 1;
    	aX[1][14] = rX[1][28] ^ rX[1][30];
    	if(aX[1][14]) cont = cont + 1;
    	aX[1][15] = rX[1][29] ^ rX[1][31];
		if(aX[1][15]) cont = cont + 1;
		
		if(cont > 16 - cont) 
			AX[1] = 1;
		else
			AX[1] = 0;
			
		cont = 0;
		aX[2][0] = rX[1][0] ^ rX[1][4];
    	if(aX[2][0]) cont = cont + 1;
    	aX[2][1] = rX[1][1] ^ rX[1][5];
    	if(aX[2][1]) cont = cont + 1;
    	aX[2][2] = rX[1][2] ^ rX[1][6];
    	if(aX[2][2]) cont = cont + 1;
    	aX[2][3] = rX[1][3] ^ rX[1][7];
    	if(aX[2][3]) cont = cont + 1;
    	aX[2][4] = rX[1][8] ^ rX[1][12];
    	if(aX[2][4]) cont = cont + 1;
    	aX[2][5] = rX[1][9] ^ rX[1][13];
    	if(aX[2][5]) cont = cont + 1;
    	aX[2][6] = rX[1][10] ^ rX[1][14];
    	if(aX[2][6]) cont = cont + 1;
    	aX[2][7] = rX[1][11] ^ rX[1][15];
    	if(aX[2][7]) cont = cont + 1;
    	aX[2][8] = rX[1][16] ^ rX[1][20];	// calcula a lógica majoritária
    	if(aX[2][8]) cont = cont + 1;
    	aX[2][9] = rX[1][17] ^ rX[1][21];
    	if(aX[2][9]) cont = cont + 1;
    	aX[2][10] = rX[1][18] ^ rX[1][22];
    	if(aX[2][10]) cont = cont + 1;
    	aX[2][11] = rX[1][19] ^ rX[1][23];
    	if(aX[2][11]) cont = cont + 1;
    	aX[2][12] = rX[1][24] ^ rX[1][28];
    	if(aX[2][12]) cont = cont + 1;
    	aX[2][13] = rX[1][25] ^ rX[1][29];
    	if(aX[2][13]) cont = cont + 1;
    	aX[2][14] = rX[1][26] ^ rX[1][30];
    	if(aX[2][14]) cont = cont + 1;
    	aX[2][15] = rX[1][27] ^ rX[1][31];
		if(aX[2][15]) cont = cont + 1;
		
		if(cont > 16 - cont) 
			AX[2] = 1;
		else
			AX[2] = 0;
		
		cont = 0;
		aX[3][0] = rX[1][0] ^ rX[1][8];
    	if(aX[3][0]) cont = cont + 1;
    	aX[3][1] = rX[1][1] ^ rX[1][9];
    	if(aX[3][1]) cont = cont + 1;
    	aX[3][2] = rX[1][2] ^ rX[1][10];
    	if(aX[3][2]) cont = cont + 1;
    	aX[3][3] = rX[1][3] ^ rX[1][11];
    	if(aX[3][3]) cont = cont + 1;
    	aX[3][4] = rX[1][4] ^ rX[1][12];
    	if(aX[3][4]) cont = cont + 1;
    	aX[3][5] = rX[1][5] ^ rX[1][13];
    	if(aX[3][5]) cont = cont + 1;
    	aX[3][6] = rX[1][6] ^ rX[1][14];
    	if(aX[3][6]) cont = cont + 1;
    	aX[3][7] = rX[1][7] ^ rX[1][15];	// calcula a lógica majoritária
    	if(aX[3][7]) cont = cont + 1;
    	aX[3][8] = rX[1][16] ^ rX[1][24];
    	if(aX[3][8]) cont = cont + 1;
    	aX[3][9] = rX[1][17] ^ rX[1][25];
    	if(aX[3][9]) cont = cont + 1;
    	aX[3][10] = rX[1][18] ^ rX[1][26];
    	if(aX[3][10]) cont = cont + 1;
    	aX[3][11] = rX[1][19] ^ rX[1][27];
    	if(aX[3][11]) cont = cont + 1;
    	aX[3][12] = rX[1][20] ^ rX[1][28];
    	if(aX[3][12]) cont = cont + 1;
    	aX[3][13] = rX[1][21] ^ rX[1][29];
    	if(aX[3][13]) cont = cont + 1;
    	aX[3][14] = rX[1][22] ^ rX[1][30];
    	if(aX[3][14]) cont = cont + 1;
    	aX[3][15] = rX[1][23] ^ rX[1][31];
    	if(aX[3][15]) cont = cont + 1;
    	
    	if(cont > 16 - cont) 
			AX[3] = 1;
		else
			AX[3] = 0;
			
		cont = 0;
		aX[4][0] = rX[1][0] ^ rX[1][16];
    	if(aX[4][0]) cont = cont + 1;
    	aX[4][1] = rX[1][1] ^ rX[1][17];
    	if(aX[4][1]) cont = cont + 1;
    	aX[4][2] = rX[1][2] ^ rX[1][18];
    	if(aX[4][2]) cont = cont + 1;
    	aX[4][3] = rX[1][3] ^ rX[1][19];
    	if(aX[4][3]) cont = cont + 1;
    	aX[4][4] = rX[1][4] ^ rX[1][20];
    	if(aX[4][4]) cont = cont + 1;
    	aX[4][5] = rX[1][5] ^ rX[1][21];	// calcula a lógica majoritária
    	if(aX[4][5]) cont = cont + 1;
    	aX[4][6] = rX[1][6] ^ rX[1][22];
    	if(aX[4][6]) cont = cont + 1;
    	aX[4][7] = rX[1][7] ^ rX[1][23];
    	if(aX[4][7]) cont = cont + 1;
    	aX[4][8] = rX[1][8] ^ rX[1][24];
    	if(aX[4][8]) cont = cont + 1;
    	aX[4][9] = rX[1][9] ^ rX[1][25];
    	if(aX[4][9]) cont = cont + 1;
    	aX[4][10] = rX[1][10] ^ rX[1][26];
    	if(aX[4][10]) cont = cont + 1;
    	aX[4][11] = rX[1][11] ^ rX[1][27];
    	if(aX[4][11]) cont = cont + 1;
    	aX[4][12] = rX[1][12] ^ rX[1][28];
    	if(aX[4][12]) cont = cont + 1;
    	aX[4][13] = rX[1][13] ^ rX[1][29];
    	if(aX[4][13]) cont = cont + 1;
    	aX[4][14] = rX[1][14] ^ rX[1][30];
    	if(aX[4][14]) cont = cont + 1;
    	aX[4][15] = rX[1][15] ^ rX[1][31];
		if(aX[4][15]) cont = cont + 1;
		
		if(cont > 16 - cont) 
			AX[4] = 1;
		else
			AX[4] = 0;
			
		
	end
	
	assign OUT_originalword = {AXX[9], AXX[8], AXX[7], AXX[6], AXX[5], AXX[4], AXX[3], AXX[2], AXX[1], AXX[0], AX[4], AX[3], AX[2], AX[1], AX[0], codeword[0]};

endmodule
