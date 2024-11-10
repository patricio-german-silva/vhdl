----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2024 11:14:14 AM
-- Design Name: 
-- Module Name: MyFFD - Behavioral
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

entity MyFFD is
    Port ( piClk : in STD_LOGIC;
           piRst : in STD_LOGIC;
           piPst : in STD_LOGIC; -- o_O reset a '1'?
           piEna : in STD_LOGIC;
           piD : in STD_LOGIC;
           poQ : out STD_LOGIC
    );
end MyFFD;

architecture A_MyFFD of MyFFD is
signal data: STD_LOGIC;
begin

    process(piClk, piEna, piRst, piPst, piD)
    begin
        if piRst = '1' then
            data <= '0';
        elsif  piPst = '1' then
            data <= '1';
        elsif rising_edge(piClk) then
			if piEna = '1' then
				data <= piD;
			end if;	
        end if;        
	end process;
	
	poQ <= data;
	--poNQ <= not data;

end A_MyFFD;
