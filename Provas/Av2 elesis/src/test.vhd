-- --- faça em vhd Um banco quer instalar um sistema de alarme com sensores de movimento.
-- Os sensores indicam '1' quando há movimento e '0' quando não há.
-- Há duas zonas de segurança X e Y, sendo que a zona X é composta pelos sensores A, B e C enquanto a zona Y possui os sensores D, E, F e G.
-- Um alarme (S) dever ser disparado (nível lógico '1') sempre que pelo menos um dos alarmes Sx e Sy de cada zona for disparado.
-- Para que Sx seja disparado, ao menos dois dos sensores A, B e C devem indicar movimentos simultaneamente.
-- Para que Sy seja disparado, ao menos dois dos sensores D, E, F e G devem indicar movimentos simultaneamente.

-- Implemente o sistema de alarme em VHDL.

-- Descrição da entidade
entity sistema_alarme is
    port(
        A, B, C, D, E, F, G : in std_logic;
        Sx, Sy, S : out std_logic
    );
end entity;

-- Descrição da arquitetura
architecture arch of sistema_alarme is
begin
    Sx <= A and B or B and C or C and A;
    Sy <= D and E or E and F or F and G;
    S <= Sx or Sy;
end architecture;

-- Teste de unidade
library ieee;
use ieee.std_logic_1164.all;

entity tb_sistema_alarme is
end entity;

architecture tb of tb_sistema_alarme is
    signal A, B, C, D, E, F, G : std_logic;
    signal Sx, Sy, S : std_logic;
begin
    uut: entity work.sistema_alarme port map(A, B, C, D, E, F, G, Sx, Sy, S);

    process
    begin
        A <= '0'; B <= '0'; C <= '0'; D <= '0'; E <= '0'; F <= '0'; G <= '0';
        wait for 10 ns;
        assert S = '0' report "Teste 1 falhou" severity error;

        A <= '1'; B <= '0'; C <= '0'; D <= '0'; E <= '0'; F <= '0'; G <= '0';
        wait for 10 ns;
        assert S = '0' report "Teste 2 falhou" severity error;

        A <= '1'; B <= '1'; C <= '0'; D <= '0'; E <= '0'; F <= '0'; G <= '0';
        wait for 10 ns;
        assert S = '0' report "Teste 3 falhou" severity error;

        A <= '1'; B <= '1'; C <= '1'; D <= '0'; E <= '0'; F <= '0'; G <= '0';
        wait for 10 ns;
        assert S = '0' report "Teste 4 falhou" severity error;

        A <= '1'; B <= '1'; C <= '1'; D <= '1'; E <= '