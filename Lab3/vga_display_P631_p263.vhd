--------------------------------------------------------------------------------
--
-- dwc ECE441 adapted from:
--
--  Gazi&Arli, “State Machines using VHDL
--              FPGA Implementation of Serial Communication and Display Protocols�?
--              ©2021 The Editor(s) (if applicable) and The Author(s)
--              under exclusive license to Springer Nature Switzerland AG
--
--    P6.31, p.263
--    
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_square is
	port(
	clk: in std_logic;
	blank_in: in std_logic;
	hpos, vpos: in positive range 1 to 1024;
	Ri, Bi, Gi : in std_logic_vector(3 downto 0);
	
	vga_red, vga_green, vga_blue: out std_logic_vector(3 downto 0)
	);
end vga_square;

architecture logic_flow of vga_square is
	signal size: positive range 1 to 1024:=100;
	signal obj_X_pos: positive range 1 to 1024:=320;
	signal obj_Y_pos: positive range 1 to 1024:=240;

begin

square_draw :process(clk)
	begin

	if(rising_edge(clk)) then
        if(blank_in = '0') then
            if    ( (0<= hpos + size - obj_X_pos)
                and (obj_X_pos + size-hpos >= 0)
                and (0 <= vpos + size - obj_Y_pos)
                and (obj_Y_pos + size - vpos >= 0) ) then
                vga_red    <= Ri;--x"f";
                vga_green  <= Gi;--x"0";
                vga_blue   <= Bi;--x"0";
            else
                vga_red    <= x"f";
                vga_green  <= x"f";
                vga_blue   <= x"0";
            end if;

        else
            vga_red    <=x"0";
            vga_green  <=x"0";
            vga_blue   <=x"0";
        end if;
    end if;

end process;

end logic_flow;

