library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DecoderPHICC32 is
	PORT(	cw_in:IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			clk_d:IN STD_LOGIC;
			data_out:OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
			
end DecoderPHICC32;

architecture Behavioral of DecoderPHICC32 is
begin
	PROCESS (clk_d)
	
	VARIABLE c_word:STD_LOGIC_VECTOR(31 DOWNTO 0); --palavra codificada
	VARIABLE SCB:STD_LOGIC_VECTOR(7 DOWNTO 0); --Sindrome Check Bits
	VARIABLE SPl:STD_LOGIC_VECTOR(3 DOWNTO 0); --Sindrome Paridade de palavra(linha)
	VARIABLE SPc:STD_LOGIC_VECTOR(3 DOWNTO 0); --Sindrome Paridade de coluna
	VARIABLE SPd:STD_LOGIC_VECTOR(3 DOWNTO 0); --Sindrome Paridade de palavra desembaralhada
	VARIABLE SV:STD_LOGIC_VECTOR(3 DOWNTO 0); --sindromes dos bits de verificação
	VARIABLE SV_flag:STD_LOGIC;
	VARIABLE data:STD_LOGIC_VECTOR(15 DOWNTO 0);
	VARIABLE SCB_aux: STD_LOGIC_VECTOR(1 DOWNTO 0);

	BEGIN
		IF (clk_d'event AND clk_d='1') THEN -- testa a ocorrencia de clock (borda de subida)
			c_word(31 DOWNTO 16):=cw_in (31 DOWNTO 16);
			c_word(15 DOWNTO 12):=cw_in (15 DOWNTO 12);
			c_word(11):=cw_in (10);
			c_word(10):=cw_in (11);
			c_word(9):=cw_in (8);
			c_word(8):=cw_in (9);
			c_word(7 DOWNTO 4):=cw_in (7 DOWNTO 4);
			c_word(3):=cw_in (2);
			c_word(2):=cw_in (3);
			c_word(1):=cw_in (0);
			c_word(0):=cw_in (1);
			
			--Calculo das sindromes
			
			SV(0):=c_word(20) XOR c_word(5) XOR c_word(22) XOR c_word(7);
			SV(1):=c_word(28) XOR c_word(13) XOR c_word(30) XOR c_word(15);
			SV(2):=c_word(4) XOR c_word(21) XOR c_word(6) XOR c_word(23);
			SV(3):=c_word(12) XOR c_word(29) XOR c_word(14) XOR c_word(31);
			
			SV_flag:=SV(0) OR SV(1) OR SV(2) OR SV(3);
			
			SPl(0):=c_word(0)XOR c_word(1)XOR c_word(2)XOR c_word(3)XOR c_word(6)XOR c_word(22);
			SPl(1):=c_word(8)XOR c_word(9)XOR c_word(10)XOR c_word(11)XOR c_word(14)XOR c_word(30);
			SPl(2):=c_word(16)XOR c_word(17)XOR c_word(18)XOR c_word(19)XOR c_word(6)XOR c_word(22)XOR c_word(4)XOR c_word(20);
			SPl(3):=c_word(24)XOR c_word(25)XOR c_word(26)XOR c_word(27)XOR c_word(14)XOR c_word(30)XOR c_word(12)XOR c_word(28);

			SPc(0):=c_word(0)XOR c_word(8)XOR c_word(16)XOR c_word(24)XOR c_word(5)XOR c_word(13);
			SPc(1):=c_word(1)XOR c_word(9)XOR c_word(17)XOR c_word(25)XOR c_word(21)XOR c_word(29);
			SPc(2):=c_word(2)XOR c_word(10)XOR c_word(18)XOR c_word(26)XOR c_word(5)XOR c_word(13)XOR c_word(4)XOR c_word(20);
			SPc(3):=c_word(3)XOR c_word(11)XOR c_word(19)XOR c_word(27)XOR c_word(21)XOR c_word(29)XOR c_word(12)XOR c_word(28);
			
			
			IF (SV_flag = '0') THEN
				FOR i IN 3 DOWNTO 0 LOOP
					IF (SPl(i)= '1') THEN
						FOR j IN 3 DOWNTO 0 LOOP
							IF (SPc(j)='1') THEN
								c_word(i*8+j):=NOT c_word(i*8+j);
							END IF;
						END LOOP;
					END IF;
				END LOOP;
			END IF;
				
			
			data(0):=c_word(1);
			data(1):=c_word(16);
			data(2):=c_word(3);
			data(3):=c_word(18);
			
			data(4):=c_word(9);
			data(5):=c_word(24);
			data(6):=c_word(11);
			data(7):=c_word(26);
			
			data(8):=c_word(0);
			data(9):=c_word(17);
			data(10):=c_word(2);
			data(11):=c_word(19);
			
			data(12):=c_word(8);
			data(13):=c_word(25);
			data(14):=c_word(10);
			data(15):=c_word(27);


			SPd(0):=data(0)XOR data(1)XOR data(2)XOR data(3)XOR c_word(20);
			SPd(1):=data(4)XOR data(5)XOR data(6)XOR data(7)XOR c_word(28);
			SPd(2):=data(8)XOR data(9)XOR data(10)XOR data(11)XOR c_word(4);	
			SPd(3):=data(12)XOR data(13)XOR data(14)XOR data(15)XOR c_word(12);
			
			SCB(0):= data(0)XOR data(1)XOR c_word(5);
			SCB(1):= data(0)XOR data(2)XOR c_word(21);
			
			SCB(2):= data(4)XOR data(5)XOR c_word(13);
			SCB(3):= data(4)XOR data(6)XOR c_word(30);
			
			SCB(4):= data(8)XOR data(9)XOR c_word(20);
			SCB(5):= data(8)XOR data(10)XOR c_word(6);
			
			SCB(6):= data(12)XOR data(13)XOR c_word(27);
			SCB(7):= data(12)XOR data(14)XOR c_word(13);
			
			
			
			FOR i IN 3 DOWNTO 0 LOOP
				IF (SPd(i) = '1') THEN
					IF(SV(i) = '0')THEN
						FOR j IN 1 DOWNTO 0 LOOP
							SCB_aux(j):=SCB(i*2+j);
						END LOOP;
						
						CASE SCB_aux IS
							WHEN "11"=>
								data(i*4):= NOT data(i*4);
							WHEN "01"=>
								data(i*4+1):= NOT data(i*4+1);
							WHEN "10"=>
								data(i*4+2):= NOT data(i*4+2);
							WHEN "00"=>
								data(i*4+3):= NOT data(i*4+3);
							WHEN OTHERS=>
						END CASE;
					END IF;
				END IF;
					
			END LOOP;

		data_out(15 DOWNTO 0)<=data(15 DOWNTO 0);
		END IF;
	END PROCESS;
end Behavioral;