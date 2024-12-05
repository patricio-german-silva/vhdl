----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2024 05:32:34 PM
-- Design Name: 
-- Module Name: TTrigger - Behavioral
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

use ieee.numeric_std.all;

entity TTrigger is
    Generic (NBits: natural := 25;
	         Max: natural := 25000000);
    Port (  piTTClk : in STD_LOGIC;
            piTTEna : in STD_LOGIC;
            piTTRst : in STD_LOGIC;
            poTTO : out std_logic
		 );	
end TTrigger;

architecture A_TTrigger of TTrigger is

signal auxCount: unsigned(NBits-1 downto 0) := TO_UNSIGNED(0, NBits);
signal trigger: STD_LOGIC := '0';

begin

    process(piTTClk, piTTEna, piTTRst, trigger)
    begin
        if piTTRst = '1' then
            auxCount <= to_unsigned(0, NBits);
            trigger <= '0';
        elsif rising_edge(piTTClk) then
			if (piTTEna = '1') and (trigger = '0') then
				auxCount <= auxCount + to_unsigned(1, NBits);
				if auxCount = to_unsigned(Max-1, NBits) then
					trigger <= '1';
				end if;
			end if;	
        end if;        
	end process;
	
    poTTO <= trigger;
	
    
end A_TTrigger;
