-----------------------------------------------------------
--
-- ECE441/ECE543
--
-- logic gate desciption of a Partial Full Adder (PFA)
--
-- (c)2022 Dr. D. Capson    Dept. of ECE
--                          University of Victoria
--
-----------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.ALL;

entity PFA is
port (
	A   : in std_logic;
	B   : in std_logic;
	Cin : in std_logic;
	S   : out std_logic;  -- sum
	P   : out std_logic;  -- carry propagate
	G   : out std_logic); -- carry generate
end PFA;


architecture gate_structure of PFA is
 
begin
 
	S <= A xor B xor Cin;
	P <= A xor B;
	G <= A and B;
 
end architecture gate_structure;
