----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2024 05:36:16 PM
-- Design Name: 
-- Module Name: ModuleCounter_tb - Behavioral
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

entity ModuleCounter_TB is
end ModuleCounter_TB;


architecture A_ModuleCounter_TB of ModuleCounter_TB is

component ModuleCounter is
    Generic (NBits: natural;
	         Max: natural);
    Port (  piMCClk : in STD_LOGIC;
            piMCEna : in STD_LOGIC;
            piMCRst : in STD_LOGIC;
            poMCO : out std_logic
		 );	
end component ModuleCounter;

signal clk, ena, rst, x1, x2, x3, x12 : std_logic;

begin
	
	instBb1: ModuleCounter
		generic map( NBits => 3, Max => 1)
		port map(piMCClk => clk, piMCEna => ena, piMCRst => rst, poMCO => x1);

	instBb2: ModuleCounter
		generic map( NBits => 3, Max => 2)
		port map(piMCClk => clk, piMCEna => ena, piMCRst => rst, poMCO => x2);
	
	instBb3: ModuleCounter
		generic map( NBits => 3, Max => 3)
		port map(piMCClk => clk, piMCEna => ena, piMCRst => rst, poMCO => x3);

	instBb12: ModuleCounter
		generic map( NBits => 4, Max => 12)
		port map(piMCClk => clk, piMCEna => ena, piMCRst => rst, poMCO => x12);
		
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
		wait for 1000 ns;
		wait until falling_edge(clk);
		ena <= '0';
		wait;
	end process;
    
    
end A_ModuleCounter_TB;
