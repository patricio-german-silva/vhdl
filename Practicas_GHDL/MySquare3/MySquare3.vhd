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
entity MySquare3 is

    port ( 
        piBits: in std_logic_vector(2 downto 0);
        poResult: out std_logic_vector(5 downto 0)
    );
end entity MySquare3;


-- ARCHITECTURE DECLARATION ------------------------------------------------------------------------
architecture A_MySquare3 of MySquare3 is

begin
    with piBits select
    poResult <= "000001" when "001",
                "000100" when "010",
                "001001" when "011",
                "010000" when "100",
                "011001" when "101",
                "100100" when "110",
                "110001" when "111",
                "000000" when others;
end architecture A_MySquare3;

