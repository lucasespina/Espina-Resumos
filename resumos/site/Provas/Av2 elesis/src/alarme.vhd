Library ieee;
use ieee.std_logic_1164.all;

entity alarme is
	port(
		A, B, C, D, E, F, G:      in STD_LOGIC;
    S:        out STD_LOGIC
	);
end entity;

architecture rtl of alarme is
  -- Aqui declaramos sinais (fios auxiliares)
  -- e componentes (outros módulos) que serao
  -- utilizados nesse modulo.

  signal S1, S2: STD_LOGIC;

begin
  -- Implementação vem aqui!
  S1 <= (A and B) or (A and C) or (A and B);
  S2 <= (D and E) or (D and F) or (D and G) or (E and F) or (E and G) or (F and G);
  S <= (S1 or S2);

end architecture;
