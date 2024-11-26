----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2024 05:41:18 PM
-- Design Name: 
-- Module Name: Counter_tb - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter_tb is
--  Port ( );
end Counter_tb;

architecture Behavioral of Counter_tb is

component Counter is
    Generic (NBitsMax: natural := 28;
         NBitsVal: natural := 2;
         Max: natural := 100000000;
         NVal: natural := 4);
    Port ( piCTRClk : in STD_LOGIC;
           piCTREna : in STD_LOGIC;
           piCTRRst : in STD_LOGIC;
           poCTRO : out std_logic;
           poCTRV : out std_logic_vector(NBitsVal-1 downto 0));
end component;

signal Clk, Ena, Rst, o : std_logic;
signal v: std_logic_vector(2-1 downto 0);

  
begin
    instCounter: Counter
    generic map( NBitsMax => 3,
                 NBitsVal => 2,
                 Max => 5,
                 NVal => 3)
    port map(piCTRClk => Clk,
            piCTREna => Ena,
            piCTRRst => Rst,
            poCTRO => o,
            poCTRV => v
     );

    pClk: process
    begin
        Clk <= '1';
        wait for 5 ns;
        Clk <= '0';
        wait for 5 ns;
    end process;
      
    process
    begin
        Rst <= '1';
        Ena <= '0';
        wait until falling_edge(Clk);
      
        Rst <= '0';
        ena <= '1';
        wait for 100 ns;
        ena <= '0';
        wait for 100 ns;
        ena <= '1';
        wait;
     end process;
     
     
end Behavioral;

