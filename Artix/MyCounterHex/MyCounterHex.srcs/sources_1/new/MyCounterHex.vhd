----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/18/2024 04:40:03 PM
-- Design Name: 
-- Module Name: MyCounterHex - Behavioral
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MyCounterHex is
    Port ( CLK : in STD_LOGIC;
           ENA: in STD_LOGIC;
           RST: in STD_LOGIC;
           MODE: in STD_LOGIC;
           HexValue : out STD_LOGIC_VECTOR(6 downto 0)
    );

end MyCounterHex;

architecture A_MyCounterHex of MyCounterHex is
signal clk1s: std_logic;
signal count: std_logic_vector(3 downto 0);

begin

instModuleCounter: entity work.ModuleCounter(A_ModuleCounter)
    generic map(NBits => 4, Max => 25000000)
    port map(piClk => CLK, piEna => ENA, piRst => RST, poX => clk1s);
 
instUpDownCounter: entity work.UpDownCounter(A_UpDownCounter)
    generic map(NBits => 4, Max => 15)
    port map(piClk => clk1s,  piEna => CLK, piRst => RST, piUpDown => MODE, poCount => count);
   
instMyHexDecoder: entity work.MyHexDecoder(A_MyHexDecoder)
    port map(piData => count, poHexValue => HexValue);


end A_MyCounterHex;
