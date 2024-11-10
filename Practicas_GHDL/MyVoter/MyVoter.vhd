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
entity MyVoter is
    -- generic / port / local declatations
--     generic (N: Natural := 4);
    
    port ( 
        piX: in std_logic;
        piY: in std_logic;
        piZ: in std_logic;
        poOUT: out std_logic
--         poOUT: out std_logic_vector(N-1 downto 0)  
    );
end entity MyVoter;


-- ARCHITECTURE DECLARATION ------------------------------------------------------------------------
architecture A_MyVoter of MyVoter is
    -- local declarations (use function type file component constant signal procedure subtype alias)
--     signal aux : std_logic;
    signal aux : std_logic_vector(2 downto 0);
begin
    aux <= piX & piY & piZ;
    with aux select
    poOUT <=  '0' when "000",
              '0' when "001",
              '0' when "010",
              '1' when "011",
              '0' when "100",
              '1' when "101",
              '1' when "110",
              '1' when "111",
              '0' when others;
end architecture A_MyVoter;

