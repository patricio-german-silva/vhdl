----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2024 05:32:34 PM
-- Design Name: 
-- Module Name: ModuleCounter - Behavioral
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

entity ModuleCounter is
    Generic (NBits: natural := 25;
	         Max: natural := 25000000);
    Port (  piMCClk : in STD_LOGIC;
            piMCEna : in STD_LOGIC;
            piMCRst : in STD_LOGIC;
            poMCO : out std_logic
		 );	
end ModuleCounter;

architecture A_ModuleCounter of ModuleCounter is

signal auxCount: unsigned(NBits-1 downto 0) := to_unsigned(0, NBits);

begin

    process(piMCClk, piMCEna, piMCRst)
    begin
        if piMCRst = '1' then
            auxCount <= to_unsigned(0, NBits);
        elsif rising_edge(piMCClk) then
			if piMCEna = '1' then
				auxCount <= auxCount + to_unsigned(1, NBits);
				if auxCount = to_unsigned(Max-1, NBits) then
					auxCount <= to_unsigned(0, NBits);
				end if;
			end if;	
        end if;        
	end process;
	
    poMCO <= '0' when piMCRst = '1' else
             '0' when piMCEna = '0' else
             '1' when auxCount = to_unsigned(Max-1, NBits) else '0';
	
    
end A_ModuleCounter;
