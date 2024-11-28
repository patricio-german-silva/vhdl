----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2024 04:04:23 PM
-- Design Name: 
-- Module Name: IMain_TB - Behavioral
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

entity IMain_TB is
--  Port ( );
end IMain_TB;

architecture Behavioral of IMain_TB is
   component UaRx is
    Generic ( RxDIV: NATURAL:= 10417); -- 100Mhz/DIV -> 9600 baud
    Port (  piIMainClk : in STD_LOGIC; -- Clock de entrada
            piIMainRst : in STD_LOGIC; -- Reset
            piIMainEna : in STD_LOGIC; -- RX Enable
            piIMainRx : in STD_LOGIC;    -- Puerto RX
            poIMainC: out STD_LOGIC; -- Receive complete - Hay datos para leer en el buffer poIMainData 
            poIMainData : out STD_LOGIC_VECTOR (8-1 downto 0)
    );
   end component UaRx;

   signal clk, rst, ena, rx, rxc: STD_LOGIC;
   signal data: STD_LOGIC_VECTOR(8-1 downto 0);
   signal test: STD_LOGIC_VECTOR(9 downto 0);
begin

       instIMain: UaRx
       generic map(RxDIV => 4)
       Port map ( piIMainClk => clk,
            piIMainRst => rst,
            piIMainEna => ena,
            piIMainRx => rx,
            poIMainC => rxc,
            poIMainData => data);

   pClk: process
	begin
		clk <= '1';
		wait for 5 ns;
		clk <= '0';
		wait for 5 ns;
	end process;	


    process
    begin
       rst <= '1';
       ena <= '0';
       rx <= '1';
       wait for 33 ns;
       rst <= '0';
       ena <= '1';
       
       test <= "0101010100";  -- bad frame, no stop bit
       wait for 33 ns;
       for i in 0 to 9 loop
           rx <= test(i);
           wait for 40 ns;
       end loop;

       test <= "1101010100";
       for i in 0 to 9 loop
           rx <= test(i);
           wait for 40 ns;
       end loop;

       wait;

    end process;

end Behavioral;
