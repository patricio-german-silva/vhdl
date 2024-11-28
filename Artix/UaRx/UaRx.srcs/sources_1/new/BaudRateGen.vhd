----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2024 05:32:34 PM
-- Design Name: 
-- Module Name: BaudRateGen - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: contador de modulo que genera un pulso de inizializacion de 
--                1/2 periodo y luego continua a periodo configurado 
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

entity BaudRateGen is
    Generic (NBits: natural := 25;
            Max: natural := 25000000;        -- Periodo
            First: natural := 13500000);     -- subperiodo para el primer pulso
    Port (  piBRGClk : in STD_LOGIC;
            piBRGEna : in STD_LOGIC;
            piBRGRst : in STD_LOGIC;
            poBRGO : out STD_LOGIC
       );   
end BaudRateGen;

architecture A_BaudRateGen of BaudRateGen is

signal auxCount: unsigned(NBits-1 downto 0) := to_unsigned(0, NBits);

begin

    process(auxCount, piBRGClk, piBRGEna, piBRGRst)
    begin
        if rising_edge(piBRGClk) then
           if piBRGRst = '1' then
               auxCount <= to_unsigned(First, NBits);
           elsif piBRGEna = '1' then
               if auxCount = to_unsigned(0, NBits) then
                  auxCount <= to_unsigned(Max-1, NBits);
               else
                  auxCount <= auxCount - to_unsigned(1, NBits);
               end if;
           end if;   
        end if;        
   end process;
   
   poBRGO <= '0' when piBRGRst = '1' else 
             '0' when piBRGEna = '0' else 
             '1' when auxCount = to_unsigned(0, NBits) else '0';
   
    
end A_BaudRateGen;
