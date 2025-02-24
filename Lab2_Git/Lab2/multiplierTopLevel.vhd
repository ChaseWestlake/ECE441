-----------------------------------------------------------
--
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

port (  A,B  : in std_logic_vector (7 downto 0);
        P    : out std_logic_vector (15 downto 0)
        );  
end ArrayMultiplier;

architecture structure of ArrayMultiplier is

-- intermediate signals
signal C1, C2, C3, C4, C5, C6, C7, C8 :std_logic;  -- intermediate C on each row

signal Bint1, SUMint1 : std_logic_vector (7 downto 0);  -- one between each row
signal Bint2, SUMint2 : std_logic_vector (7 downto 0);
signal Bint3, SUMint3 : std_logic_vector (7 downto 0);
signal Bint4, SUMint4 : std_logic_vector (7 downto 0);
signal Bint5, SUMint5 : std_logic_vector (7 downto 0);  -- one between each row
signal Bint6, SUMint6 : std_logic_vector (7 downto 0);
signal Bint7, SUMint7 : std_logic_vector (7 downto 0);
signal Bint8, SUMint8 : std_logic_vector (7 downto 0);

-- temp signals for holding the concatenation - just to keep Vivado happy!
signal SUMint1_temp : std_logic_vector (7 downto 0);
signal SUMint2_temp : std_logic_vector (7 downto 0);
signal SUMint3_temp : std_logic_vector (7 downto 0);
signal SUMint4_temp : std_logic_vector (7 downto 0);
signal SUMint5_temp : std_logic_vector (7 downto 0);
signal SUMint6_temp : std_logic_vector (7 downto 0);
signal SUMint7_temp : std_logic_vector (7 downto 0);

begin
    
-- here is the concatenation that Vivado doesn't like (???) when embedded in port map statements below 
SUMint1_temp <= C1&SUMint1(7 downto 1);
SUMint2_temp <= C2&SUMint2(7 downto 1);
SUMint3_temp <= C3&SUMint3(7 downto 1);
SUMint4_temp <= C4&SUMint4(7 downto 1);
SUMint5_temp <= C5&SUMint5(7 downto 1);
SUMint6_temp <= C6&SUMint6(7 downto 1);
SUMint7_temp <= C7&SUMint7(7 downto 1);

--Row0: entity work.oneRow port map( Bin=>B,     SUMin=>"00000000",       Bout=>Bint1, SUMout=>SUMint1, Ain=>A(0), Cin=>'0', Cout=>C1 );
--Row1: entity work.oneRow port map( Bin=>Bint1, SUMin=>SUMint1_temp, Bout=>Bint2, SUMout=>SUMint2, Ain=>A(1), Cin=>'0', Cout=>C2 );
--Row2: entity work.oneRow port map( Bin=>Bint2, SUMin=>SUMint2_temp, Bout=>Bint3, SUMout=>SUMint3, Ain=>A(2), Cin=>'0', Cout=>C3 );
--Row3: entity work.oneRow port map( Bin=>Bint3, SUMin=>SUMint3_temp, Bout=>Bint4, SUMout=>SUMint4, Ain=>A(3), Cin=>'0', Cout=>C4 );
--Row4: entity work.oneRow port map( Bin=>Bint4, SUMin=>SUMint4_temp, Bout=>Bint5, SUMout=>SUMint5, Ain=>A(4), Cin=>'0', Cout=>C5 );
--Row5: entity work.oneRow port map( Bin=>Bint5, SUMin=>SUMint5_temp, Bout=>Bint6, SUMout=>SUMint6, Ain=>A(5), Cin=>'0', Cout=>C6 );
--Row6: entity work.oneRow port map( Bin=>Bint6, SUMin=>SUMint6_temp, Bout=>Bint7, SUMout=>SUMint7, Ain=>A(6), Cin=>'0', Cout=>C7 );
--Row7: entity work.oneRow port map( Bin=>Bint7, SUMin=>SUMint7_temp, Bout=>Bint8, SUMout=>SUMint8, Ain=>A(7), Cin=>'0', Cout=>C8 );

Row0: entity work.oneRow port map( Bin => B,     SUMin => "00000000",      Bout => Bint1, SUMout => SUMint1, Ain => A(0), Cin => '0', Cout => C1 );
Row1: entity work.oneRow port map( Bin => Bint1, SUMin => SUMint1_temp,    Bout => Bint2, SUMout => SUMint2, Ain => A(1), Cin => '0', Cout => C2 );
Row2: entity work.oneRow port map( Bin => Bint2, SUMin => SUMint2_temp,    Bout => Bint3, SUMout => SUMint3, Ain => A(2), Cin => '0', Cout => C3 );
Row3: entity work.oneRow port map( Bin => Bint3, SUMin => SUMint3_temp,    Bout => Bint4, SUMout => SUMint4, Ain => A(3), Cin => '0', Cout => C4 );
Row4: entity work.oneRow port map( Bin => Bint4, SUMin => SUMint4_temp,    Bout => Bint5, SUMout => SUMint5, Ain => A(4), Cin => '0', Cout => C5 );
Row5: entity work.oneRow port map( Bin => Bint5, SUMin => SUMint5_temp,    Bout => Bint6, SUMout => SUMint6, Ain => A(5), Cin => '0', Cout => C6 );
Row6: entity work.oneRow port map( Bin => Bint6, SUMin => SUMint6_temp,    Bout => Bint7, SUMout => SUMint7, Ain => A(6), Cin => '0', Cout => C7 );
Row7: entity work.oneRow port map( Bin => Bint7, SUMin => SUMint7_temp,    Bout => Bint8, SUMout => SUMint8, Ain => A(7), Cin => '0', Cout => C8 );


P(0) <= SUMint1(0);
P(1) <= SUMint2(0);
P(2) <= SUMint3(0);
P(3) <= SUMint4(0);
P(4) <= SUMint5(0);
P(5) <= SUMint6(0);
P(6) <= SUMint7(0);

P(7) <= SUMint8(0);
P(8) <= SUMint8(1);
P(9) <= SUMint8(2);
P(10) <= SUMint8(3);
P(11) <= SUMint8(4);
P(12) <= SUMint8(5);
P(13) <= SUMint8(6);
P(14) <= SUMint8(7);
P(15) <= C8;

end architecture structure;
