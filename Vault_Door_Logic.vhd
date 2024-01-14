-- vault door 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vault_door is
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
end vault_door;

architecture Behavioral of vault_door is
begin
    door_state <= authenticator and door_speed(1) and not door_speed(0);
end Behavioral;