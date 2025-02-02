-----------------------------------------------------------
--
-- ECE441
--
-- Heirarchical design of a 4-bit carry lookahead adder (CLA)
-- using Partial Full Adders (PFA), Carry Propagate (P) and
-- Carry Generate (G)
--
-- (c)2022 Dr. D. Capson    Dept. of ECE
--                          University of Victoria
--
-----------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.ALL;

entity Carry_Look_Ahead_Adder is
port (
	A 	: in std_logic_vector (3 downto 0);
	B 	: in std_logic_vector (3 downto 0);
	Cin : in std_logic;
	S 	: out std_logic_vector (3 downto 0);
	Cout: out std_logic);
end Carry_Look_Ahead_Adder;


architecture gate_structure of Carry_Look_Ahead_Adder is
 
component PFA is
port (
	A 	: in std_logic;
	B 	: in std_logic;
	Cin : in std_logic;
	S : out std_logic;
	P : out std_logic;
	G : out std_logic);
end component;

signal c1,c2,c3: std_logic;
signal P,G:		 std_logic_vector(3 downto 0);

begin

PFA0: PFA port map( A => A(0), B => B(0), Cin => Cin, S => S(0), P => P(0), G => G(0) );    -- Uses Cin (global input)
PFA1: PFA port map( A => A(1), B => B(1), Cin => c1, S => S(1), P => P(1), G => G(1) );     -- Uses c1, computed from G(0) and P(0)
PFA2: PFA port map( A => A(2), B => B(2), Cin => c2, S => S(2), P => P(2), G => G(2) );     -- Uses c2, computed based on G(1), P(1), and G(0)
PFA3: PFA port map( A => A(3), B => B(3), Cin => c3, S => S(3), P => P(3), G => G(3) );     -- Uses c3, computed using G(2), P(2), G(1), etc.
 
c1 <= G(0) OR (P(0) AND Cin);
c2 <= G(1) OR (P(1) AND G(0)) OR (P(1) AND P(0) AND Cin);
c3 <= G(2) OR (P(2) AND G(1)) OR (P(2) AND P(1) AND G(0)) OR (P(2) AND P(1) AND P(0) AND Cin);
Cout <= G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND G(1)) OR (P(3) AND P(2) AND P(1) AND G(0)) OR (P(3) AND P(2) AND P(1) AND P(0) AND Cin);

end architecture gate_structure;
