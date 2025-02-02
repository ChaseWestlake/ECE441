----------------------------------------------------------------------------------
--
--  provded here by GNU General Public License Version 3.0 2007
--  https://github.com/NatsuDrag9/Kogge-Stone-Adder/blob/master/generator.vhd
--
-- Create Date: 14.04.2018 11:53:39
-- Module Name: Generator
-- Project Name: Kogge-Stone-Adder
-- Target Devices: FPGA
-- Description: This file is to calculate the generator of each stage
-- Additional Comments: This intended to for educational purpose only.
                     -- Please refrain from commercial distribution.  
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Generator is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           G_out : out STD_LOGIC;
           P_out : out STD_LOGIC);
end Generator;

architecture Behavioral of Generator is

begin
P_out <= A XOR B;
G_out <= A AND B;

end Behavioral;