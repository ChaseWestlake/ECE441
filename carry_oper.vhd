----------------------------------------------------------------------------------
--
--  provded here by GNU General Public License Version 3.0 2007
--  https://github.com/NatsuDrag9/Kogge-Stone-Adder/blob/master/Carry_oper.vhd
--
-- Create Date: 14.04.2018 11:53:39
-- Module Name: Carry_oper - Behavioral
-- Project Name: Kogge-Stone-Adder
-- Target Devices: Xilinx Zedboard
-- Description: This file is to calculate the carry of each stage
-- Additional Comments: This intended to for educational purpose only.
                     -- Please refrain from commercial distribution.  
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Carry_oper is
    Port ( G_prev : in STD_LOGIC;
           G_curr : in STD_LOGIC;
           P_prev : in STD_LOGIC;
           P_curr : in STD_LOGIC;
           G_out : out STD_LOGIC;
           P_out : out STD_LOGIC);
end Carry_oper;

architecture Behavioral of Carry_oper is

begin
P_out <= P_prev AND P_curr;
G_out <= (P_curr AND G_prev) OR G_curr;

end Behavioral;