----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/04/2024 05:23:17 PM
-- Design Name: 
-- Module Name: Debounce_TB - Behavioral
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

entity Debounce_TB is
--  Port ( );
end Debounce_TB;

architecture A_Debounce_TB of Debounce_TB is
component Debounce is
Generic (NBits: natural := 26;
         Max: natural := 50000000);
    Port ( piClk : in STD_LOGIC;
           piEna : in STD_LOGIC;
           piRst : in STD_LOGIC;
           poX : out std_logic);
end component;

signal clk, ena, rst, x : std_logic;
begin
    instBd: Debounce
        generic map(NBits => 1, Max => 2)
        port map(piClk => clk, piEna => ena, piRst => rst, poX => x);
        
        pClk: process
        begin   
            clk <= '1';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end process;
        
        

end A_Debounce_TB;
