-- Controla un unico de display de 7 segmentos
-- Recibe 7 bits interpretandolo como un UNSIGNED, entre 0 y 99
-- el Display mostrará el digito correspondiente a la decena.
-- Si el mnumero es multiplo de 10 se muestra la decena, sino se muestra 
-- el valor de la decena y el punto decimal. ej: 30 -> 3
--                                               43 -> 4.
--                                               99 -> 9.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DecToSevSeg is
    port ( 
        piDTSSSData: in std_logic_vector(6 downto 0);
        poDTSSSOutput: out std_logic_vector(7 downto 0)
    );
end entity DecToSevSeg;
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

architecture A_DecToSevSeg of DecToSevSeg is

signal floorvalue, modvalue: UNSIGNED(6 downto 0);

begin

    floorvalue <= UNSIGNED(piDTSSSData) / 10;
    modvalue <= UNSIGNED(piDTSSSData) mod 10;
    with floorvalue(3 downto 0) select
        poDTSSSOutput(7 downto 1) <= "1111110" when "0000",
                      "0110000" when "0001",
                      "1101101" when "0010",
                      "1111001" when "0011",
                      "0110011" when "0100",
                      "1011011" when "0101",
                      "1011111" when "0110",
                      "1110000" when "0111",
                      "1111111" when "1000",
                      "1111011" when "1001",
                      "1110111" when "1010",
                      "0011111" when "1011",
                      "1001110" when "1100",
                      "0111101" when "1101",
                      "1001111" when "1110",
                      "1000111" when "1111",
                      "0000000" when others;
        poDTSSSOutput(0) <= '0' when modvalue = 0 else '1';
end architecture A_DecToSevSeg;

