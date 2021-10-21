library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DecoderPHICC40 is
	PORT(	cw_in:IN STD_LOGIC_VECTOR (39 DOWNTO 0);
			clk_d:IN STD_LOGIC;
			data_out:OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
			
end DecoderPHICC40;

architecture Behavioral of DecoderPHICC40 is
begin
	PROCESS (clk_d)
	
	VARIABLE c_word:STD_LOGIC_VECTOR(39 DOWNTO 0); --palavra codificada
	VARIABLE SCB:STD_LOGIC_VECTOR(11 DOWNTO 0); --Sindrome Check Bits
	VARIABLE SPa:STD_LOGIC_VECTOR(3 DOWNTO 0); --Sindrome Paridade de palavra(linha)
	VARIABLE SP:STD_LOGIC_VECTOR(3 DOWNTO 0); --Sindrome Paridade de coluna
	VARIABLE SPd:STD_LOGIC_VECTOR(3 DOWNTO 0); --Sindrome Paridade de palavra desembaralhada
	VARIABLE data:STD_LOGIC_VECTOR(15 DOWNTO 0);
	VARIABLE SCB_aux: STD_LOGIC_VECTOR(2 DOWNTO 0);

	BEGIN
		IF (clk_d'event AND clk_d='1') THEN -- testa a ocorrencia de clock (borda de subida)
			c_word:=cw_in;
			--Calculo das sindromes
			
			SPa(0):=c_word(0)XOR c_word(1)XOR c_word(2)XOR c_word(3)XOR c_word(4);
			SPa(1):=c_word(8)XOR c_word(9)XOR c_word(10)XOR c_word(11)XOR c_word(12);
			SPa(2):=c_word(16)XOR c_word(17)XOR c_word(18)XOR c_word(19)XOR c_word(20);
			SPa(3):=c_word(25)XOR c_word(26)XOR c_word(27)XOR c_word(28)XOR c_word(28);

			SP(0):=c_word(0)XOR c_word(8)XOR c_word(16)XOR c_word(24)XOR c_word(32);
			SP(1):=c_word(1)XOR c_word(9)XOR c_word(17)XOR c_word(25)XOR c_word(33);
			SP(2):=c_word(2)XOR c_word(10)XOR c_word(18)XOR c_word(26)XOR c_word(34);
			SP(3):=c_word(3)XOR c_word(11)XOR c_word(19)XOR c_word(27)XOR c_word(35);
			
			FOR i IN 3 DOWNTO 0 LOOP
				IF (SPa(i)= '1') THEN
					FOR j IN 3 DOWNTO 0 LOOP
						IF (SP(j)='1') THEN
							c_word(i*8+j):=NOT c_word(i*8+j);
						END IF;
					END LOOP;
				END IF;
			END LOOP;
			
			data(0):=c_word(0);
			data(1):=c_word(16);
			data(2):=c_word(2);
			data(3):=c_word(18);
			
			data(4):=c_word(9);
			data(5):=c_word(25);
			data(6):=c_word(11);
			data(7):=c_word(27);
			
			data(8):=c_word(1);
			data(9):=c_word(17);
			data(10):=c_word(3);
			data(11):=c_word(19);
			
			data(12):=c_word(10);
			data(13):=c_word(26);
			data(14):=c_word(12);
			data(15):=c_word(28);

			SPd(0):=data(0)XOR data(1)XOR data(2)XOR data(3)XOR c_word(36);
			SPd(1):=data(4)XOR data(5)XOR data(6)XOR data(7)XOR c_word(37);
			SPd(2):=data(8)XOR data(9)XOR data(10)XOR data(11)XOR c_word(38);	
			SPd(3):=data(12)XOR data(13)XOR data(14)XOR data(15)XOR c_word(39);
			
			SCB(0):= data(1)XOR data(2)XOR data(3)XOR c_word(5);
			SCB(1):= data(0)XOR data(2)XOR data(3)XOR c_word(6);
			SCB(2):= data(0)XOR data(1)XOR data(3)XOR c_word(7);
			
			SCB(3):= data(5)XOR data(6)XOR data(7) XOR c_word(13);
			SCB(4):= data(4)XOR data(6)XOR data(7) XOR c_word(14);
			SCB(5):= data(4)XOR data(5)XOR data(7) XOR c_word(15);
			
			SCB(6):= data(9)XOR data(10)XOR data(11) XOR c_word(21);
			SCB(7):= data(8)XOR data(10)XOR data(11) XOR c_word(22);
			SCB(8):= data(8)XOR data(9)XOR data(11) XOR c_word(23);
			
			SCB(9):= data(13)XOR data(14)XOR data(15) XOR c_word(29);
			SCB(10):= data(12)XOR data(14)XOR data(15) XOR c_word(30);
			SCB(11):= data(12)XOR data(13)XOR data(15) XOR c_word(31);
			
			FOR i IN 3 DOWNTO 0 LOOP										
					FOR j IN 2 DOWNTO 0 LOOP
						SCB_aux(j):=SCB(i*3+j);
					END LOOP;
							
					CASE SCB_aux IS
						WHEN "110"=>
							data(i*4):= NOT data(i*4);
						WHEN "101"=>
							data(i*4+1):= NOT data(i*4+1);
						WHEN "011"=>
							data(i*4+2):= NOT data(i*4+2);
						WHEN "111"=>
							data(i*4+3):= NOT data(i*4+3);
						WHEN OTHERS=>
					END CASE;																							
			END LOOP;

		data_out(15 DOWNTO 0)<=data(15 DOWNTO 0);
		END IF;
	END PROCESS;
end Behavioral;