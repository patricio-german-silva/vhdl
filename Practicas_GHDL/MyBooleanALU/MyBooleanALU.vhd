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
entity MyBooleanALU is

    port ( 
      piData1 : in STD_LOGIC_VECTOR (3 downto 0);
      piData2 : in STD_LOGIC_VECTOR (3 downto 0);
      piOpCode : in STD_LOGIC_VECTOR (2 downto 0);
      poResult : out STD_LOGIC_VECTOR (3 downto 0);
      poZeroFlag : out STD_LOGIC;
      poOneFlag : out STD_LOGIC
    );
end entity MyBooleanALU;


-- ARCHITECTURE DECLARATION ------------------------------------------------------------------------
architecture A_MyBooleanALU of MyBooleanALU is
signal result : STD_LOGIC_VECTOR (3 downto 0);
begin
    with piOpCode select
        result <=   piData1 and piData2  when "000",
                    piData1 nand piData2 when "001",
                    piData1 or piData2   when "010",
                    piData1 nor piData2  when "011",
                    piData1 xor piData2  when "100",
                    piData1 xnor piData2 when "101",
                    "1111"               when "110",
                    "0000" when others;
                    
    poZeroFlag <= '1' WHEN result = "0000" else '0';
    poOneFlag  <= '1' WHEN result = "1111" else '0';
    poResult <= result;
end architecture A_MyBooleanALU;

