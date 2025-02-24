-----------------------------------------------------------
--


-- ************************ This is actually the 4 bit array multiplier. The other file is the 8 bit array multiplier


-- ECE441/ece543 Lab 2
--
-- Heirarchical design of 4x4 array multiplier
--
-- (c)2022 Dr. D. Capson    Dept. of ECE
--                          University of Victoria
--
-----------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ArrayMultiplier is

port (  A,B  : in std_logic_vector (3 downto 0);
        P    : out std_logic_vector (7 downto 0)
        );  
end ArrayMultiplier;

architecture structure of ArrayMultiplier is

-- intermediate signals
signal C1, C2, C3, C4 :std_logic;  -- intermediate C on each row

signal Bint1, SUMint1 : std_logic_vector (3 downto 0);  -- one between each row
signal Bint2, SUMint2 : std_logic_vector (3 downto 0);
signal Bint3, SUMint3 : std_logic_vector (3 downto 0);
signal Bint4, SUMint4 : std_logic_vector (3 downto 0);

-- temp signals for holding the concatenation - just to keep Vivado happy!
signal SUMint1_temp : std_logic_vector (3 downto 0);
signal SUMint2_temp : std_logic_vector (3 downto 0);
signal SUMint3_temp : std_logic_vector (3 downto 0);


begin
    
-- here is the concatenation that Vivado doesn't like (???) when embedded in port map statements below 
SUMint1_temp <= C1&SUMint1(3 downto 1);
SUMint2_temp <= C2&SUMint2(3 downto 1);
SUMint3_temp <= C3&SUMint3(3 downto 1);


Row0: entity work.oneRow port map( Bin=>B,     SUMin=>"0000",       Bout=>Bint1, SUMout=>SUMint1, Ain=>A(0), Cin=>'0', Cout=>C1 );
Row1: entity work.oneRow port map( Bin=>Bint1, SUMin=>SUMint1_temp, Bout=>Bint2, SUMout=>SUMint2, Ain=>A(1), Cin=>'0', Cout=>C2 );
Row2: entity work.oneRow port map( Bin=>Bint2, SUMin=>SUMint2_temp, Bout=>Bint3, SUMout=>SUMint3, Ain=>A(2), Cin=>'0', Cout=>C3 );
Row3: entity work.oneRow port map( Bin=>Bint3, SUMin=>SUMint3_temp, Bout=>Bint4, SUMout=>SUMint4, Ain=>A(3), Cin=>'0', Cout=>C4 );


P(0) <= SUMint1(0);
P(1) <= SUMint2(0);
P(2) <= SUMint3(0);

P(3) <= SUMint4(0);
P(4) <= SUMint4(1);
P(5) <= SUMint4(2);
P(6) <= SUMint4(3);

P(7) <= C4;

end architecture structure;