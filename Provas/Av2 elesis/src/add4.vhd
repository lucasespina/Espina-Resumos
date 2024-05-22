library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity add4 is
	port ( 
			a:   in  STD_LOGIC_VECTOR(3 downto 0);
			b:   in  STD_LOGIC_VECTOR(3 downto 0);
			q:  out STD_LOGIC_VECTOR(3 downto 0));
end entity;

architecture rtl of add4 is
	signal T,R : STD_LOGIC_VECTOR(3 downto 0);
	signal andp,orp : std_logic;
	signal ands, ands2, ors: std_logic;
	signal andt, andt2, andt3, ort : std_logic;
begin
	T(0)<= a(0) and b(0);
	R(0)<= a(0) xor b(0);
	T(1)<= a(1) and b(1);
	R(1)<= a(1) xor b(1);
	T(2)<= a(2) and b(2);
	R(2)<= a(2) xor b(2);
	T(3)<= a(3) and b(3);
	R(3)<= a(3) xor b(3);

	q(0)<= '0' xor R(0);

	andp<= '0' and R(0);
	orp<= andp or T(0);
	q(1)<=orp xor R(1);
	ands<= '0' and R(0) and R(1);
	ands2<= T(0) and R(1);
	ors<= ands or ands2 or T(1);
	q(2)<=ors xor R(2);
	andt<= '0' and R(0) and R(1) and R(2);
	andt2<=T(0) and R(1) and R(2);
	andt3<= T(1) and R(2);
	ort<= andt or andt2 or andt3 or T(2);
	q(3)<= ort xor R(3);

end;