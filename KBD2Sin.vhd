library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use ieee.std_logic_arith.all; 




entity KBD2Sin is
port (
resetN : in std_logic ;
clk : in std_logic ;
din : in std_logic_vector (7 downto 0);
make : in std_logic ;
break : in std_logic ;
finishedEnable : in std_logic ;
Record1Enable : out std_logic ;
NoteEnable : out std_logic ;
UpEnable1   : out std_logic ;
DownEnable1   : out std_logic ;
UpEnable2   : out std_logic ;
DownEnable2   : out std_logic ;
NoteFreq : out std_logic_vector (9 downto 0);
Audio1Enable : out std_logic;
Audio2Enable : out std_logic;
UpSpeedEnable1 : out std_logic;
DownSpeedEnable1 : out std_logic;
UpSpeedEnable2 : out std_logic;
DownSpeedEnable2 : out std_logic;
mode : out std_logic_vector (1 downto 0);
ADSR_Enable : out std_logic ;
KololoEnable : out std_logic );

end KBD2Sin;

architecture behavior of KBD2Sin is




signal pressed: std_logic;
signal play1: std_logic;
signal play2: std_logic;
signal karaoke_play: std_logic;
signal mode_sig: std_logic_vector (1 downto 0);
signal adsr_play: std_logic;
signal kololo_play: std_logic;
begin
process (resetN , clk)
begin
if resetN = '0' then
	pressed <= '0';
	NoteFreq <= "0000000000";	
	NoteEnable <= '0';
	UpEnable1 <='0';
	DownEnable1 <= '0';
	UpEnable2 <='0';
	DownEnable2 <= '0';
	Record1Enable <= '0';
	Audio1Enable <= '0';
	Audio2Enable <= '0';
	UpSpeedEnable1 <= '0';
	DownSpeedEnable1 <= '0';
	UpSpeedEnable2 <= '0';
	DownSpeedEnable2 <= '0';
	mode_sig <= "00";
	mode <= "00";
	karaoke_play <= '0';
	ADSR_Enable <= '0';
	adsr_play <= '0';
	kololo_play <= '0';
	KololoEnable <= '0';
	
elsif rising_edge(clk) then
		if (finishedEnable ='1')then
				if karaoke_play = '0' then
					karaoke_play <= '1';
					Record1Enable <= '1';
					else
					karaoke_play <= '0';
					Record1Enable <= '0';
				end if;
		end if;
	if (make = '1' and pressed = '0') then
	pressed <= '1';
	NoteFreq <= "0000000000";	
	NoteEnable <= '0';
	UpEnable1 <='0';
	DownEnable1 <= '0';
	UpEnable2 <='0';
	DownEnable2 <= '0';
	--Record1Enable <= '0';
	UpSpeedEnable1 <= '0';
	DownSpeedEnable1 <= '0';
	UpSpeedEnable2 <= '0';
	DownSpeedEnable2 <= '0';

			case mode_sig is
			when "00" =>  --piano
			case din is
				when "00010110" => --16 (1)
				 NoteFreq <= conv_std_logic_vector(402,10); --according to 27Hz CLK
				 NoteEnable <= '1';
				when "00011110" => --1E (2)
				NoteFreq <= conv_std_logic_vector(359,10);
				NoteEnable <= '1';
				when "00100110" => --26 (3)
				NoteFreq <= conv_std_logic_vector(319,10);
				NoteEnable <= '1';
				when "00100101" => --25 (4)
				NoteFreq <= conv_std_logic_vector(301,10);
				NoteEnable <= '1';
				when "00101110" => --2E (5)
				NoteFreq <= conv_std_logic_vector(268,10);
				NoteEnable <= '1';
				when "00110110" => --36 (6)
				NoteFreq <= conv_std_logic_vector(240,10);
				NoteEnable <= '1';
				when "00111101" => --3D (7)
				NoteFreq <= conv_std_logic_vector(213,10);
				NoteEnable <= '1';
				when "00000101" => --05 (F1)
				NoteFreq <= conv_std_logic_vector(380,10);
				NoteEnable <= '1';
				when "00000110" => --06 (F2)
				NoteFreq <= conv_std_logic_vector(338,10);
				NoteEnable <= '1';
				when "00000100" => --04 (F3)
				NoteFreq <= conv_std_logic_vector(285,10);
				NoteEnable <= '1';
				when "00001100" => --0C (F4)
				NoteFreq <= conv_std_logic_vector(253,10);
				NoteEnable <= '1';
				when "00000011" => --03 (F5)
				NoteFreq <= conv_std_logic_vector(226,10);
				NoteEnable <= '1';
				when "00101001" => --29 (space)
				mode_sig <= "01";
				when others => null;
			end case;
			
			when "01" =>  --music
			case din is
			when "01110101" => --75 vol up
			UpEnable1 <='1';
			when "01110010" => --72 vol down
			DownEnable1 <= '1';
			when "01111101" => --7D vol2 up
			UpEnable2 <='1';
			when "01111010" => --7A vol2 down
			DownEnable2 <= '1';
			when "00010101" => --15 (Q)
				if(play1 = '0') then -- play
					Audio1Enable <= '1';
					play1 <= '1';
				else --stop
					Audio1Enable <= '0';
					play1 <= '0';
				end if;
			when "00011101" => --1D (W)
				if(play2 = '0') then
					Audio2Enable <= '1';
					play2 <= '1';
				else
					Audio2Enable <= '0';
					play2 <= '0';
				end if;
			when "01101100" => --6C Speed1Up
				UpSpeedEnable1 <= '1';
			when "01101001" =>
				DownSpeedEnable1 <= '1';-- 69 Speed1Down
			when "01110000" => -- 70 Speed2Up
				UpSpeedEnable2 <= '1';
			when "01110001" => -- 71 Speed2Down
				DownSpeedEnable2 <= '1';
			when "00100100" => -- 24 (E for Exponent)
				if(adsr_play = '0') then
				ADSR_Enable <= '1';
				adsr_play <= '1';
				else
				ADSR_Enable <= '0';
				adsr_play <= '0';
				end if;
			when "00101001" => --29 (space)
			mode_sig <= "10";
			Audio1Enable <= '0';
			Audio2Enable <= '0';
			play1 <= '0';
			play2 <= '0';
			adsr_play <= '0';
			ADSR_Enable <= '0';
			when others => null;
			end case;
			
			
			when "10" =>  --karaoke
			case din is
			when "00101101" => --2d (R)
			if karaoke_play = '0' then
			karaoke_play <= '1';
			Record1Enable <= '1';
			else
			karaoke_play <= '0';
			Record1Enable <= '0';
			end if;
			
			when "00101100" => -- 2c (T)
			if(kololo_play = '0') then
			KololoEnable <= '1';
			kololo_play <= '1';
			else
			KololoEnable <= '0';
			kololo_play <= '0';
			end if;
			
			when "00101001" => --29 (space)
			mode_sig <= "00";
			karaoke_play <= '0';
			Record1Enable <= '0';
			kololo_play <= '0';
			KololoEnable <= '0';
			when others => null;
			end case;

			when others => null;
			end case;
	end if;
	
	
if(break = '1') then
	pressed <= '0';
	NoteFreq <= "0000000000";	
	NoteEnable <= '0';
	UpEnable1 <='0';
	DownEnable1 <= '0';
	UpEnable2 <='0';
	DownEnable2 <= '0';
	UpSpeedEnable1 <= '0';
	DownSpeedEnable1 <= '0';
	UpSpeedEnable2 <= '0';
	DownSpeedEnable2 <= '0';
end if;
end if;


mode <= mode_sig;
end process;
end architecture;