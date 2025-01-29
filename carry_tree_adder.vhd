----------------------------------------------------------------------------------
--
--  provded here by GNU General Public License 2007
--  https://github.com/NatsuDrag9/Kogge-Stone-Adder/blob/master/Carry_Tree_Adder.vhd
--
-- Create Date: 14.04.2018 11:53:39
-- Design Name: 4-bit Kogge-Stone Adder
-- Module Name: Kogge-Stone-Adder_main
-- Project Name: Carry Tree Adder
-- Target Devices: Xilinx ZedBoard
-- Description:  This is the main file which combines all the files and implements the adder.
-- Additional Comments: This intended to for educational purpose only.
                     -- Please refrain from commercial distribution.
                     -- Any such practice destroys the purpose of open source.
-- Author : Rohit Imandi
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Kogge_Stone_Adder is
    Port  (A : in std_logic_vector(3 downto 0);
           B : in std_logic_vector(3 downto 0);
           C_in : in STD_LOGIC_VECTOR(0 downto 0) := "0";
           C_out : out STD_LOGIC;
           Sum_out : out STD_LOGIC_VECTOR(3 downto 0));
end Kogge_Stone_Adder;

architecture Behavioral of Kogge_Stone_Adder is

    -- Stage 0
    signal g_0 : std_logic_vector(3 downto 0);
    signal p_0 : std_logic_vector(3 downto 0);
    
    -- Stage 1
    signal g1 : std_logic_vector(3 downto 0);
    signal p1 : std_logic_vector(3 downto 0);
    
    -- Stage 2
    signal g2 : std_logic_vector(3 downto 0);
    signal p2 : std_logic_vector(3 downto 0);
    
    -- Stage 3
    signal g3 : std_logic_vector(3 downto 0);
    signal p3 : std_logic_vector(3 downto 0);
    
    signal car : std_logic_vector(3 downto 0);

begin
   
-- Generating required signals
   Stage_0: 
        for i in 0 to 3 generate
            map_gen_0: entity work.Generator PORT MAP(A => A(i) , B => B(i) , G_out => g_0(i) , P_out => p_0(i) );
        end generate;
    
    -- Stage 1 operations
    -- Saving for first bit
    g1(0) <= g_0(0);
    p1(0) <= p_0(0);
    
    Stage_1 : -- Carry Operation
        for i in 0 to 2 generate
            map_car_1: entity work.Carry_oper port map (G_prev => g_0(i), P_prev => p_0(i), G_Curr => g_0(i+1), P_Curr => p_0(i+1), P_out => p1(i+1), G_out => g1(i+1));
        end generate;
     
     -- Stage 2 operations
     Storing_1:
        for i in 0 to 1 generate
            g2(i) <= g1(i);
            p2(i) <= p1(i);
        end generate;
     
     Stage_2 :
        for i in 0 to 1 generate
            map_car_2 : entity work.Carry_oper port map (G_prev => g1(i), P_prev => p1(i), G_Curr => g1(i+2), P_Curr => p1(i+2), P_out => p2(i+2), G_out => g2(i+2));
        end generate;
     
     -- Stage 3 Operations
     Storing_3 :
        for i in 0 to 3 generate
            g3(i) <= g2(i);
            p3(i) <= p2(i); 
        end generate;
     
     carry_gen :
        for i in 0 to 3 generate
            car(i) <= g3(i) OR (C_in(0) AND p3(i));
        end generate;
        
     C_out <= car(3);
     Sum_out(0) <= C_in(0) XOR p_0(0);
     
     -- Calculating final sum
     Sum :
        for i in 1 to 3 generate
            Sum_out(i) <= car(i-1) XOR p_0(i);
        end generate;
    
end Behavioral;