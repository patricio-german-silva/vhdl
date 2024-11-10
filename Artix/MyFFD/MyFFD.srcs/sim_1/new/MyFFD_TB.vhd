----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2024 11:40:59 AM
-- Design Name: 
-- Module Name: MyFFD_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MyFFD_TB is
--  Port ( );
end MyFFD_TB;

architecture Behavioral of MyFFD_TB is

component MyFFD is
    Port ( piClk : in STD_LOGIC;
           piRst : in STD_LOGIC;
           piPst : in STD_LOGIC; -- o_O reset a '1'?
           piEna : in STD_LOGIC;
           piD : in STD_LOGIC;
           poQ : out STD_LOGIC
    );
end component MyFFD;

signal clk, rst, pst, ena, d, q: std_logic;

begin
    instMyFFD: MyFFD
        port map(piClk => clk, piRst => rst, piPst => pst, piEna => ena, piD => d, poQ => q);
        
    pClk: process
	begin
		clk <= '1';
		wait for 10 ns;
		clk <= '0';
		wait for 10 ns;
	end process pClk;	
	
	
    process
        begin
        ena <= '0'; -- inicio todo en 0
        rst <= '0';
        pst <= '0';
        d <= '0';
        wait for 23 ns;
        
        ena <= '1'; -- habilito, esribo 1, deshabilito
        wait for 23 ns;
        d <= '1';
        wait for 23 ns;
        ena <= '0';
        wait for 23 ns; -- hold 1
        
        ena <= '1';  -- habilito, esribo 0, deshabilito
        wait for 23 ns;
        d <= '0';
        wait for 23 ns;
        ena <= '0';
        wait for 23 ns; -- hold 0
        
        pst <= '1'; -- reset a 1 asincrono
        wait for 23 ns;
        pst <= '0';
        wait for 23 ns;
        
        rst <= '1'; -- reset a 0 asincrono
        wait for 23 ns;
        rst <= '0';
        wait for 23 ns;
        
        d <= '1'; -- almaceno 1 orden inverso d -> ena y cambio d con ena en 1, sincrono
        wait for 23 ns;
        ena <= '1';
        wait for 23 ns; -- hold 1
        d <= '0';
        wait for 23 ns;
        ena <= '0';
        wait for 23 ns; -- hold 0
        
        rst <= '1'; -- reset a 0 asincrono
        wait for 40 ns;
        
    end process;

end Behavioral;
