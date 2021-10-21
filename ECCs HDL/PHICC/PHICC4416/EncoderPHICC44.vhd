library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EncoderPHICC44 is
PORT (input: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		cw_out: OUT STD_LOGIC_VECTOR (43 DOWNTO 0);
		clk:IN STD_LOGIC);
end EncoderPHICC44;

architecture Behavioral of EncoderPHICC44 is

begin

	PROCESS(input,clk)
	
	VARIABLE data_in:STD_LOGIC_VECTOR(15 DOWNTO 0); --dados de entrada
	VARIABLE word:STD_LOGIC_VECTOR(43 DOWNTO 0);
	
	BEGIN

	IF (clk'event AND clk='1') THEN 
		data_in:=input; --armazena os dados de entrada
    --0  1  2  3    4    5    6    7  8  9  10
    --11 12 13 14   15   16   17   18 19 20 21
    --22 23 24 25   26   27   28   29 30 31 32
    --33 34 35 36   37   38   39   40 41 42 43
		--CBs
		word(7):=data_in(0) XOR data_in(1) XOR data_in(2);
		word(29):=data_in(0) XOR data_in(1) XOR data_in(3);
		word(9):=data_in(0) XOR data_in(2) XOR data_in(3);
		word(31):=data_in(1) XOR data_in(2) XOR data_in(3);
		
		
		word(19):=data_in(4) XOR data_in(5) XOR data_in(6);
		word(41):=data_in(4) XOR data_in(5) XOR data_in(7);
		word(21):=data_in(4) XOR data_in(6) XOR data_in(7);
		word(43):=data_in(5) XOR data_in(6) XOR data_in(7);
		

		word(18):=data_in(8) XOR data_in(9) XOR data_in(10);
		word(40):=data_in(8) XOR data_in(9) XOR data_in(11);
		word(20):=data_in(8) XOR data_in(10) XOR data_in(11);
		word(42):=data_in(9) XOR data_in(10) XOR data_in(11);
		

		word(8):=data_in(12) XOR data_in(13) XOR data_in(14);
		word(30):=data_in(12) XOR data_in(13) XOR data_in(15);
		word(10):=data_in(12) XOR data_in(14) XOR data_in(15);
		word(32):=data_in(13) XOR data_in(14) XOR data_in(15);
		
		--Data
		word(0):=data_in(0);    
		word(1):=data_in(12);    
		word(2):=data_in(2);      
		word(3):=data_in(14);     
		
		word(11):=data_in(8);
		word(12):=data_in(4);
		word(13):=data_in(10);
		word(14):=data_in(6);
		
		word(22):=data_in(1);
		word(23):=data_in(13);
		word(24):=data_in(3);
		word(25):=data_in(15);
		
		word(33):=data_in(9);
		word(34):=data_in(5);
		word(35):=data_in(11);
		word(36):=data_in(7);
		
		--Pl
		word(4):=word(0) XOR word(1) XOR word(2) XOR word(3);
		word(15):=word(11) XOR word(12) XOR word(13) XOR word(14);
		word(26):=word(22) XOR word(23) XOR word(24) XOR word(25);
		word(37):=word(33) XOR word(34) XOR word(35) XOR word(36);
		--Pc
		word(5):=word(0) XOR word(11) XOR word(22) XOR word(33);
		word(16):=word(1) XOR word(12) XOR word(23) XOR word(34);
		word(27):=word(2) XOR word(13) XOR word(24) XOR word(35);
		word(38):=word(3) XOR word(14) XOR word(25) XOR word(36);
		--PCB
		word(6):=word(7) XOR word(29) XOR word(9) XOR word(31);
		word(17):=word(19) XOR word(41) XOR word(21) XOR word(43);
		word(28):=word(18) XOR word(40) XOR word(20) XOR word(42);
		word(39):=word(8) XOR word(30) XOR word(10) XOR word(32);

		cw_out(43 DOWNTO 0)<=word(43 DOWNTO 0);
		END IF;
	END Process;


end Behavioral;