library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;


entity Volume_old is
port (
Note : in std_logic_vector (7 downto 0) ;
Factor : in std_logic_vector (3 downto 0) ;
resetN : in std_logic ;
processed   : out std_logic_vector (7 downto 0) );
end entity;

architecture behavior of Volume_old is


--signal div_note : std_logic_vector (7 downto 0) ;
signal div_note : std_logic_vector (7 downto 0);
signal fact : integer;
signal note_int : integer;
signal proc : std_logic_vector (7 downto 0);

begin
process (Factor , resetN)
begin
div_note <= (Note);
if (resetN = '0') then
	div_note <= conv_std_logic_vector(conv_integer(div_note)/4,8); --div by 4
	processed <= div_note;
else
	note_int <= conv_integer(div_note)/8; --div by 8
	fact <= conv_integer(Factor);
	proc <= conv_std_logic_vector(note_int*fact,8); --signal tap check digits
	processed <= proc;
end if;


end process;

end architecture;