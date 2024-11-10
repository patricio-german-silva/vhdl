----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/04/2024 04:14:28 PM
-- Design Name: 
-- Module Name: Counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
Generic (NBits: natural := 4);
    Port ( piClk : in STD_LOGIC;
           piEna : in STD_LOGIC;
           piRst : in STD_LOGIC;
           poX : out std_logic_vector(NBits-1 downto 0));
end Counter;

architecture Behavioral of Counter is

signal auxCount : unsigned(NBits-1 downto 0);
begin
    process(piClk, piEna, piRst)
    begin
        if piRst = '1' then
            auxCount <= TO_UNSIGNED(0, NBits);
        elsif rising_edge(piClk) and piEna = '1' then
            auxCount <= auxCount + TO_UNSIGNED(1, NBits);
        end if;
    end process;

    poX <= std_logic_vector(auxCount);
end Behavioral;
