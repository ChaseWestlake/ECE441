------------------------------------------------------------------------------
-- Acknowledgment:  this code is based on a ChatGPT conversation Jan 2025
------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity kogge_stone_adder_8bit is
    Port ( A : in  STD_LOGIC_VECTOR(7 downto 0);
           B : in  STD_LOGIC_VECTOR(7 downto 0);
           Sum : out  STD_LOGIC_VECTOR(7 downto 0);
           Cout : out  STD_LOGIC);
end kogge_stone_adder_8bit;

architecture Behavioral of kogge_stone_adder_8bit is

    -- Declare signals for the generate (G) and propagate (P) bits
    signal G, P : STD_LOGIC_VECTOR(7 downto 0);
    signal C : STD_LOGIC_VECTOR(8 downto 0); -- Carries, C(0) is the initial carry-in
    signal P_intermediate : STD_LOGIC_VECTOR(7 downto 0); -- Intermediate propagate values

begin

    -- Generate and propagate signals - also called "Set Up"
    G(0) <= A(0) AND B(0);
    G(1) <= A(1) AND B(1);
    G(2) <= A(2) AND B(2);
    G(3) <= A(3) AND B(3);
    G(4) <= A(4) AND B(4);
    G(5) <= A(5) AND B(5);
    G(6) <= A(6) AND B(6);
    G(7) <= A(7) AND B(7);

    P(0) <= A(0) XOR B(0);
    P(1) <= A(1) XOR B(1);
    P(2) <= A(2) XOR B(2);
    P(3) <= A(3) XOR B(3);
    P(4) <= A(4) XOR B(4);
    P(5) <= A(5) XOR B(5);
    P(6) <= A(6) XOR B(6);
    P(7) <= A(7) XOR B(7);

    -- First stage (Carry-in is C(0) = '0')
    C(0) <= '0'; -- Carry-in is zero

    -- Compute carries for the next stages using generate and propagate logic
    C(1) <= G(0) OR (P(0) AND C(0)); -- First carry (C(1))
    C(2) <= G(1) OR (P(1) AND C(1)); -- Second carry (C(2))
    C(3) <= G(2) OR (P(2) AND C(2)); -- Third carry (C(3))
    C(4) <= G(3) OR (P(3) AND C(3)); -- Fourth carry (C(4))
    C(5) <= G(4) OR (P(4) AND C(4)); -- Fifth carry (C(5))
    C(6) <= G(5) OR (P(5) AND C(5)); -- Sixth carry (C(6))
    C(7) <= G(6) OR (P(6) AND C(6)); -- Seventh carry (C(7))
    C(8) <= G(7) OR (P(7) AND C(7)); -- Eighth carry (C(8))

    -- Final sum outputs
    Sum(0) <= P(0) XOR C(0); -- Sum bit 0
    Sum(1) <= P(1) XOR C(1); -- Sum bit 1
    Sum(2) <= P(2) XOR C(2); -- Sum bit 2
    Sum(3) <= P(3) XOR C(3); -- Sum bit 3
    Sum(4) <= P(4) XOR C(4); -- Sum bit 4
    Sum(5) <= P(5) XOR C(5); -- Sum bit 5
    Sum(6) <= P(6) XOR C(6); -- Sum bit 6
    Sum(7) <= P(7) XOR C(7); -- Sum bit 7

    -- Final carry-out (Cout)
    Cout <= C(8); -- Carry-out is the final carry bit

end Behavioral;

