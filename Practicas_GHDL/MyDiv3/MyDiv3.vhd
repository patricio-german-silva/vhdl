-- File:
-- Author:
-- Date:
-- Revision:
-- Description:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- use ieee.numeric_bit.all;
-- use std.textio.all;
-- use ieee.std_logic_textio.all;


-- ENTITY DECLARATION ------------------------------------------------------------------------------
entity MyDiv3 is
    -- generic / port / local declatations
--     generic (N: Natural := 4);
    
    port ( 
        piBCD: in std_logic_vector(3 downto 0);
        poOUT: out std_logic_vector(2 downto 0)  
    );
end entity MyDiv3;


-- ARCHITECTURE DECLARATION ------------------------------------------------------------------------
architecture A_MyDiv3 of MyDiv3 is
    -- local declarations (use function type file component constant signal procedure subtype alias)
--     signal aux : std_logic;
    
begin
    with piBCD select
    poOUT <=  "001" when "0011",
              "001" when "0100",
              "001" when "0101",
              "010" when "0110",
              "010" when "0111",
              "010" when "1000",
              "011" when "1001",
              "011" when "1010",
              "011" when "1011",
              "000" when others;
end architecture A_MyDiv3;

