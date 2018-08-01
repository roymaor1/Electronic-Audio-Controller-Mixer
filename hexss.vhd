library ieee ;
use ieee.std_logic_1164.all ;
entity hexss is port (
		din : in std_logic_vector(3 downto 0) ; 
		ss : out std_logic_vector(6 downto 0)
		);
end hexss ;
architecture arc_hexss of hexss is
begin
	process(din)
	begin
	case din is
		when "0000" => ss <= "0000001"; --0
		when "0001" => ss <= "1001111"; --1
		when "0010" => ss <= "0010010"; --2
		when "0011" => ss <= "0000110"; --3
		when "0100" => ss <= "1001100"; --4
		when "0101" => ss <= "0100100"; --5
		when "0110" => ss <= "0100000"; --6
		when "0111" => ss <= "0001111"; --7
		when "1000" => ss <= "0000000"; --8
		when "1001" => ss <= "0000100"; --9
		when "1010" => ss <= "0001000"; --10
		when "1011" => ss <= "1100000"; --11
		when "1100" => ss <= "0110001"; --12
		when "1101" => ss <= "1000010"; --13
		when "1110" => ss <= "0110000"; --14
		when "1111" => ss <= "0111000"; --15
		when others => null;
	end case;
end process;
end arc_hexss; 