--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:52:19 01/06/2023
-- Design Name:   
-- Module Name:   C:/Users/youss/OneDrive/Desktop/Project/Alert_System_For_Banking_Vault/Final_test.vhd
-- Project Name:  Alert_System_For_Banking_Vault
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Bank_Vault
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Final_test IS
END Final_test;
 
ARCHITECTURE behavior OF Final_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Bank_Vault
    PORT(
         door1 : OUT  std_logic;
         door2 : OUT  std_logic;
         alert : OUT  std_logic;
         water : OUT  std_logic;
         gas : OUT  std_logic;
         holes : OUT  std_logic;
         number_of_enteries : OUT  integer;
         exSen : IN  std_logic;
         wSen : IN  std_logic;
         reset : IN  std_logic;
         clk : IN  std_logic;
         clr : IN  std_logic;
         magnet : IN  std_logic;
         handIn : IN  std_logic;
         faceIn : IN  std_logic;
         faceOut : IN  std_logic;
         handOut : IN  std_logic;
         inSen : IN  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal exSen : std_logic := '0';
   signal wSen : std_logic := '0';
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal clr : std_logic := '0';
   signal magnet : std_logic := '0';
   signal handIn : std_logic := '0';
   signal faceIn : std_logic := '0';
   signal faceOut : std_logic := '0';
   signal handOut : std_logic := '0';
   signal inSen : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal door1 : std_logic;
   signal door2 : std_logic;
   signal alert : std_logic;
   signal water : std_logic;
   signal gas : std_logic;
   signal holes : std_logic;
   signal number_of_enteries : integer;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Bank_Vault PORT MAP (
          door1 => door1,
          door2 => door2,
          alert => alert,
          water => water,
          gas => gas,
          holes => holes,
          number_of_enteries => number_of_enteries,
          exSen => exSen,
          wSen => wSen,
          reset => reset,
          clk => clk,
          clr => clr,
          magnet => magnet,
          handIn => handIn,
          faceIn => faceIn,
          faceOut => faceOut,
          handOut => handOut,
          inSen => inSen
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		clr<='1';
      wait for 100 ns;
		
---------------------------------------------------------------------	
--Manegar Senario	
		--clr<='0';
		--faceOut<='1';
		--handOut<='1';
		--wait for clk_period;
		--exSen<='1';
		--wait for clk_period;
		--exSen<='0';
		--faceIn<='1';
		--handIn<='1';
		--wait for clk_period;
		--inSen<="001";
		--wait for clk_period;
		--inSen<="011";	
		--wait for clk_period;
		--inSen<="000";
		
		--faceIn<='0';
		--handIn<='0';
		--wait for clk_period*5;
		--exSen<='1';
		--wait for clk_period;
		--exSen<='0';
		--faceOut<='0';
		--handOut<='0';
-----------------------------------------------------------------------		
--Thief Senario 1 ( the door is opened manually and then the theif succeded to make a hole in the vault before the water fills the vault)
		--clr<='0';
		--exSen<='1';
		--wait for clk_period*5;
		--exSen<='0';
		--inSen<="110";
		--magnet<='0';
		--wait for clk_period;
		--wSen<='0';
		--wait for clk_period;
		--faceOut<='1';
		--handOut<='1';
		--reset<='1';
		
		--wait for clk_period;
----------------------------------------------------------------------
--Thief Senario 2 (the door is opened manually )
		--clr<='0';
		--exSen<='1';
		--wait for clk_period*5;
		--exSen<='0';
		--inSen<="110";
		--magnet<='0';
		--wait for clk_period;
		--wSen<='1';
		--wait for clk_period;
		--faceOut<='1';
		--handOut<='1';
		--reset<='1';
		
		--wait for clk_period;
----------------------------------------------------------------------	
--Thief Senario 3 (the vault's door is closed and the there is a hole in the vault )
		clr<='0';
		exSen<='1';
		wait for clk_period*5;
		exSen<='0';
		inSen<="110";
		magnet<='1';
		wait for clk_period;
		faceOut<='1';
		handOut<='1';
		reset<='1';
		wait for clk_period;
      -- insert stimulus here 

      wait;
   end process;

END;
