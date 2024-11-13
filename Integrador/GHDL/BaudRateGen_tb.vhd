----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2024 05:36:16 PM
-- Design Name: 
-- Module Name: BaudRateGen_tb - Behavioral
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

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BaudRateGen_TB is
end BaudRateGen_TB;


architecture A_BaudRateGen_TB of BaudRateGen_TB is

component BaudRateGen is
    Generic (NBits: natural;
            Max: natural;
            First: natural);
    Port (  piBRGClk : in STD_LOGIC;
            piBRGEna : in STD_LOGIC;
            piBRGRst : in STD_LOGIC;
            poBRGO : out STD_LOGIC
       );   
end component BaudRateGen;

signal clk, ena, rst, x: std_logic;

begin
   
   instBRG: BaudRateGen
      generic map( NBits => 8, Max => 4, First => 2)
      port map(piBRGClk => clk, piBRGEna => ena, piBRGRst => rst, poBRGO => x);

   pClk: process
   begin
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;
   end process;   
   
   
   process
   begin
      rst <= '1';
      ena <= '0';
      wait for 40 ns;
      rst <= '0';
      wait until falling_edge(clk);
      ena <= '1';
      wait for 500 ns;
      wait until falling_edge(clk);
      rst <= '1';
      wait until falling_edge(clk);
      rst <= '0';
      wait for 500 ns;
      ena <= '0';
      wait;
   end process;
    
    
end A_BaudRateGen_TB;
