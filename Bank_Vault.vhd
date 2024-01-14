----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:41:06 01/01/2023 
-- Design Name: 
-- Module Name:    Bank_Vault - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Bank_Vault is
port (
        door1, door2, alert, water, gas, holes: out std_logic;
		  number_of_enteries : out integer;
         
		  exSen, wSen, reset, clk,clr,magnet,handIn, faceIn,faceOut,handOut: in std_logic;
        inSen: in std_logic_vector(2 downto 0)
    );
end Bank_Vault;

architecture Behavioral of Bank_Vault is

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
component Authentication_Component_Out is
port(a,b,c:in STD_LOGIC;
r,p:out STD_LOGIC
 );
 end component;
 component Authentication_Component_In is
port(a,b:in STD_LOGIC;
p:out STD_LOGIC;
o: out integer
 );
 end component;
signal pass,passOut,rst:STD_LOGIC;
signal counter:integer:=0;


type state is (
start, 
door_state1, 
door_state2, 
alert_state, 
sen);

signal present_state, next_state : state;



type states is (
Normal,
Vlt_dr1,
Vlt_dr2,
Vlt_b_cls,
Cls_dr_danger,
Water0,
Gas0,
Water_or_Gas_closed,
Holes0
);

signal pre_state,ne_state: states;

begin

Au1:Authentication_Component_In port map(a=>faceIn,b=>handIn,p=>pass,o=>counter);--

door: vault_door port map(authenticator => pass, door_speed => order, door_state => door2);
Au2:Authentication_Component_Out port map(a=>faceOut,b=>handOut,c=>reset,p=>passOut,r=>rst);
 number_of_enteries<=counter;

clk_process: process(clk,clr)
begin
	
	
if(clr = '1') then 
	pre_state<=Normal;
	present_state<=start;
	
elsif ( rising_edge(clk)) then 
pre_state<=ne_state;
present_state<=next_state;
end if;
end process;


Vault :process(pre_state,magnet,inSen,wSen,pass,rst,passOut)
begin
case pre_state is
	when Normal =>
			
			water<='0';
			gas<='0';
			holes<='0';
			order<="00";
				
		if(pass = '1' )then 
			ne_state<= Vlt_dr1;
		
		else 
		
			if(inSen="000") then
				ne_state<=Normal;
			else
				if(magnet='0' and passOut='0')then
					ne_state<=Cls_dr_danger;
				
				
				elsif(magnet='1' and passOut='0')then
					ne_state<=Gas0;
				
				end if;
			end if;
		end if;
	
	
	when Vlt_dr1 =>
		water<='0';
		gas<='0';
		holes<='0';
		order<="10";

		if( inSen(0) = '1')then --check
			ne_state<=Vlt_dr2;
			
		else ne_state<=pre_state;
			
		end if;
	
	
	when Vlt_dr2 =>
		water<='0';
		gas<='0';
		holes<='0';
		order<="10";
		if( inSen(0) = '1')then --check
			ne_state<=Vlt_b_cls;
			
		else ne_state<=pre_state;
			
		end if;
	
	
	when Vlt_b_cls =>
		water<='0';
		gas<='0';
		holes<='0';
		order<="10";
		ne_state<= Normal;
	
	
	when Cls_dr_danger =>
		water<='0';
		gas<='0';
		holes<='0';
		order<="01";
		ne_state<= Water0;
				
	
	
	
	When Water0 =>
		water<='1';
		gas<='0';
		holes<='0';
		if(wSen = '1') then
			ne_state<= Water_or_Gas_closed;
			
		else
			ne_state<= Gas0;
			
		end if;
		
	when Water_or_Gas_closed =>
		water<='0';
		gas<='0';
		holes<='0';
		
		if(rst='1') then 
			ne_state<= Holes0;
				
				
		else
			ne_state<= pre_state;
				
			
		end if;
		
		
		
		
	when Holes0 =>
		water<='0';
		gas<='0';
		holes<='1';
		ne_state<= Normal;
		
		
	when Gas0 =>
		water<='0';
		gas<='1';
		holes<='0';
		ne_state<= Water_or_Gas_closed;
		
	when others =>
		
end case;
end process;

ExternalDoor : process( present_state,passOut, exsen,rst)
    begin
        
        case present_state is
        when start =>
				door1<='0';
				alert<='0';
				
            if passOut = '1' then
					next_state <= door_state1;
				elsif passOut = '0' then
					if exsen = '0' then
						next_state <= start;
					elsif exsen = '1' then
						next_state <= alert_state;
					end if;
				end if;
				
				
			when door_state1 =>
				door1<='1';
				alert<='0';
				if exsen = '0' then
					next_state <= door_state1;
				elsif exsen = '1' then
					next_state <= sen;
				end if;
				
				
			when sen =>
				door1<='0';
				alert<='0';
				if exsen = '0' then
					next_state <= sen;
				elsif exsen = '1' then
					next_state <= door_state2;
					--wait
				end if;
			
			
			when door_state2 =>
				door1<='1';
				alert<='0';
				next_state <= start;
				
				
			when alert_state =>
				door1<='0';
				alert<='1';
				if rst = '1' then
					next_state <= start;
				elsif rst = '0' then
					next_state <= alert_state;
				end if;

				
				
			when others =>
        end case;        
    end process; --ExternalDoor






end Behavioral;

