-----------------------------------------------------------
--
-- ECE441/ECE543 Lab 2
--
-- Heirarchical design of 4x4 array multiplier
-- based on Figure 4.15 of textbook
--
-- (c)2022 Dr. D. Capson    Dept. of ECE
--                          University of Victoria
--
-----------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity multCell is
port (  Ain, Bin, Cin, SUMin     : in  std_logic;
        Aout, Bout, Cout, SUMout : out std_logic
        );  
end multCell;

architecture structure of multCell is
    
    signal ppNi,Cint,SUMint : std_logic; -- our intermediate signal

begin
    
--  instantiate FA

  ppNi <= Ain AND Bin;

  Cell : entity work.FA port map(
      a=>SUMin, 
      b=>ppNi, 
      cin=>Cin, 
      sum=>SUMint, 
      c=>Cint 
  );
  Aout <= Ain;
  Bout <= Bin;
  Cout <= Cint;
  SUMout <= SUMint;

end architecture structure;