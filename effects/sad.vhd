

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sad_filter is
    Port (
        pixel_1_in : in STD_LOGIC_VECTOR( 11 downto 0 );
        pixel_2_in : in STD_LOGIC_VECTOR( 11 downto 0 );
        pixel_out : out STD_LOGIC_VECTOR( 11 downto 0 )
    );
end sad_filter;

architecture Behavioral of sad_filter is

begin

do_sad_pixel : process( pixel_1_in, pixel_2_in )

variable red_1 : unsigned( 3 downto 0 );
variable blue_1 : unsigned( 3 downto 0 );
variable green_1 : unsigned( 3 downto 0 );

variable red_2 : unsigned( 3 downto 0 );
variable blue_2 : unsigned( 3 downto 0 );
variable green_2 : unsigned( 3 downto 0 );

begin

    red_1 := unsigned( pixel_1_in( 11 downto 8 ));
    green_1 := unsigned( pixel_1_in( 7 downto 4 ));
    blue_1 := unsigned( pixel_1_in( 3 downto 0 ));

    red_2 := unsigned( pixel_2_in( 11 downto 8 ));
    green_2 := unsigned( pixel_2_in( 7 downto 4 ));
    blue_2 := unsigned( pixel_2_in( 3 downto 0 ));

    if ( red_1 > red_2 ) then
        red_1 := red_1 - red_2;
    else
        red_1 := red_2 - red_1;
    end if;

    if ( green_1 > green_2 ) then
        green_1 := green_1 - green_2;
    else
        green_1 := green_2 - green_1;
    end if;

    if ( blue_1 > blue_2 ) then
        blue_1 := blue_1 - blue_2;
    else
        blue_1 := blue_2 - blue_1;
    end if;

    pixel_out <= std_logic_vector( red_1 & green_1 & blue_1 );

end process;

end Behavioral;
