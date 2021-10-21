library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EncoderPHICC40 is
PORT (input: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		cw_out: OUT STD_LOGIC_VECTOR (39 DOWNTO 0);
		clk:IN STD_LOGIC);
end EncoderPHICC40;

architecture Behavioral of EncoderPHICC40 is

begin

	PROCESS(input,clk)
	
	VARIABLE data_in:STD_LOGIC_VECTOR(15 DOWNTO 0); --dados de entrada
	VARIABLE word:STD_LOGIC_VECTOR(39 DOWNTO 0);
	
	BEGIN

	IF (clk'event AND clk='1') THEN 
		data_in:=input; --armazena os dados de entrada

		word(5):=data_in(1) XOR data_in(2) XOR data_in(3);
		word(6):=data_in(0) XOR data_in(2) XOR data_in(3);
		word(7):=data_in(0) XOR data_in(1) XOR data_in(3);
		
		word(13):=data_in(5) XOR data_in(6) XOR data_in(7);
		word(14):=data_in(4) XOR data_in(6) XOR data_in(7);
		word(15):=data_in(4) XOR data_in(5) XOR data_in(7);

		word(21):=data_in(9) XOR data_in(10) XOR data_in(11);
		word(22):=data_in(8) XOR data_in(10) XOR data_in(11);
		word(23):=data_in(8) XOR data_in(9) XOR data_in(11);

		word(29):=data_in(13) XOR data_in(14) XOR data_in(15);
		word(30):=data_in(12) XOR data_in(14) XOR data_in(15);
		word(31):=data_in(12) XOR data_in(13) XOR data_in(15);
		
		word(0):=data_in(0);    
		word(1):=data_in(12);    
		word(2):=data_in(2);      
		word(3):=data_in(14);     
		
		word(8):=data_in(8);
		word(9):=data_in(4);
		word(10):=data_in(10);
		word(11):=data_in(6);
		
		word(16):=data_in(1);
		word(17):=data_in(13);
		word(18):=data_in(3);
		word(19):=data_in(15);
		
		word(24):=data_in(9);
		word(25):=data_in(5);
		word(26):=data_in(11);
		word(27):=data_in(7);
			
		word(4):=word(0) XOR word(1) XOR word(2) XOR word(3);
		word(12):=word(8) XOR word(9) XOR word(10) XOR word(11);
		word(20):=word(16) XOR word(17) XOR word(18) XOR word(19);
		word(28):=word(24) XOR word(25) XOR word(26) XOR word(27);
		
		word(32):=word(0) XOR word(8) XOR word(16) XOR word(24);
		word(33):=word(1) XOR word(9) XOR word(17) XOR word(25);
		word(34):=word(2) XOR word(10) XOR word(18) XOR word(26);
		word(35):=word(3) XOR word(11) XOR word(19) XOR word(27);
		
		word(36):=data_in(0) XOR data_in(1) XOR data_in(2) XOR data_in(3);
		word(37):=data_in(4) XOR data_in(5) XOR data_in(6) XOR data_in(7);
		word(38):=data_in(8) XOR data_in(9) XOR data_in(10) XOR data_in(11);
		word(39):=data_in(12) XOR data_in(13) XOR data_in(14) XOR data_in(15);

		cw_out(39 DOWNTO 0)<=word(39 DOWNTO 0);
		END IF;
	END Process;


end Behavioral;