--------------------------------------------------------------------------------
--
-- dwc ECE441 adapted from: 
--
--  Gazi&Arli, “State Machines using VHDL
--              FPGA Implementation of Serial Communication and Display Protocols�?
--              ©2021 The Editor(s) (if applicable) and The Author(s)
--              under exclusive license to Springer Nature Switzerland AG
--
-- P6.40, p.269
--    
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_obj_motion is
    port(
        clk: in std_logic;
        buttonMoveSig: in std_logic; --Flag for switch 15
        blank_in, vsync_in: in std_logic;
        hpos, vpos: in positive range 1 to 1024;
        btn_left, btn_right: in std_logic;
        btn_up, btn_down: in std_logic;
        vga_red, vga_green, vga_blue: out std_logic_vector(3 downto 0)
);
end vga_obj_motion;

architecture logic_flow of vga_obj_motion is
signal sizeAdjust: integer range -8 to 8:=0;
signal size: positive range 1 to 1024:=8;
signal obj_X_pos: positive range 1 to 1024:=320;
signal obj_Y_pos: positive range 1 to 1024:=240;
signal obj_X_motion: integer range -8 to 8:=0;
signal obj_Y_motion: integer range -8 to 8:=0;

begin

obj_create: process( clk, blank_in, hpos, size, obj_x_pos, vpos, obj_y_pos )
begin
    if ( rising_edge( clk )) then
        if ( blank_in = '0') then
            if (( 0 <= ( hpos + size - obj_X_pos )) and
                ((obj_X_pos + size - hpos) >= 0 ) and
                ( 0 <= ( vpos + size - obj_Y_pos )) and
                (( obj_Y_pos + size - vpos ) >= 0 )) then

                vga_red <= x"f";
                vga_green <= x"0";
                vga_blue <= x"0";
            else

                vga_red <= x"f";
                vga_green <= x"f";
                vga_blue <= x"f";
            end if;
        else

            vga_red <= x"0";
            vga_green <= x"0";
            vga_blue <= x"0";
        end if;
    end if;
end process;

obj_move: process ( vsync_in, btn_down, btn_up, btn_left, btn_right, obj_Y_pos, obj_X_pos )
begin
    if( rising_edge( vsync_in ) ) then

--
-- y axis motion
--
        if(buttonMoveSig = '0') then    --Flag for switch 15
            if (btn_down='1' and btn_up='1') then
                obj_Y_motion <= 0;
    
            elsif ( btn_up='0' and btn_down='1') then
                obj_Y_motion <= 8;
    
            elsif (btn_down='0' and btn_up='1') then
                obj_Y_motion <= -8;
    
            elsif (btn_down='0' and btn_up='0') then
                obj_Y_motion <= 0;
            
            end if;
                
        

--
-- x axis motion
--
            if (btn_left='1' and btn_right='1') then
                obj_X_motion <= 0;
    
            elsif (btn_left='1' and btn_right='0') then
                obj_X_motion <= -8;
    
            elsif (btn_right='1' and btn_left='0') then
                obj_X_motion <= 8;
    
            elsif (btn_left='0' and btn_right='0') then
                obj_X_motion <= 0;
    
            end if;
    
            obj_Y_pos<=obj_Y_pos + obj_Y_motion;
            obj_X_pos<=obj_X_pos + obj_X_motion;
            
        elsif(buttonMoveSig = '1') then --Flag for switch 15
        
            if (btn_down='1' and btn_up='1') then
                sizeAdjust <= 0;
    
            elsif ( btn_up='0' and btn_down='1') then
                sizeAdjust <= -8;
    
            elsif (btn_down='0' and btn_up='1') then
                sizeAdjust <= 8;
    
            elsif (btn_down='0' and btn_up='0') then
                sizeAdjust <= 0;      
            end if;   
            size <= size + sizeAdjust;
        end if;
    end if;
end process;

end logic_flow;
