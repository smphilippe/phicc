library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DecoderPHICC44 is
	PORT(	cw_in:IN STD_LOGIC_VECTOR (43 DOWNTO 0);
			clk_d:IN STD_LOGIC;
			data_out:OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
			
end DecoderPHICC44;

architecture Behavioral of DecoderPHICC44 is
begin
	PROCESS (clk_d)
	
	VARIABLE c_word:STD_LOGIC_VECTOR(43 DOWNTO 0); --palavra codificada
	VARIABLE SCB:STD_LOGIC_VECTOR(15 DOWNTO 0); --Sindrome Check Bits
	VARIABLE SPa:STD_LOGIC_VECTOR(3 DOWNTO 0); --Sindrome Paridade de palavra(linha)
	VARIABLE SP:STD_LOGIC_VECTOR(3 DOWNTO 0); --Sindrome Paridade de coluna
	VARIABLE SPCB:STD_LOGIC_VECTOR(3 DOWNTO 0); --Sindrome Paridade de palavra desembaralhada
	VARIABLE data:STD_LOGIC_VECTOR(15 DOWNTO 0);
	VARIABLE SCB_aux: STD_LOGIC_VECTOR(3 DOWNTO 0);
	VARIABLE SPCB_flag: STD_LOGIC;

	BEGIN
		IF (clk_d'event AND clk_d='1') THEN -- testa a ocorrencia de clock (borda de subida)
			c_word:=cw_in;
			
	--   Data       Pl   Pc   PCB      CB
	--0  1  2  3    4    5    6    7  8  9  10
    --11 12 13 14   15   16   17   18 19 20 21
    --22 23 24 25   26   27   28   29 30 31 32
    --33 34 35 36   37   38   39   40 41 42 43
	
			--Calculo das sindromes
			
			SPa(0):=c_word(0)XOR c_word(1)XOR c_word(2)XOR c_word(3)XOR c_word(4);
			SPa(1):=c_word(11)XOR c_word(12)XOR c_word(13)XOR c_word(14)XOR c_word(15);
			SPa(2):=c_word(22)XOR c_word(23)XOR c_word(24)XOR c_word(25)XOR c_word(26);
			SPa(3):=c_word(33)XOR c_word(34)XOR c_word(35)XOR c_word(36)XOR c_word(37);

			SP(0):=c_word(0)XOR c_word(11)XOR c_word(22)XOR c_word(33)XOR c_word(5);
			SP(1):=c_word(1)XOR c_word(12)XOR c_word(23)XOR c_word(34)XOR c_word(16);
			SP(2):=c_word(2)XOR c_word(13)XOR c_word(24)XOR c_word(35)XOR c_word(27);
			SP(3):=c_word(3)XOR c_word(14)XOR c_word(25)XOR c_word(36)XOR c_word(38);
			
			FOR i IN 3 DOWNTO 0 LOOP
				IF (SPa(i)= '1') THEN
					FOR j IN 3 DOWNTO 0 LOOP
						IF (SP(j)='1') THEN
							c_word(i*11+j):=NOT c_word(i*11+j);
						END IF;
					END LOOP;
				END IF;
			END LOOP;
			
			data(0):=c_word(0);
			data(1):=c_word(22);
			data(2):=c_word(2);
			data(3):=c_word(24);
			
			data(4):=c_word(12);
			data(5):=c_word(34);
			data(6):=c_word(14);
			data(7):=c_word(36);
			
			data(8):=c_word(11);
			data(9):=c_word(33);
			data(10):=c_word(13);
			data(11):=c_word(35);
			
			data(12):=c_word(1);
			data(13):=c_word(23);
			data(14):=c_word(3);
			data(15):=c_word(25);
			
			
			SPCB(0):=c_word(7)XOR c_word(29)XOR c_word(9)XOR c_word(31)XOR c_word(6);
			SPCB(1):=c_word(19)XOR c_word(41)XOR c_word(21)XOR c_word(43)XOR c_word(17);
			SPCB(2):=c_word(18)XOR c_word(40)XOR c_word(20)XOR c_word(42)XOR c_word(28);
			SPCB(3):=c_word(8)XOR c_word(30)XOR c_word(10)XOR c_word(32)XOR c_word(39);
			
			SPCB_flag:=SPCB(0) OR SPCB(1) OR SPCB(2) OR SPCB(3);
			
			SCB(0):= data(0)XOR data(1)XOR data(2)XOR c_word(7);
			SCB(1):= data(0)XOR data(1)XOR data(3)XOR c_word(8);
			SCB(2):= data(0)XOR data(2)XOR data(3)XOR c_word(9);
			SCB(3):= data(1)XOR data(2)XOR data(3)XOR c_word(10);
			
			SCB(4):= data(4)XOR data(5)XOR data(6) XOR c_word(18);
			SCB(5):= data(4)XOR data(5)XOR data(7) XOR c_word(19);
			SCB(6):= data(4)XOR data(6)XOR data(7) XOR c_word(20);
			SCB(7):= data(5)XOR data(6)XOR data(7)XOR c_word(21);
			
			SCB(8):= data(8)XOR data(9)XOR data(10) XOR c_word(29);
			SCB(9):= data(8)XOR data(9)XOR data(11) XOR c_word(30);
			SCB(10):= data(8)XOR data(10)XOR data(11) XOR c_word(31);
			SCB(11):= data(9)XOR data(10)XOR data(11)XOR c_word(32);
			
			SCB(12):= data(12)XOR data(13)XOR data(14) XOR c_word(40);
			SCB(13):= data(12)XOR data(13)XOR data(15) XOR c_word(41);
			SCB(14):= data(12)XOR data(14)XOR data(15) XOR c_word(42);
			SCB(15):= data(13)XOR data(14)XOR data(15)XOR c_word(43);
			
			
			IF (SPCB_flag ='0')	THEN
				FOR i IN 3 DOWNTO 0 LOOP										
						FOR j IN 3 DOWNTO 0 LOOP
							SCB_aux(j):=SCB(i*4+j);
						END LOOP;
						
						CASE SCB_aux IS

							WHEN "1110"=>
								data(i*4):= NOT data(i*4);
							WHEN "1101"=>
								data(i*4+1):= NOT data(i*4+1);
							WHEN "1011"=>
								data(i*4+2):= NOT data(i*4+2);
							WHEN "0111"=>
								data(i*4+3):= NOT data(i*4+3);
								
							WHEN "0011"=>
								data(i*4):= NOT data(i*4);
								data(i*4+1):= NOT data(i*4+1);
							WHEN "0101"=>
								data(i*4):= NOT data(i*4);
								data(i*4+2):= NOT data(i*4+2);
							WHEN "1001"=>
								data(i*4):= NOT data(i*4);
								data(i*4+3):= NOT data(i*4+3);
								
							WHEN "0110"=>
								data(i*4+1):= NOT data(i*4+1);
								data(i*4+2):= NOT data(i*4+2);
							WHEN "1010"=>
								data(i*4+1):= NOT data(i*4+1);
								data(i*4+3):= NOT data(i*4+3);
							WHEN "1100"=>
								data(i*4+2):= NOT data(i*4+2);
								data(i*4+3):= NOT data(i*4+3);
							WHEN OTHERS=>
						END CASE;																							
				END LOOP;
			END IF;

		data_out(15 DOWNTO 0)<=data(15 DOWNTO 0);
		END IF;
	END PROCESS;
end Behavioral;