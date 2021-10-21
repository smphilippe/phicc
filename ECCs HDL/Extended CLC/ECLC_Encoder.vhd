library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ECLC_Encoder is
PORT (clk: IN STD_LOGIC;
		data_in: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		cw_out: OUT STD_LOGIC_VECTOR (39 DOWNTO 0));
end ECLC_Encoder;

architecture Behavioral of ECLC_Encoder is

begin
	PROCESS(clk)
		VARIABLE dados:STD_LOGIC_VECTOR(15 DOWNTO 0); --dados de entrada
		VARIABLE CB:STD_LOGIC_VECTOR(11 DOWNTO 0); --Check Bits
		VARIABLE Pa:STD_LOGIC_VECTOR(3 DOWNTO 0); --Paridade de palavra(linha)
		VARIABLE P:STD_LOGIC_VECTOR(7 DOWNTO 0); --Paridade de coluna
	BEGIN
		IF (clk'event AND clk='1') THEN -- testa a ocorrencia de clock (borda de subida)
			dados(15 DOWNTO 0):=data_in(15 DOWNTO 0); --armazena os dados de entrada			
				--codificacao dos check bits
			CB(0):=dados(1)XOR dados(2)XOR dados(3);
			CB(1):=dados(0)XOR dados(2)XOR dados(3);
			CB(2):=dados(0)XOR dados(1)XOR dados(3);
			CB(3):=dados(5)XOR dados(6)XOR dados(7);
			CB(4):=dados(4)XOR dados(6)XOR dados(7);
			CB(5):=dados(4)XOR dados(5)XOR dados(7);	
			CB(6):=dados(9)XOR dados(10)XOR dados(11);
			CB(7):=dados(8)XOR dados(10)XOR dados(11);
			CB(8):=dados(8)XOR dados(9)XOR dados(11);
			CB(9):=dados(13)XOR dados(14)XOR dados(15);
			CB(10):=dados(12)XOR dados(14)XOR dados(15);
			CB(11):=dados(12)XOR dados(13)XOR dados(15);
				
				--codificacao dos bits de paridade
				
			Pa(0):=dados(0)XOR dados(1)XOR dados(2)XOR dados(3)XOR CB(0)XOR CB(1)XOR CB(2);
			Pa(1):=dados(4)XOR dados(5)XOR dados(6)XOR dados(7)XOR CB(3)XOR CB(4)XOR CB(5);
			Pa(2):=dados(8)XOR dados(9)XOR dados(10)XOR dados(11)XOR CB(6)XOR CB(7)XOR CB(8);
			Pa(3):=dados(12)XOR dados(13)XOR dados(14)XOR dados(15)XOR CB(9)XOR CB(10)XOR CB(11);

			P(0):=dados(0)XOR dados(4)XOR dados(8)XOR dados(12);
			P(1):=dados(1)XOR dados(5)XOR dados(9)XOR dados(13);
			P(2):=dados(2)XOR dados(6)XOR dados(10)XOR dados(14);
			P(3):=dados(3)XOR dados(7)XOR dados(11)XOR dados(15);
			P(4):=CB(0)XOR CB(3)XOR CB(6)XOR CB(9);
			P(5):=CB(1)XOR CB(4)XOR CB(7)XOR CB(10);
			P(6):=CB(2)XOR CB(5)XOR CB(8)XOR CB(11);	
			P(7):=Pa(0)XOR Pa(1)XOR Pa(2)XOR Pa(3);

			cw_out(39 DOWNTO 0)<=P(7 DOWNTO 0)&Pa(3 DOWNTO 0)&CB(11 DOWNTO 0)&dados(15 DOWNTO 0);
		END IF;
	END Process;

end Behavioral;
