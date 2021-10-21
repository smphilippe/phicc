library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EncoderPHICC36 is
PORT (input: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		cw_out: OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
		clk:IN STD_LOGIC);
end EncoderPHICC36;

architecture Behavioral of EncoderPHICC36 is

begin

	PROCESS(input,clk)
	
	VARIABLE data_in:STD_LOGIC_VECTOR(15 DOWNTO 0); --dados de entrada
	VARIABLE word:STD_LOGIC_VECTOR(35 DOWNTO 0);
	
	BEGIN

	IF (clk'event AND clk='1') THEN 
		data_in:=input; --armazena os dados de entrada
        -- CBs
		word(6):=data_in(0) XOR data_in(1);
		word(7):=data_in(0) XOR data_in(2);
		
		word(15):=data_in(4) XOR data_in(5);
		word(16):=data_in(4) XOR data_in(6);

		word(24):=data_in(8) XOR data_in(9);
		word(25):=data_in(8) XOR data_in(10);

		word(33):=data_in(12) XOR data_in(13);
		word(34):=data_in(12) XOR data_in(14);
	
		-- Data
		word(0):=data_in(0);
		word(1):=data_in(12);
		word(2):=data_in(2);
		word(3):=data_in(14);
		word(9):=data_in(8);
		word(10):=data_in(4);
		word(11):=data_in(10);
		word(12):=data_in(6);
		word(18):=data_in(1);
		word(19):=data_in(13);
		word(20):=data_in(3);
		word(21):=data_in(15);
		word(27):=data_in(9);
		word(28):=data_in(5);
		word(29):=data_in(12);
		word(30):=data_in(8);
		
		-- Pl	
		word(4):=word(0) XOR word(1) XOR word(2) XOR word(3);
		word(13):=word(9) XOR word(10) XOR word(11) XOR word(12);
		word(22):=word(18) XOR word(19) XOR word(20) XOR word(21);
		word(31):=word(24) XOR word(25) XOR word(26) XOR word(27);
		-- Pc
		word(5):=word(0) XOR word(9) XOR word(18) XOR word(27);
		word(14):=word(1) XOR word(10) XOR word(19) XOR word(28);
		word(23):=word(2) XOR word(11) XOR word(20) XOR word(29);
		word(32):=word(3) XOR word(12) XOR word(21) XOR word(30);
		-- Pd
		word(8):=data_in(0) XOR data_in(1) XOR data_in(2) XOR data_in(3);
		word(17):=data_in(4) XOR data_in(5) XOR data_in(6) XOR data_in(7);
		word(26):=data_in(8) XOR data_in(9) XOR data_in(10) XOR data_in(11);
		word(35):=data_in(12) XOR data_in(13) XOR data_in(14) XOR data_in(15);

		cw_out(35 DOWNTO 0)<=word(35 DOWNTO 0);
		END IF;
	END Process;


end Behavioral;