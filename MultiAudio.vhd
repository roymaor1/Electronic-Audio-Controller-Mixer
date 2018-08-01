library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;




--  Entity Declaration

ENTITY MultiAudio IS
	PORT
	(
		CLK : IN STD_LOGIC;
		ResetN : IN STD_LOGIC;
		Enable1 : IN STD_LOGIC;
		Enable2 : IN STD_LOGIC;
		Audio1 : IN STD_LOGIC_VECTOR (7 downto 0);
		Audio2 : IN STD_LOGIC_VECTOR (7 downto 0);
		Audio3 : IN STD_LOGIC_VECTOR ( 7 downto 0);
		AudioOut : OUT STD_LOGIC_VECTOR (7 downto 0)
	);
	
END ENTITY;


--  Architecture Body

ARCHITECTURE bhv OF MultiAudio IS
	
	signal AudioSum	: STD_LOGIC_VECTOR (8 downto 0);

	
BEGIN


	process(CLK,ResetN)
		begin
			if (Resetn = '0') then
				AudioOut	<= "00000000";
				AudioSum <= "000000000";
			elsif (rising_edge(CLK)) then
			AudioSum <= "000000000";
				if (Enable1 = '0' and Enable2 = '0') then
					AudioOut <= "00000000";
				elsif (Enable1 = '1' and Enable2 = '0') then
					AudioOut <=  Audio1;
				elsif (Enable1 = '0' and Enable2 = '1') then
					AudioOut <= Audio2;
				elsif (Enable1 = '1' and Enable2 = '1') then
			
				AudioOut <= Audio3;
				end if;
			end if;

	end process;
	
END bhv;
