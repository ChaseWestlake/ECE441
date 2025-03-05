--------------------------------------------------------------------------------
--
-- dwc ECE441 adapted from: 
--
--  Gazi&Arli, “State Machines using VHDL
--              FPGA Implementation of Serial Communication and Display Protocols�?
--              ©2021 The Editor(s) (if applicable) and The Author(s)
--              under exclusive license to Springer Nature Switzerland AG
-- 
--  P6.36, p.266   
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_exp2 is
	port(
		clk_100MHz: in std_logic;
		hsync, vsync: out std_logic; -- output to JXADC PMOD to observe
		btn_left, btn_right: in std_logic;
        btn_up, btn_down: in std_logic;
        
        buttonsMove: in std_logic; -- switch for buttons moving, if on size changes
        
		clk_out_25MHz: out std_logic;  -- output to JXADC PMOD to observe
		vgaRed, vgaGreen, vgaBlue: out std_logic_vector(3 downto 0)
		);
end vga_exp2;

architecture logic_flow of vga_exp2 is

signal clk_25MHz:   std_logic;
signal blank, vsync_signal:    std_logic := '0';
signal hpos, vpos: positive range 1 to 1024;


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
	
component vga_obj_motion is
    port(
        clk: in std_logic;
              
        blank_in, vsync_in, buttonMoveSig: in std_logic;
        btn_left, btn_right : in std_logic;
        btn_up, btn_down : in std_logic;
        hpos, vpos: in positive range 1 to 1024;
        vga_red, vga_green, vga_blue: out std_logic_vector(3 downto 0)
        --vga_blank: out std_logic
    );
    end component;

begin

u1: clock_generator port map(
    clk_100MHz => clk_100MHz,
    clk_25MHz => clk_25MHz
);

u2: vga_signal_gen port map(
    clk => clk_25MHz,
    blank => blank,
    hsync => hsync,
    vsync => vsync_signal,
    hpos => hpos,
    vpos => vpos
);

u3: vga_obj_motion  port map(
    clk => clk_25MHz,
    blank_in => blank,
    vsync_in => vsync_signal, 
    btn_left => btn_left,
    btn_right => btn_right,
    btn_up => btn_up,
    btn_down=> btn_down,
    hpos => hpos,
    vpos => vpos,
    buttonMoveSig => buttonsMove,
    vga_red => vgaRed,
    vga_green => vgaGreen,
    vga_blue => vgaBlue
);

vsync<=vsync_signal;
--hsync<=hsync_signal;

clk_out_25MHz <= clk_25MHz;

end logic_flow;
