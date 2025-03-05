--------------------------------------------------------------------------------
--
-- dwc ECE441 adapted from: 
--
--  Gazi&Arli, “State Machines using VHDL
--              FPGA Implementation of Serial Communication and Display Protocols�?
--              ©2021 The Editor(s) (if applicable) and The Author(s)
--              under exclusive license to Springer Nature Switzerland AG
--
-- P6.14, p.255
--    
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_exp1 is
	port(
		clk_100MHz: in std_logic;
		vgaRedIn, vgaBlueIn, vgaGreenIn : in std_logic_vector(3 downto 0);
		hsync, vsync: out std_logic;   -- output these to PMOD JXADC to observe
	    vga_hsync, vga_vsync: out std_logic;   -- output these to PMOD JXADC to observe7
		clk_out_25MHz: out std_logic;  -- output to JXADC to observe
		vgaRed, vgaGreen, vgaBlue: out std_logic_vector(3 downto 0)
		);
end vga_exp1;

architecture logic_flow of vga_exp1 is

	signal clk_25MHz:  std_logic;
	signal blank:      std_logic := '0';
	signal hpos, vpos: positive range 1 to 1024;
    signal vsync_out, hsync_out : std_logic;

	component clock_generator is
		port(
		clk_100MHz: in std_logic;
		clk_25MHz: out std_logic
		);
	end component;

	component vga_signal_gen is
		port(
		clk:   in std_logic;
		blank: out std_logic;
		hsync, vsync: out std_logic;
		hpos,vpos: out positive range 1 to 1024
		);
	end component;
	
	component vga_square is
		port(
		clk: in std_logic;
		blank_in: in std_logic;
		hpos, vpos: in positive range 1 to 1024;
		
		Ri, Bi, Gi : in std_logic_vector(3 downto 0);
		
		vga_red, vga_green, vga_blue: out std_logic_vector(3 downto 0)
		--vga_blank: out std_logic
		);
	end component;

begin

--vgaRedIn, vgaBlueIn, vgaGreenIn

u1: clock_generator port map(clk_100MHz => clk_100MHz, clk_25MHz => clk_25MHz);
u2: vga_signal_gen 	port map(clk => clk_25MHz, blank => blank, hsync => hsync_out, vsync => vsync_out, hpos => hpos, vpos => vpos);
u3: vga_square 		port map(clk => clk_25MHz, blank_in => blank, hpos => hpos, vpos => vpos, Ri => vgaRedIn, Bi => vgaBlueIn, Gi => vgaGreenIn,
								vga_red => vgaRed, vga_green => vgaGreen, vga_blue => vgaBlue);

clk_out_25MHz <= clk_25MHz;
vga_hsync <= hsync_out;
vga_vsync <= vsync_out;
vsync <= vsync_out;
hsync <= hsync_out;

end logic_flow;
