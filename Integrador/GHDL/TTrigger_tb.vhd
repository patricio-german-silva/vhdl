----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2024 05:36:16 PM
-- Design Name: 
-- Module Name: TTrigger_tb - Behavioral
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

entity TTrigger_TB is
end TTrigger_TB;


architecture A_TTrigger_TB of TTrigger_TB is

component TTrigger is
    Generic (NBits: natural;
	         Max: natural);
    Port (  piTTClk : in STD_LOGIC;
            piTTEna : in STD_LOGIC;
            piTTRst : in STD_LOGIC;
            poTTO : out std_logic
		 );	
end component TTrigger;

signal clk, ena, rst, x1, x2, x3, x12 : std_logic;

begin
	
	instBb1: TTrigger
		generic map( NBits => 3, Max => 1)
		port map(piTTClk => clk, piTTEna => ena, piTTRst => rst, poTTO => x1);

	instBb2: TTrigger
		generic map( NBits => 3, Max => 2)
		port map(piTTClk => clk, piTTEna => ena, piTTRst => rst, poTTO => x2);
	
	instBb3: TTrigger
		generic map( NBits => 3, Max => 3)
		port map(piTTClk => clk, piTTEna => ena, piTTRst => rst, poTTO => x3);

	instBb12: TTrigger
		generic map( NBits => 4, Max => 12)
		port map(piTTClk => clk, piTTEna => ena, piTTRst => rst, poTTO => x12);
		
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
		wait for 40 ns;
		rst <= '0';
		wait until falling_edge(clk);
		ena <= '1';
		wait for 500 ns;
		wait until falling_edge(clk);

		ena <= '0';
		rst <= '1';
		wait until falling_edge(clk);
		rst <= '0';
		wait for 150 ns;
		ena <= '1';

		wait;
	end process;
    
    
end A_TTrigger_TB;
