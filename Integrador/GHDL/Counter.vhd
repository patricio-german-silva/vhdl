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
-- Description: Contador de modulo doble
-- Cada Max numero de clocks va ciclando poCTRX entre 0 y NVal
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
Generic (NBitsMax: natural := 28;
         NBitsVal: natural := 2;
         Max: natural := 100000000;
         NVal: natural := 4);
    Port ( piCTRClk : in STD_LOGIC;
           piCTREna : in STD_LOGIC;
           piCTRRst : in STD_LOGIC;
           poCTRX : out std_logic_vector(NBitsVal-1 downto 0));
end Counter;

architecture A_Counter of Counter is

signal count : unsigned(NBitsMax-1 downto 0) := TO_UNSIGNED(0, NBitsMax);
signal val : unsigned(NBitsVal-1 downto 0) := TO_UNSIGNED(0, NBitsVal);
begin
    process(piCTRClk, piCTREna, piCTRRst)
    begin
        if piCTRRst = '1' then
            count <= TO_UNSIGNED(0, NBitsMax);
            val <= TO_UNSIGNED(0, NBitsVal);
        elsif rising_edge(piCTRClk) and piCTREna = '1' then
            count <= count + TO_UNSIGNED(1, NBitsMax);
            if count = TO_UNSIGNED(Max-1, NBitsMax) then
                count <= TO_UNSIGNED(0, NBitsMax);
                val <= val + TO_UNSIGNED(1, NBitsVal);
                if val = TO_UNSIGNED(NVal-1, NBitsVal) then
                    val <= TO_UNSIGNED(0, NBitsVal);
                end if;
            end if;
        end if;
    end process;

    poCTRX <= std_logic_vector(val);
end A_Counter;
