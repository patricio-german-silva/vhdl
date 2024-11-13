----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2024 04:04:23 PM
-- Design Name: 
-- Module Name: UaRx_TB - Behavioral
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

entity UaRx_TB is
--  Port ( );
end UaRx_TB;

architecture Behavioral of UaRx_TB is
   component UaRx is
    Generic ( RxDIV: NATURAL:= 10417); -- 100Mhz/DIV -> 9600 baud
    Port (  piUaRxClk : in STD_LOGIC; -- Clock de entrada
            piUaRxRst : in STD_LOGIC; -- Reset

            piUaRxEna : in STD_LOGIC; -- RX Enable
            piUaRxRx : in STD_LOGIC;    -- Puerto RX
            poUaRxC: out STD_LOGIC; -- Receive complete - Hay datos para leer en el buffer poUaRxData 
            poUaRxData : out STD_LOGIC_VECTOR (8-1 downto 0)
    );
   end component UaRx;

   signal clk, rst, rxena, rx, rxc: STD_LOGIC;
   signal rxdata: STD_LOGIC_VECTOR(8-1 downto 0);
   constant data: STD_LOGIC_VECTOR(8-1 downto 0) := "10101010";
begin

       instUaRx: UaRx
       generic map(RxDIV => 4)
       Port map ( piUaRxClk => clk,
            piUaRxRst => rst ,
            piUaRxEna => rxena,
            piUaRxRx => rx,
            poUaRxC => rxc,
            poUaRxData => rxdata);

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
       rxena <= '0';
       rx <= '1';
       wait for 63 ns;
       rst <= '0';
       rxena <= '1';

       wait for 63 ns;
       rx <= '0';
       wait for 20 ns;

       for i in 0 to 7 loop
         rx <= data(i);
         wait for 40 ns;
       end loop;

       rx <= '1';
       wait for 30 ns;
       wait;

    end process;

end Behavioral;
