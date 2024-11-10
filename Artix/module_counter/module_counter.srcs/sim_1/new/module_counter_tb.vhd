----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2024 05:36:16 PM
-- Design Name: 
-- Module Name: module_counter_tb - Behavioral
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

entity module_counter_TB is
end module_counter_TB;


architecture A_module_counter_TB of module_counter_TB is

component module_counter is
    Generic (NBits: natural;
	         Max: natural);
    Port (  piClk : in STD_LOGIC;
            piEna : in STD_LOGIC;
            piRst : in STD_LOGIC;
            poX : out std_logic
		 );	
end component module_counter;

signal clk, ena, rst, x1, x2, x3, x4: std_logic;

begin
	
	instBb1: module_counter
		generic map( NBits => 3, Max => 1)
		port map(piClk => clk, piEna => ena, piRst => rst, poX => x1);

	instBb2: module_counter
		generic map( NBits => 3, Max => 2)
		port map(piClk => clk, piEna => ena, piRst => rst, poX => x2);
	
	instBb3: module_counter
		generic map( NBits => 3, Max => 3)
		port map(piClk => clk, piEna => ena, piRst => rst, poX => x3);

	instBb4: module_counter
		generic map( NBits => 3, Max => 4)
		port map(piClk => clk, piEna => ena, piRst => rst, poX => x4);
		
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
    
    
end A_module_counter_TB;