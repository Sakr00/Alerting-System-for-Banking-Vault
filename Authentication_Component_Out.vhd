library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Authentication_Component_Out is
    Port ( a,b,c:in STD_LOGIC;
r,p:out STD_LOGIC
 );
 end Authentication_Component_Out ;

architecture Behavioral of Authentication_Component_Out  is


begin

p<=a and b;
r<= a and b and c;
 
end Behavioral;

