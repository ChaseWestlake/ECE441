------------------------------------------------------------------------------------------------
--
-- ECE441/ECE543 Summer 2022
--
-- 4x4 bit Wallace Tree Multiplier
--
-- this code is a corrected version
-- based on: https://vhdlguru.blogspot.com/2013/08/vhdl-code-for-wallace-tree.html
--
-------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Wallace4x4 is
    port ( A :    in  STD_LOGIC_VECTOR (3 downto 0);
           B :    in  STD_LOGIC_VECTOR (3 downto 0);
           prod : out  STD_LOGIC_VECTOR (7 downto 0));
end Wallace4x4;

architecture structural of Wallace4x4 is

component FullAdder is
    port ( X : in  STD_LOGIC;
           Y : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           SUM : out  STD_LOGIC;
           Cout : out  STD_LOGIC);
end component;

component HA is
    port ( x : in  STD_LOGIC;
           y : in  STD_LOGIC;
           S : out  STD_LOGIC;
           C : out  STD_LOGIC);
end component;

signal s11,s12,s13,s14,s15,s22,s23,s24,s25,s26,s32,s33,s34,s35,s36,s37 : std_logic;
signal c11,c12,c13,c14,c15,c22,c23,c24,c25,c26,c32,c33,c34,c35,c36,c37 : std_logic;
signal p0,p1,p2,p3 : std_logic_vector(6 downto 0);

begin

process(A,B)


-- Stage 1 - generate the partial products
begin
    for i in 0 to 3 loop
        p0(i) <= A(i) and B(0);
        p1(i) <= A(i) and B(1);
        p2(i) <= A(i) and B(2);
        p3(i) <= A(i) and B(3);
    end loop;       
end process;


-- Stage 3 - final bits in the product    
prod(0) <= p0(0);
prod(1) <= s11;
prod(2) <= s22;
prod(3) <= s33;
prod(4) <= s34;
prod(5) <= s35;
prod(6) <= s36;
prod(7) <= s37;

-- note that all of the following port maps uses "positional port connections" rather than "explicit" connections which generally
-- makes code more readable - however in this case positional port connections is easier to follow!

-- Stage 2 - first iteration of compression
ha11 : HA port map(p0(1),p1(0),s11,c11);
fa12 : FullAdder port map(p0(2),p1(1),p2(0),s12,c12);
fa13 : FullAdder port map(p0(3),p1(2),p2(1),s13,c13);
fa14 : FullAdder port map(p1(3),p2(2),p3(1),s14,c14);
ha15 : HA port map(p2(3),p3(2),s15,c15);

-- Stage 2 - second iteration of compression
ha22 : HA port map(c11,s12,s22,c22);
fa23 : FullAdder port map(p3(0),c12,s13,s23,c23);
fa24 : FullAdder port map(c13,c23,s14,s24,c24); 
fa25 : FullAdder port map(c14,c24,s15,s25,c25);
fa26 : FullAdder port map(c15,c25,p3(3),s26,c26);

-- Stage 2 - third iteration of compression
ha32 : HA port map(c22,s23,s33,c33);  
ha34 : HA port map(c33,s24,s34,c34);  
ha35 : HA port map(c34,s25,s35,c35);  
ha36 : HA port map(c35,s26,s36,c36);  
ha37 : HA port map(c36,c26,s37,c37);  -- note that c37 is generated here but not used any further

end structural;