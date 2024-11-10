----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2024 06:15:42 PM
-- Design Name: 
-- Module Name: UpDownCounter_TB - Behavioral
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

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UpDownCounter_TB is
end UpDownCounter_TB;


architecture A_UpDownCounter_TB of UpDownCounter_TB is

component UpDownCounter is
    Generic (NBits: natural := 25;
	         Max: natural := 25000000);
    Port (  piClk : in STD_LOGIC;
            piEna : in STD_LOGIC;
            piRst : in STD_LOGIC;
            piUpDown : in STD_LOGIC;
            poCount : out STD_LOGIC_VECTOR(NBits-1 downto 0)
		 );	
end component UpDownCounter;

signal clk, ena, rst, updown: std_logic;
signal x4: std_logic_vector(4-1 downto 0);
begin

	instBb: UpDownCounter
		generic map( NBits => 4, Max => 6)
		port map(piClk => clk, piEna => ena, piRst => rst, piUpDown => updown, poCount => x4);
		
	pClk: process
	begin
		clk <= '1';
		wait for 10 ns;
		clk <= '0';
		wait for 10 ns;
	end process;	
	
	
	process
	begin
		rst <= '1';
		ena <= '0';
		updown <= '1';
		wait for 40 ns;
		rst <= '0';
		wait until falling_edge(clk);
		ena <= '1';
		wait for 1000 ns;
		wait until falling_edge(clk);
		rst <= '1';
		ena <= '0';
		updown <= '0';
		wait for 40 ns;
		wait until falling_edge(clk);
		rst <= '0';
		ena <= '1';
		wait until falling_edge(clk);
		wait for 1000 ns;
		wait until falling_edge(clk);
		ena <= '0';
		wait;
	end process;
    
    
end A_UpDownCounter_TB;