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
entity MyFullADD is
    -- generic / port / local declatations
--     generic (N: Natural := 4);
    
    port ( 
        piA: in std_logic;
        piB: in std_logic;
        piCi: in std_logic;
        poS: out std_logic;
        poCo: out std_logic
--         poOUT: out std_logic_vector(N-1 downto 0)  
    );
end entity MyFullADD;


-- ARCHITECTURE DECLARATION ------------------------------------------------------------------------
architecture A_MyFullADD of MyFullADD is
    -- local declarations (use function type file component constant signal procedure subtype alias)
--     signal aux : std_logic;

begin
    poS <= piA xor piB xor piCi;
    poCo <= (piA and piB) or (piCi and (piA xor piB));
end architecture A_MyFullADD;

