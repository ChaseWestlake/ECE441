

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

entity xor_filter is
    Port (
        pixel_1_in : in STD_LOGIC_VECTOR( 11 downto 0 );
        pixel_2_in : in STD_LOGIC_VECTOR( 11 downto 0 );
        pixel_out : out STD_LOGIC_VECTOR( 11 downto 0 )
    );
end xor_filter;

architecture Behavioral of xor_filter is

begin

    pixel_out <= pixel_1_in xor pixel_2_in;

end Behavioral;
