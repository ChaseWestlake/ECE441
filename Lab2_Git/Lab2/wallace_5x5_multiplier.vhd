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

entity Wallace5x5 is
    port ( A :    in  STD_LOGIC_VECTOR (4 downto 0);
           B :    in  STD_LOGIC_VECTOR (4 downto 0);
           prod : out  STD_LOGIC_VECTOR (11 downto 0));
end Wallace5x5;

architecture structural of Wallace5x5 is

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

signal s11,s12,s13,s141,s142,s15,s16,s17,
	   s22,s23,s24,s25,s26,s27,s28,
       s32,s33,s34,s35,s36,s37,s38,s39,
       s45,s46,s47,s48,s49,s4_10: std_logic;
       
signal c11,c12,c13,c141,c142,c15,c16,c17,
	   c22,c23,c24,c25,c26,c27,c28,
       c32,c33,c34,c35,c36,c37,c38,c39,
       c45,c46,c47,c48,c49,c4_10: std_logic;
       
signal p0,p1,p2,p3,p4 : std_logic_vector(8 downto 0);

begin

process(A,B)


-- Stage 1 - generate the partial products
begin
    for i in 0 to 4 loop
        p0(i) <= A(i) and B(0);
        p1(i) <= A(i) and B(1);
        p2(i) <= A(i) and B(2);
        p3(i) <= A(i) and B(3);
        p4(i) <= A(i) and B(4);
    end loop;       
end process;


-- Stage 3 - final bits in the product    
prod(0) <= p0(0);
prod(1) <= s11;
prod(2) <= s22;
prod(3) <= s33;
prod(4) <= s34;
prod(5) <= s45;
prod(6) <= s46;
prod(7) <= s47;
prod(8) <= s48;
prod(9) <= s49;
prod(10) <= s4_10;
prod(11) <= c4_10;

-- note that all of the following port maps uses "positional port connections" rather than "explicit" connections which generally
-- makes code more readable - however in this case positional port connections is easier to follow!

-- Stage 2 - first iteration of compression
ha11 : HA port map(p0(1),p1(0),s11,c11);
fa12 : FullAdder port map(p0(2),p1(1),p2(0),s12,c12);
fa13 : FullAdder port map(p0(3),p1(2),p2(1),s13,c13);
fa141 : FullAdder port map(p0(4),p1(3),p2(2),s141,c141);
ha142 : HA port map(p3(1),p4(0),s142,c142);
fa15 : FullAdder port map(p1(4),p2(3),p3(2),s15,c15);
fa16 : FullAdder port map(p2(4),p3(3),p4(2),s16,c16);
ha17 : HA port map(p3(4),p4(3),s17,c17);

-- Stage 2 - second iteration of compression
ha22 : HA port map(c11,s12,s22,c22);
fa23 : FullAdder port map(p3(0),c12,s13,s23,c23);
fa24 : FullAdder port map(c13,s141,s142,s24,c24); 
fa25 : FullAdder port map(c141,c142,s15,s25,c25);
ha26 : HA port map(c15,s16,s26,c26);
ha27 : HA port map(c16,s17,s27,c27);
ha28 : HA port map(c17,p4(4),s28,c28);

-- Stage 2 - third iteration of compression
ha32 : HA port map(c22,s23,s33,c33);  
fa34 : FullAdder port map(c23,s24,c34,s34,c34);  
fa35 : FullAdder port map(c24,s25,p4(1),s35,c35);  
fa36 : FullAdder port map(c25,s26,c35,s36,c36); 
fa37 : FullAdder port map(c26,s27,c36,s37,c37);
fa38 : FullAdder port map(c27,s28,c37,s38,c38);
ha39 : HA port map(c28,c38,s39,c39);

-- Stage 2 - fourth iteration of compression
ha45 : HA port map(c35,s35,s45,c45);
ha46 : HA port map(s36,c45,s46,c46);
ha47 : HA port map(s37,c46,s47,c47);
ha48 : HA port map(s38,c47,s48,c48);
ha49 : HA port map(s39,c48,s49,c49);
ha4_10 : HA port map(c39,c49,s4_10,c4_10);

end structural;
