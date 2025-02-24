-----------------------------------------------------------
--
-- ECE441/ECE543 Lab 2
--
-- Heirarchical design of 4x4 array multiplier
--
-- (c)2022 Dr. D. Capson    Dept. of ECE
--                          University of Victoria
--
-----------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity oneRow is
   
port (  Bin,SUMin        : in  std_logic_vector (3 downto 0);
        Bout,SUMout      : out std_logic_vector (3 downto 0);
        Ain,Cin          : in std_logic; 
        Cout        : out std_logic
        );  
end oneRow;

architecture structure of oneRow is

-- our intermediate signals

  signal A1,A2,A3,A4   :  std_logic;
  signal C1,C2,C3,C4 :  std_logic;

begin
    
-- instantiate 4 cells (refer to fig of 4x4 array)
-- numbered from right to left

Cell0: entity work.multCell port map(
 
 Ain=>Ain, Bin=>Bin(0), Cin=>Cin, SUMin=> SUMin(0),
 Aout=>A1, Bout=>Bout(0), Cout=>C1, SUMout=>SUMout(0) );

Cell1: entity work.multCell port map(
 
 Ain=>A1, Bin=>Bin(1), Cin=>C1, SUMin=>SUMin(1),
 Aout=>A2, Bout=>Bout(1), Cout=>C2, SUMout=>SUMout(1) );

Cell2: entity work.multCell port map(
 
 Ain=>A2, Bin=>Bin(2), Cin=>C2, SUMin=>SUMin(2),
 Aout=>A3, Bout=>Bout(2), Cout=>C3, SUMout=>SUMout(2) );

Cell3: entity work.multCell port map(
 
 Ain=>A3, Bin=>Bin(3), Cin=>C3, SUMin=>SUMin(3),
 Aout=>A4, Bout=>Bout(3), Cout=>C4, SUMout=>SUMout(3) );

Cout <= C4;

end architecture structure;