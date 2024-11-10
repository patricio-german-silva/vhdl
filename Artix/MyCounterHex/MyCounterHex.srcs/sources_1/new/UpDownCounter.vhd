----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2024 06:15:14 PM
-- Design Name: 
-- Module Name: UpDownCounter - Behavioral
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

entity UpDownCounter is
    Generic (NBits: natural := 25;
	         Max: natural := 25000000);
    Port (  piClk : in STD_LOGIC;
            piEna : in STD_LOGIC;
            piRst : in STD_LOGIC;
            piUpDown : in STD_LOGIC;
            poCount : out STD_LOGIC_VECTOR(NBits-1 downto 0)
		 );	
end UpDownCounter;

architecture A_UpDownCounter of UpDownCounter is

signal auxCount: unsigned(NBits-1 downto 0);

begin

    process(piClk, piEna, piRst)
    begin
        if rising_edge(piClk) then
            if piRst = '1' then
                 auxCount <= to_unsigned(0, NBits);
            else
                if piEna = '1' then
                    if piUpDown = '1' then
                        auxCount <= auxCount + to_unsigned(1, NBits);
                        if auxCount = to_unsigned(Max-1, NBits) then
                            auxCount <= to_unsigned(0, NBits);
                        end if;
                     else
                        auxCount <= auxCount - to_unsigned(1, NBits);
                        if auxCount = to_unsigned(0, NBits) then
                            auxCount <= to_unsigned(Max, NBits);
                        end if;
                     end if;
                end if;	
            end if;
        end if;        
	end process;
	
	poCount <= std_logic_vector(auxCount);
	
    
end A_UpDownCounter;
