Library ieee;
use ieee.std_logic_1164.all;

entity circuito is
	port(
		clock:   in STD_LOGIC;
		Up:      in STD_LOGIC;
		Gray:    out STD_LOGIC_VECTOR(1 downto 0)
	);
end entity;

architecture rtl of circuito is

	component FlipFlopD is
		port(
			clock:  in std_logic;
			d:      in std_logic;
			clear:  in std_logic;
			preset: in std_logic;
			q:     out std_logic
		);
	end component;

	signal q00, q11, a_to_A, a_to_B, a_to_C, a_to_D, g1, g0: std_logic;

begin

	
	a_to_A <= (not(g0) and not(Up));
	a_to_B <= (g0 and Up);
	q11 <= a_to_A or a_to_B;

  	ffd1: flipflopd port map(clock => clock,d => q11,clear => '0',preset => '0',q => g1);

	Gray(1) <=g1;

	a_to_C <= (g1 and not(Up));
	a_to_D <= (not(g1) and Up);
	q00 <= a_to_C or a_to_D;

	f0: flipflopd port map(clock => clock,d => q00,clear => '0',preset => '0',q => g0);
	Gray(0) <= g0;

end architecture;
