library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ECLC_Decoder is
	PORT(	cw_in:IN STD_LOGIC_VECTOR (39 DOWNTO 0);
			clk:IN STD_LOGIC;
			data_out:OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
			
end ECLC_Decoder;

architecture Behavioral of ECLC_Decoder is
begin
	PROCESS (clk)
		VARIABLE c_word:STD_LOGIC_VECTOR(39 DOWNTO 0); --palavra codificada
		VARIABLE SCB:STD_LOGIC_VECTOR(11 DOWNTO 0); --Sindrome Check Bits
		VARIABLE SPa:STD_LOGIC_VECTOR(3 DOWNTO 0); --Sindrome Paridade de palavra(linha)
		VARIABLE SP:STD_LOGIC_VECTOR(7 DOWNTO 0); --Sindrome Paridade de coluna
		--VARIABLE SCB_bit_vector: STD_LOGIC_VECTOR(3 DOWNTO 0);
		VARIABLE SCB_aux: STD_LOGIC_VECTOR(2 DOWNTO 0);
		VARIABLE type_error: STD_LOGIC_VECTOR(2 DOWNTO 0);
		VARIABLE count_SP: STD_LOGIC_VECTOR(3 DOWNTO 0);
	BEGIN
		IF (clk'event AND clk='1') THEN -- testa a ocorrencia de clock (borda de subida)
			c_word:=cw_in;
			count_SP:="0000";
		for k in 1 downto 0 loop			
			--Calculo das sindromes
			SCB(0):= c_word(1) XOR c_word(2) XOR c_word(3) XOR c_word(16);
			SCB(1):= c_word(0) XOR c_word(2) XOR c_word(3) XOR c_word(17);
			SCB(2):= c_word(0) XOR c_word(1) XOR c_word(3) XOR c_word(18);
			SCB(3):= c_word(5) XOR c_word(6) XOR c_word(7) XOR c_word(19);
			SCB(4):= c_word(4) XOR c_word(6) XOR c_word(7) XOR c_word(20);
			SCB(5):= c_word(4) XOR c_word(5) XOR c_word(7) XOR c_word(21);	
			SCB(6):= c_word(9) XOR c_word(10) XOR c_word(11) XOR c_word(22);
			SCB(7):= c_word(8) XOR c_word(10) XOR c_word(11) XOR c_word(23);
			SCB(8):= c_word(8) XOR c_word(9) XOR c_word(11) XOR c_word(24);
			SCB(9):= c_word(13) XOR c_word(14) XOR c_word(15) XOR c_word(25);
			SCB(10):= c_word(12) XOR c_word(14) XOR c_word(15) XOR c_word(26);
			SCB(11):= c_word(12) XOR c_word(13) XOR c_word(15) XOR c_word(27);
						
			SPa(0):=c_word(0)XOR c_word(1)XOR c_word(2)XOR c_word(3)XOR c_word(16)XOR c_word(17)XOR c_word(18)XOR c_word(28);
			SPa(1):=c_word(4)XOR c_word(5)XOR c_word(6)XOR c_word(7)XOR c_word(19)XOR c_word(20)XOR c_word(21)XOR c_word(29);
			SPa(2):=c_word(8)XOR c_word(9)XOR c_word(10)XOR c_word(11)XOR c_word(22)XOR c_word(23)XOR c_word(24)XOR c_word(30);
			SPa(3):=c_word(12)XOR c_word(13)XOR c_word(14)XOR c_word(15)XOR c_word(25)XOR c_word(26)XOR c_word(27)XOR c_word(31);

			SP(0):=c_word(0)XOR c_word(4)XOR c_word(8)XOR c_word(12)XOR c_word(32);
			SP(1):=c_word(1)XOR c_word(5)XOR c_word(9)XOR c_word(13)XOR c_word(33);
			SP(2):=c_word(2)XOR c_word(6)XOR c_word(10)XOR c_word(14)XOR c_word(34);
			SP(3):=c_word(3)XOR c_word(7)XOR c_word(11)XOR c_word(15)XOR c_word(35);
			SP(4):=c_word(16)XOR c_word(19)XOR c_word(22)XOR c_word(25)XOR c_word(36);
			SP(5):=c_word(17)XOR c_word(29)XOR c_word(23)XOR c_word(26)XOR c_word(37);
			SP(6):=c_word(18)XOR c_word(21)XOR c_word(24)XOR c_word(27)XOR c_word(38);	
			SP(7):=c_word(28)XOR c_word(29)XOR c_word(30)XOR c_word(31)XOR c_word(39);
			
			FOR c IN 7 DOWNTO 0 LOOP
				IF SP(c)='1' THEN
					count_SP := count_SP + "0001";
				END IF;
			END LOOP	;
			
			FOR i IN 3 DOWNTO 0 LOOP
				type_error(0):= SCB(i*3) OR SCB(i*3+1) OR SCB(i*3+2);
				type_error(1):= SPa(i);
				type_error(2):= SP(0)OR SP(1)OR SP(2)OR SP(3)OR SP(4)OR SP(5)OR SP(6)OR SP(7);
										
				IF (type_error = "110") OR (type_error = "101") OR ((type_error = "111")AND count_SP > "0001") THEN --Correcao com bits de paridde
					FOR j IN 3 DOWNTO 0 LOOP
						IF SP(j)='1' THEN
							c_word(i*4+j):= NOT c_word(i*4+j);
						END IF;
					END LOOP;
						
				ELSIF (type_error = "111") OR (type_error = "011")THEN --Erro impar. Correcao por Hamming
					FOR j IN 2 DOWNTO 0 LOOP
						SCB_aux(j):=SCB(i*3+j);
					END LOOP;
							
					CASE SCB_aux IS
						WHEN "110"=>
							c_word(i*4):= NOT c_word(i*4);
						WHEN "101"=>
							c_word(i*4+1):= NOT c_word(i*4+1);
						WHEN "011"=>
							c_word(i*4+2):= NOT c_word(i*4+2);
						WHEN "111"=>
							c_word(i*4+3):= NOT c_word(i*4+3);
						WHEN OTHERS=>
					END CASE;																							
				END IF;
			END LOOP;
		end loop;
		data_out<=c_word(15 DOWNTO 0);
		END IF;
	END PROCESS;
end Behavioral;