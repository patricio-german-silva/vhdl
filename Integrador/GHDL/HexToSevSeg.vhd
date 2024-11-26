library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HexToSevSeg is
    port ( 
        piHTSSSEna: in std_logic;
        piHTSSSData: in std_logic_vector(3 downto 0);
        poHTSSSOutput: out std_logic_vector(6 downto 0)
    );
end entity HexToSevSeg;
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

architecture A_HexToSevSeg of HexToSevSeg is
    signal data: STD_LOGIC_VECTOR(4 downto 0);
begin
    data <= piHTSSSEna&piHTSSSData;
    with data select
     poHTSSSOutput <= "1111110" when "10000",
                      "0110000" when "10001",
                      "1101101" when "10010",
                      "1111001" when "10011",
                      "0110011" when "10100",
                      "1011011" when "10101",
                      "1011111" when "10110",
                      "1110000" when "10111",
                      "1111111" when "11000",
                      "1111011" when "11001",
                      "1110111" when "11010",
                      "0011111" when "11011",
                      "1001110" when "11100",
                      "0111101" when "11101",
                      "1001111" when "11110",
                      "1000111" when "11111",
                      "0000000" when others;
end architecture A_HexToSevSeg;
