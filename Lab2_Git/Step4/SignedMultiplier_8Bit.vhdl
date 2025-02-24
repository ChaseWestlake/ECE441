LIBRARY ieee; 
USE ieee.std_logic_1164.ALL; 
USE ieee.std_logic_arith.ALL; 
USE ieee.std_logic_signed.ALL; 
USE ieee.std_logic_unsigned.ALL; 
ENTITY signed_mult IS 

PORT ( 
a:          IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
b:          IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
result:     OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
); 

END signed_mult; 


ARCHITECTURE rtl OF signed_mult IS 
        SIGNAL a_int, b_int:  SIGNED (8 downto 0); 
        SIGNAL pdt_int:  
        SIGNED (15 downto 0); 

BEGIN 
        a_int  <=  SIGNED (a); 
        b_int  <=  SIGNED (b); 
        pdt_int  <=  a_int * b_int; 
        result     <=  STD_LOGIC_VECTOR(pdt_int); 
END rtl; 