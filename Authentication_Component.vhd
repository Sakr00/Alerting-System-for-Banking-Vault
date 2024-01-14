library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Authentication_Component is
    Port ( a,b,c:in STD_LOGIC;
o:out integer:=0;
r,p:out STD_LOGIC
 );
 end Authentication_Component ;

architecture Behavioral of Authentication_Component  is

signal pass,reset:STD_LOGIC;
signal counter:integer:=0;
begin

pass<=a and b;
p<=pass;
r<=a and b and c;
process(pass)
begin
if pass='1' then 

counter<= counter+ 1;
elsif pass='0' then 
counter<= counter+ 0;
end if;
end process;	
o<=counter;
 
end Behavioral;