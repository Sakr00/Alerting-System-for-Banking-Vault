-- project
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity projec_of_the_component is
 port (
        door1, door2, alert, water, poison, holes: out std_logic;
        hand, face, exSen, wSen, rest, clk: in std_logic;
        inSen: in std_logic_vector(2 downto 0)
    );
end projec_of_the_component;

architecture Behavioral of projec_of_the_component is
component vault_door is 
port (
            authenticator: in std_logic;

            door_speed: in std_logic_vector(1 downto 0);
            -- state_speed***
            -- first bit(on the left) is state bit that explains the door is open or closed
            -- the bit is equal to 1 if the door is opened and 0 if the door is closed

            -- second bit (on the right) explains the speed of the door
            -- the bit is equal to 1 if speed is high and 0 if speed is low
            door_state: out std_logic
        );
		 end component;
		 
signal p: std_logic;
signal order: std_logic_vector(1 downto 0); -- from sakr


-- jazairy
component Authen is
port(a,b,c:in STD_LOGIC;
o: out integer:=0;
r,p:out STD_LOGIC
 );
 end component;
signal pass,reset:STD_LOGIC;
signal counter:integer:=0;

begin

Au1:Authen port map(a=>face,b=>hand,c=>rest,r=>reset,p=>pass,o=>counter);--

door: vault_door port map(authenticator => pass, door_speed => order, door_state => door2); -- order -> sakr
end Behavioral;