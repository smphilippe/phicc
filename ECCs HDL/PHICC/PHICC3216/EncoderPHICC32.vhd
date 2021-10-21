library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EncoderPHICC32 is
PORT (input: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		cw_out: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		clk:IN STD_LOGIC);
end EncoderPHICC32;

architecture Behavioral of EncoderPHICC32 is

begin

	PROCESS(input,clk)
	
	VARIABLE data_in:STD_LOGIC_VECTOR(15 DOWNTO 0); --dados de entrada
	VARIABLE word:STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	BEGIN

	IF (clk'event AND clk='1') THEN 
		data_in:=input; --armazena os dados de entrada

		word(4):=data_in(8) XOR data_in(9)XOR data_in(10)XOR data_in(11);
		word(5):=data_in(0) XOR data_in(1);
		word(6):=data_in(8) XOR data_in(10);
		
		word(12):=data_in(12) XOR data_in(13)XOR data_in(14)XOR data_in(15);
		word(13):=data_in(4) XOR data_in(5);
		word(14):=data_in(12) XOR data_in(14);

		word(20):=data_in(0) XOR data_in(1)XOR data_in(2)XOR data_in(3);
		word(21):=data_in(8) XOR data_in(9);
		word(22):=data_in(0) XOR data_in(2);

		word(28):=data_in(4) XOR data_in(5)XOR data_in(6)XOR data_in(7);
		word(29):=data_in(12) XOR data_in(13);
		word(30):=data_in(4) XOR data_in(6);
		
		word(0):=data_in(8);
		word(1):=data_in(0);
		word(2):=data_in(10);
		word(3):=data_in(2);
		
		word(8):=data_in(12);
		word(9):=data_in(4);
		word(10):=data_in(14);
		word(11):=data_in(6);
		
		word(16):=data_in(1);
		word(17):=data_in(9);
		word(18):=data_in(3);
		word(19):=data_in(11);
		
		word(24):=data_in(5);
		word(25):=data_in(13);
		word(26):=data_in(7);
		word(27):=data_in(15);
			
		word(7):=word(20) XOR word(5) XOR word(22);
		word(15):=word(28) XOR word(13) XOR word(30);
		word(23):=word(4) XOR word(21) XOR word(6);
		word(31):=word(12) XOR word(29) XOR word(14);

		cw_out(31 DOWNTO 0)<= word (31 DOWNTO 0);
		END IF;
	END Process;


end Behavioral;