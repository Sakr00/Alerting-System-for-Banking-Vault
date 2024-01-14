library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Authentication_Component is
    Port ( door1, door2, alert, water, poison, holes: out std_logic;
        hand, face, exSen, wSen, reset, clk: in std_logic;
		  number_of_enteries : out integer;
        inSen: in std_logic_vector(2 downto 0)
		  );
end Authentication_Component;
architecture Behavioral of Authentication_Component is
component Authentication_Logic is
port(a,b,c:in STD_LOGIC;
o: out integer:=0;
r,p:out STD_LOGIC
 );
 end component;
signal pass,rst:STD_LOGIC;
signal counter:integer:=0;
begin
Au1:Authentication_Logic port map(a=>face,b=>hand,c=>reset,r=>rst,p=>pass,o=>counter);
number_of_enteries <= counter;
end Behavioral;