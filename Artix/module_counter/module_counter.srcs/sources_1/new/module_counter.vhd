----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2024 05:32:34 PM
-- Design Name: 
-- Module Name: module_counter - Behavioral
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

library IEEE;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity module_counter is
    Generic (NBits: natural := 25;
	         Max: natural := 25000000);
    Port (  piClk : in STD_LOGIC;
            piEna : in STD_LOGIC;
            piRst : in STD_LOGIC;
            poX : out std_logic
		 );	
end module_counter;

architecture A_module_counter of module_counter is

signal auxCount: unsigned(NBits-1 downto 0);

begin

    process(piClk, piEna, piRst)
    begin
        if piRst = '1' then
            auxCount <= to_unsigned(0, NBits);
        elsif rising_edge(piClk) then
			if piEna = '1' then
				auxCount <= auxCount + to_unsigned(1, NBits);
				if auxCount = to_unsigned(Max-1, NBits) then
					auxCount <= to_unsigned(0, NBits);
				end if;
			end if;	
        end if;        
	end process;
	
	poX <= '1' when auxCount = to_unsigned(0, NBits) else '0';
	
    
end A_module_counter;