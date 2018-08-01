library ieee ;
use ieee.std_logic_1164.all ;

entity reg8 is  --Register 
   port ( resetN,clk : in  std_logic                    ;
          ena        : in  std_logic                    ;
          din        : in  std_logic_vector(7 downto 0) ;
          dout       : out std_logic_vector(7 downto 0) ) ;
end reg8 ;
architecture arc_reg8 of reg8 is
begin
   process ( resetN , clk )
   begin
      if resetN = '0' then
         dout <= (others => '0') ;
      elsif clk'event and clk = '1' then
         if ena = '1' then
            dout <= din ;
         end if ;
      end if ;
   end process ;
end arc_reg8 ;
-----------------------------
library ieee ;
use ieee.std_logic_1164.all ;
entity quad8reg is          --Quad 8 registers for testing the system
   port ( resetN,clk : in  std_logic                    ;
          ena        : in  std_logic                    ;
          din        : in  std_logic_vector(7 downto 0) ;
          da         : out std_logic_vector(7 downto 0) ;
          db         : out std_logic_vector(7 downto 0) ;
          dc         : out std_logic_vector(7 downto 0) ;
          dd         : out std_logic_vector(7 downto 0) ) ;
end quad8reg ;
architecture arc_quad8reg of quad8reg is
	component reg8
	   port ( resetN,clk : in  std_logic                    ;
			  ena        : in  std_logic                    ;
			  din        : in  std_logic_vector(7 downto 0) ;
			  dout       : out std_logic_vector(7 downto 0) ) ;
	end component;
	
signal d0_out: std_logic_vector(7 downto 0) ;
signal d1_out: std_logic_vector(7 downto 0) ;
signal d2_out: std_logic_vector(7 downto 0) ;
signal d3_out: std_logic_vector(7 downto 0) ;

begin
	reg0 : reg8 port map (resetN, clk, ena, din, d0_out);
	reg1 : reg8 port map (resetN, clk, ena, d0_out, d1_out);
	reg2 : reg8 port map (resetN, clk, ena,d1_out, d2_out);
	reg3 : reg8 port map (resetN, clk, ena, d2_out, d3_out);
	
	da <= d0_out;
	db <= d1_out;
	dc <= d2_out;
	dd <= d3_out;
end arc_quad8reg ;
