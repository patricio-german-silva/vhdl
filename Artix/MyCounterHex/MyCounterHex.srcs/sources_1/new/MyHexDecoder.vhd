----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/01/2024 07:54:04 PM
-- Design Name: 
-- Module Name: MyHexDecoder - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MyHexDecoder is
    Port ( piData : in STD_LOGIC_VECTOR (3 downto 0);
           poHexValue : out STD_LOGIC_VECTOR (6 downto 0));
end MyHexDecoder;

--           A B C D E F G
-- 0: 0000 : 1 1 1 1 1 1 0
-- 1: 0001 : 0 1 1 0 0 0 0
-- 2: 0010 : 1 1 0 1 1 0 1
-- 3: 0011 : 1 1 1 1 0 0 1
-- 4: 0100 : 0 1 1 0 0 1 1
-- 5: 0101 : 1 0 1 1 0 1 1
-- 6: 0110 : 1 0 1 1 1 1 1
-- 7: 0111 : 1 1 1 0 0 0 0
-- 8: 1000 : 1 1 1 1 1 1 1
-- 9: 1001 : 1 1 1 1 0 1 1
-- A: 1010 : 1 1 1 0 1 1 1
-- B: 1011 : 0 0 1 1 1 1 1
-- C: 1100 : 1 0 0 1 1 1 0
-- D: 1101 : 0 1 1 1 1 0 1
-- E: 1110 : 1 0 0 1 1 1 1
-- F: 1111 : 1 0 0 0 1 1 1

architecture A_MyHexDecoder of MyHexDecoder is

alias D0: std_logic is piData(0);
alias D1: std_logic is piData(1);
alias D2: std_logic is piData(2);
alias D3: std_logic is piData(3);
alias aux: std_logic_vector(5 downto 0) is poHexValue(5 downto 0);

begin
    poHexValue(6) <= (not D2 and not D0) or (not D3 and D1) or (not D3 and D2 and D0) or (D3 and not D2 and not D1) or (D3 and not D0) or (D2 and D1); -- Segmento A por SoP y Karnaugh
    
    with piData select
        aux <= "111110" when "0000",
               "110000" when "0001",
               "101101" when "0010",
               "111001" when "0011",
               "110011" when "0100",
               "011011" when "0101",
               "011111" when "0110",
               "110000" when "0111",
               "111111" when "1000",
               "111011" when "1001",
               "110111" when "1010",
               "011111" when "1011",
               "001110" when "1100",
               "111101" when "1101",
               "001111" when "1110",
               "000111" when "1111",
               "000000" when others;


end A_MyHexDecoder;
